#feb 2023, FL


# ------------------------------------------------------------------------------
# STEP 1
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------

rm(list = ls())

library(tseries)
#library(egcm)

#---------------------------------------------------------------------
#diese auskommentierte Sektion zeigt, wo die Daten herkommen
#beginDate = as.Date("2010-01-01")
#endDate = as.Date("2016-01-01")
#quote = c("Open", "High", "Low", "Close","Volume")
#compression = "d"
#provider = "yahoo"
#retclass = c("zoo", "its", "ts")
# Daten runterladen 
#thyssenkrupp = get.hist.quote(instrument='TKA.DE',start = beginDate, end = endDate,
  #                             quote = quote, provider = provider, method = NULL,
   #                            origin = "1899-12-30", compression = compression,
     #                          retclass = retclass, quiet = TRUE, drop = FALSE)
#thyssenkruppStock = thyssenkrupp

#SalzgitterAG  = get.hist.quote(instrument='SZG.DE',start = beginDate, end = endDate,
 #                              quote = quote, provider = provider, method = NULL,
   #                            origin = "1899-12-30", compression = compression,
     #                          retclass = retclass, quiet = TRUE, drop = FALSE)
#SalzgitterStock = SalzgitterAG  
 
#DAX = get.hist.quote(instrument='^GDAXI',start = beginDate, end = endDate,
   #                            quote = quote, provider = provider, method = NULL,
   #                            origin = "1899-12-30", compression = compression,
     #                          retclass = retclass, quiet = TRUE, drop = FALSE)
#DAXIndex = DAX
#Mergen
#zDataPre <- merge(thyssenkruppStock, SalzgitterStock, DAXIndex) 
#zDataPrice <- zDataPre[complete.cases(zDataPre)]
#nrow(zDataPrice)
#store equity data for following exercises
#OUTPUT<-zDataPrice 
#write.csv2(OUTPUT, file="xxx.csv")   #write.csv2 uses a comma for the decimal point
#---------------------------------------------------------------------

data_table <- read.table("GML_04_02 equities.csv", header=TRUE, sep=";",dec=",")
TK  <- data_table[,2][111:211]
SG <- data_table[,7][111:211]

x11()
plot(TK, ylab = "EUR", xlab = "Zeitindex", type='l', main = "Kurse thyssenkrupp")
x11()
plot(diff(log(TK)),ylab = "Prozent", xlab = "Zeitindex",type='l', main = "Tagesrenditen thyssenkrupp")
abline(h=0)

# ------------------------------------------------------------------------------
# STEP 2
# ------------------------------------------------------------------------------
length(TK)
TS = TK

# Apply usual tests
adf.test(TS)#H0 Non-stat
pp.test(TS)
kpss.test(TS)#H0 Stat

# ------------------------------------------------------------------------------
# STEP 3
# ------------------------------------------------------------------------------

#make sure same degree of integration = I(1)
# Apply usual tests TK:
TS = diff(TK)
adf.test(TS)#H0 Non-stat
pp.test(TS)
kpss.test(TS)#H0 Stat
# Apply usual tests SG:
TS = diff(SG)
adf.test(TS)#H0 Non-stat
pp.test(TS)
kpss.test(TS)#H0 Stat
#confirmed

# ------------------------------------------------------------------------------
# STEP 4
# ------------------------------------------------------------------------------

#check a la Engle Granger
reg = lm(SG ~ TK)
summary(reg)
resis = residuals(reg)#if cointegrated should have nice R²!
# Apply ordinary tests
# Apply usual tests SG:
TS = resis
adf.test(TS)#H0 Non-stat
pp.test(TS)
kpss.test(TS)#H0 Stat

#plotting residuals
x11()
plot(residuals(reg), type='l', ylab = "Spread SG/TK", main = "Full Data")

x11()
plot(residuals(reg)[1:8], type='l', ylab = "Spread", main = "First 8 Days")


# ------------------------------------------------------------------------------
# STEP 5
# ------------------------------------------------------------------------------
#go for ECM

#take resi t-1
lagged_resis = residuals(reg)[-length(residuals(reg))]

regECM = lm(diff(SG)~diff(TK)+lagged_resis-1)
summary(regECM)#as hoped for the coef of ECterm is negative

head(cbind(TK,SG))


# Apply ordinary tests
adf.test(resis )#H0 Non-stat
pp.test(resis )
kpss.test(resis )#H0 Stat
#nevertheless assume coint, based on ADF an pedagogics

#noch ein Kointegrationstest: H0 not cointegrated.
po.test(as.matrix(cbind(TK,SG)))

#a final word
#egcm(SG,TK)#use this also in live

#Ende

