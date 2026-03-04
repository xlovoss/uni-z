# feb 2023
# r script for simulation of GARCH
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

#is an example from Verbeek 

# ------------------------------------------------------------------------------
# Step 1
# ------------------------------------------------------------------------------

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load packages
# ------------------------------------------------------------------------------

library(denstrip)
library(tseries)
library(fGarch)
library(zoo)
library(rugarch)
library(moments)

data_table <- read.table("GML_04_03 usdeur.csv", header=TRUE, sep=";",dec=",")

usd  <- data_table$usd
dates <- data_table$Date

DateStamp = as.Date(dates,format="%d.%m.%Y")
zusd = zoo(usd,DateStamp)

zFX <- na.omit(zusd)
FX = coredata(zFX)

x11()
#Figure 8.12
plot(zFX, ylim = c(-6,6), main = "Figure 8.12: daily change in log USD/EUR")
length(zFX)

summary(FX)
kurtosis(FX)
skewness(FX)
set.seed(123)
skewness(rnorm(1000,0,1))#zum Vgl

adf.test(zFX)#series is stationary

x11()
acf(FX, main = "ACF of daily change in log USD/EUR")
x11()
acf(FX^2, main = "ACF of SQUARED daily change in log USD/EUR")

# ------------------------------------------------------------------------------
# Step 2
# ------------------------------------------------------------------------------
#test for ARCH as in Schwarz FOM Skript--------------------------
olstest = lm(FX ~ 1)
olstest 
rt = residuals(olstest)
rt = rt[-1]
rt_1 = residuals(olstest)
rt_1 = rt_1[-length(rt_1)]

summary(lm(rt^2 ~ rt_1^2))

# ------------------------------------------------------------------------------
# Step 3
# ------------------------------------------------------------------------------
#=============================================================================
# NOW garch (danielsson, 2011) but notation as in fGarch Docu by WurtzEtAlGarch.pdf
#=============================================================================

fit0 <- garchFit(~garch(1,1),cond.dist = "norm", data=FX,include.mean = T, trace = FALSE)
summary(fit0) #see Gehrke 2022 393ff
#hence set mue to zero
fit1 <- garchFit(~garch(1,1),cond.dist = "norm", data=FX,include.mean = F, trace = FALSE)
fit1@fit$llh
fit1@fit$ics
coef(fit1)

summary(fit1) #see Gehrke 2022 393ff

predict(fit1, n.ahead = 3)
# ------------------------------------------------------------------------------
# Step 4
# ------------------------------------------------------------------------------

#-----------------------------------------------------------------------------

fit2 <- garchFit(~garch(1,1),cond.dist = "std", data=FX,include.mean = FALSE, 
			include.delta = FALSE,  trace = FALSE)
fit2@fit$llh
fit2@fit$ics
coef(fit2)
summary(fit2)

# ------------------------------------------------------------------------------
# Step 5
# ------------------------------------------------------------------------------

#=============================================================================
# NOW EGarch (Schröder) 
#=============================================================================

eGARCH_SET<-ugarchspec(variance.model = list(model="eGARCH",garchOrder=c(1,1)),mean.model = list(armaOrder=c(0,0),include.mean=FALSE))
fit3 <- ugarchfit(spec=eGARCH_SET,data =FX,solver="hybrid")
coef(fit3)
str(fit3)
#eGARCH_VOLA <- as.numeric(ugarchforecast(fit3, n.ahead=1)@forecast[["sigmaFor"]])*sqrt(252)

#compare
summary(fit1)
summary(fit2)
fit3

#=============================================================================
# LR Test
#=============================================================================

#LR Test
LR = fit1@fit$llh
LU = fit2@fit$llh

#test_stat as in Danielsson p 45 6 verbeek p191
#H0 restriction for shape is correct, 
#L2 is Unrestricted cause free shape
LR_stats = 2*(LU-LR)
noofrestrictions = 1 #shape is set to infinity to make it normal
LR_crit = qchisq(0.99, noofrestrictions )

LR_crit
LR_stats
#p-val, H0: restriction is true
round(2*pchisq(-abs(LR_stats),noofrestrictions ),5)

# ------------------------------------------------------------------------------
# Step 6
# ------------------------------------------------------------------------------
#=============================================================================
# Apply GARCH student t
#=============================================================================

fit2
Omega = coef(fit2)[1]
Alpha = coef(fit2)[2]
Beta = coef(fit2)[3]
Shape = coef(fit2)[4]

predict(fit2, n.ahead = 3)

std_res1 <- fit2@residuals/fit2@sigma.t #this standardizes the residuals to mean = 0, s=1

x11()
plot(std_res1, type = 'l')

kernel_den = density(std_res1)
x11()
plot(kernel_den, main="Standardized residuals vs Student t Density", xlab = " ")
x <- seq(min(kernel_den$x),max(kernel_den$x),length = 1000)
std_den = dstd(x,mean = mean(std_res1),sd = sd(std_res1), nu = Shape)
lines(x,std_den,type="l",col="red")

#=============================================================================
# analyze the standardized residuals from the model
#=============================================================================
x11()
acf(std_res1, main="ACF for Student t residuals")
x11()
acf(std_res1^2, main="ACF for SQUARED Student t residuals")

#=============================================================================
# do QQ & KS
#=============================================================================
x11()
plot(qstd(ppoints(std_res1), mean = mean(std_res1),sd = sd(std_res1), nu = Shape), 
		sort(std_res1), main="QQ Plot of residuals", xlab = "Quantile", ylab = "Empirical Quantile")
abline(a=0, b=1)

#end



