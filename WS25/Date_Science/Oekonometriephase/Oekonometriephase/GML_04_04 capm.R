# feb 2023
# r script for estimation of CAPM 
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

#CAPM data from example in Verbeek book ch 2, pls read the stuff to get the background
#also read Schroeder 2002, chapter on CAPM using DB and DAX!

#u may want to use this as template for "Determinanten des Aktienkurses von XYZ" 
#u may add Fama French factors http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html#Research
#and add other X acc to your understanding of the business of XYZ

# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load packages
# ------------------------------------------------------------------------------

library(tseries)
library(lmtest)
library(car)
library(sandwich)
library(rugarch)

data_table <- read.table("GML_04_04 capm.csv", header=TRUE, sep=";",dec=",")

summary(data_table)
#your data should be daily and at least 2 yrs, more is bettter but watch out for structural breaks
#note that Verbeek uses excess returns with rf = return on 1 mth T Bills
#WPs (auditors, corp valuation) love a longer rate eg Treasuries 20yrs

# ------------------------------------------------------------------------------
# Diagnostics of one specific regression
# ------------------------------------------------------------------------------

#adjust this section!!!====================================================
Y = data_table$constrrf #xcess return for a sub-index of industrials, cap weighted like dax
X = data_table$rmrf #xcess for broad CRSP index
reg = lm(Y~X) #play here if u want
summary(reg)

# ------------------------------------------------------------------------------
# Estimate CAPM with GARCH for Construction
# ------------------------------------------------------------------------------
data_ext<-matrix(data= NA , nrow=length(residuals(reg)), ncol=2)
data_ext<-cbind(data_table$constrrf,data_table$rmrf)
data_ext=rbind(data_ext,data_ext)

spec2 <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1), 
                                          variance.targeting = TRUE),
                    mean.model = list(armaOrder = c(0, 0), include.mean = TRUE, 
                                      external.regressors = matrix(data_ext[,2])), 
                    distribution.model = "norm")
garch2 <- ugarchfit(spec=spec2,data=matrix(data_ext[,1]),solver.control=list(trace=0))

coef(garch2)
#compare and note that beta is now slightly higher than in ordinary OLS
coefficients(reg)


std_res2 = residuals(garch2)/sigma(garch2)
kernel_den = density(std_res2)
x11()
plot(kernel_den, main="Density w exogeneous X but no AR1")
x <- seq(min(kernel_den$x),max(kernel_den$x),length = 1000)
normal_den = dnorm(x,mean = mean(std_res2),sd = sd(std_res2))
lines(x,normal_den,type="l",col="red")

x11() #note that ARCH effects captured now in model
acf(std_res2^2)

#end





#Ende

