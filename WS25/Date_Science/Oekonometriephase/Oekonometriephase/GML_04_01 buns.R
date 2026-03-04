# Variablen l?schen und Pakete laden------
rm(list=ls(all=TRUE))

library(corrplot)
library(lmtest)
library(sandwich)
library(car)
library(tseries)
library(forecast)
library(stats)
library(fGarch)
#library(rugarch)
#Daten laden--------------
daten = read.csv("GML_04_01 buns.csv")
weekday = daten[,5]

#Wochentage hinzuf?gen
mon = daten$mon <- ifelse(weekday == 0, 1, 0)
tue = daten$tue <- ifelse(weekday == 1, 1, 0)
wed = daten$wed <- ifelse(weekday == 2, 1, 0)
thu = daten$thu <- ifelse(weekday == 3, 1, 0)
fri = daten$fri <- ifelse(weekday == 4, 1, 0)
sat = daten$sat <- ifelse(weekday == 5, 1, 0)
sun = daten$sun <- ifelse(weekday == 6, 1, 0)

x11()
plot(daten$AMOUNT,  type = "l", lty = 1, ylab = "Absatz", xlab = "Tageszaehler", main = "Original-Zeitreihe")

#check pot time trend and corona impact, first lockdown 22 Macrh 2020

daten$date[1879]
tail(daten$date) #data ends in corona time
daycounter = c(1:length(daten$AMOUNT))
covid = rep(0,length(daten$AMOUNT))
covid[1879:length(daten$AMOUNT)] = rep(1, (length(daten$AMOUNT)-1878))
mean(covid)#percentage of covid days

summary(lm(daten$AMOUNT~daycounter+covid))

#Mulitple Lineare Regression-------------

#Lin Reg. final
reg_final = lm(AMOUNT~ daycounter + mon + tue + wed + thu + fri + sat + sun + 
                 BOCHUM_TOTAL + KEMNADE_IN_FLAMMER + holiday + covid + -1 , data = daten)
summary(reg_final, digits = 4)

#Diagnostik zum  Modell------------------

#[A0]: Der Zusammenhang zwischen der abh?ngigen und den unabh?ngigen Variablen muss linear sein.
#RESET-Test
resettest(reg_final) #H0: Kein Spezifikationserror.

#[A3]: Die Varianz der Residuen ist konstant und endlich (Homoskedastizit?t bzw.keine Heteroskedastizit?t)
plot(residuals(reg_final), type='l')

#Breusch-Pagan-Test
bptest(reg_final) #H0: Homoskedastizit?t.
#Ergebnis: Heterosekdastizit?t liegt vor.

#[A4]: Die Residuen d?rfen nicht untereinander korrelieren (keine Autokorrelation).
#Korrelogramm
acf(coredata(residuals(reg_final)), ci = 0.95, lag.max = 20)
#Durbin-Watson-Test
dwtest(reg_final) #HO: Keine Autokorrelation.
#Ergebnis: Autokorrelation liegt vor.

#Da Heteroskedastizitaet und Autokorrelation vorliegen, muss mit HAC SE gearbeitet werden:
coeftest(reg_final)#compare
coeftest(reg_final,vcov=NeweyWest(reg_final))

#[A5]: Es darf kein sehr starker linearer Zusammenhang zwischen den einzelnen erkl?renden Variablen bestehen
#(keine bzw. h?chstens geringe Multikollinearit?t).
#Variance Inflation Factor (VIF)
vif(reg_final)
#Korrelationsmatrix
df <- data.frame(as.matrix(daycounter), daten$mon, daten$tue, daten$wed, daten$thu, daten$fri, daten$sat, daten$sun, 
                 daten$BOCHUM_TOTAL, daten$KEMNADE_IN_FLAMMER, daten$holiday, as.matrix(covid))
corrplot(cor(df))#does not help

#Zeitreihenanaylse Residuen------------------
#acf shows structure

resis = residuals(reg_final)

x11()
plot(resis, type='l')
x11()
#Korrelogramm, für alpha = 1% diesmal weil viele Daten
acf(resis, ci = 0.99, lag.max = 20)
#this will get clear ...
adf.test(resis)
# Phillips-Perron (PP) Test
pp.test(resis)
# Kwiatkowski-Phillips-Schmidt-Shin (KPSS) Test 
kpss.test(resis)


#see https://otexts.com/fpp2/arima-r.html
#variation of the Hyndman-Khandakar algorithm 
#which combines unit root tests, minimisation of the AICc to obtain an ARIMA model
autofitarima <- auto.arima(resis, max.p = 14, max.q = 14, stationary=TRUE)
autofitarima 

x11()
checkresiduals(autofitarima)#evident that GARCH needed

x11()
autoplot(forecast(autofitarima))

x11()
tsdiag(autofitarima)

#deep dive
fitarma21 = arma(resis, order = c(2, 1), include.intercept = F)
summary(fitarma21)#note significant paras!

fitarma11 = arma(resis, order = c(1, 1), include.intercept = F)
summary(fitarma11)#small change in para values, sign same, enjoy inside unit circle

#cross chk forecast. of ARMA11
fitarma11$fitted.values[100]
resis[100]
#hence error100

error100 = resis[100]-fitarma11$fitted.values[100]
error100

forecast101 = 0.96903 * resis[100] -0.92079 * error100
forecast101
fitarma11$fitted.values[101]

#end of chking, go for garch

# --------------------------------------------
# GARCH(1,1) - Normal
# --------------------------------------------

# Modell 1 - Normal GARCH
NormalGgf<-garchFit(~garch(1,1),data=resis,include.mean = F, trace=FALSE)
coef(NormalGgf)
summary(NormalGgf)
#JB Tests (#H0 normal)of normalized resis point to misspecified distribtuion
#Ljung checks independence of resis and sqrd resis, 
#looks good, can keep H0: Indep

# --------------------------------------------
# GARCH(1,1) - skew & more fat
# --------------------------------------------

# hints at potential developmts
SkewedStdGgf<-garchFit(~garch(1,1),data=resis,include.mean = FALSE,cond.dist="sstd", trace=FALSE)
SkewedStdGgf

#include lagged Y
head(cbind(daten$AMOUNT[-1],daten$AMOUNT[-length(daten$AMOUNT)]))

#Lin Reg. w lagged Y
reg_final_extended = lm(AMOUNT[-1] ~ AMOUNT[-length(AMOUNT)] + daycounter[-1] + mon[-1] + tue[-1] + wed[-1] + thu[-1] + fri[-1] + sat[-1]
                        + sun[-1] + 
                 BOCHUM_TOTAL[-1] + KEMNADE_IN_FLAMMER[-1] + holiday[-1] + covid[-1] + -1 , data = daten)
summary(reg_final, digits = 4)
summary(reg_final_extended, digits = 4)

#[A4]: Die Residuen d?rfen nicht untereinander korrelieren (keine Autokorrelation).
acf(coredata(residuals(reg_final)), ci = 0.99, lag.max = 20)
acf(coredata(residuals(reg_final_extended)), ci = 0.99, lag.max = 20)
#Durbin-Watson-Test
dwtest(reg_final_extended) #HO: Keine Autokorrelation.
dwtest(reg_final)
#Ergebnis: Autokorrelation ist weg.

#Breusch-Pagan-Test
bptest(reg_final_extended) #H0: Homoskedastizit?t.
#Ergebnis: Heterosekdastizitaet liegt vor.

#deshalb:
#manchmal muss man ausprobieren mit den Ans?tzen bis es l?uft numerisch (-> R Hilfe!), oder Wechsel auf
coeftest(reg_final_extended)
coeftest(reg_final_extended,vcov = vcovHC(reg_final_extended, type = "HC0"))#White estimator


#Ende