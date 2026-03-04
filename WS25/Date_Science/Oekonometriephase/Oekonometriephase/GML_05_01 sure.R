#  feb 2023
# r script for simulation of CAPM and SURE
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

#data from example in book Finanzmarkt?konometrie CH 2

# ------------------------------------------------------------------------------
# Step 1
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load packages
# ------------------------------------------------------------------------------

library(tseries)
library(fUnitRoots)
#library(fts)
library(lmtest)
library(sandwich)
library(systemfit)
library(MASS)


#UPDATE HERE========================================================
INDEX_FILE = "GML_05_01 sure.csv"

#define in sample
START_DATE = "1995-12-31"
END_DATE = "2000-12-29"

#UPDATE ENDS========================================================

data_table <- read.table(INDEX_FILE, header=TRUE, sep=";",dec=",")
INDEX  <- data_table[,2] 
Dates <- data_table[,1]
DateStamp = as.Date(Dates,format="%d.%m.%Y")
zINDEX = zoo(INDEX,DateStamp)  

# ------------------------------------------------------------------------------
# Generate sample
# ------------------------------------------------------------------------------

zDataIS <- window(zINDEX, start = START_DATE, end = END_DATE)

# ------------------------------------------------------------------------------
# Write data to file for Excel analysis and plot it, give intuitive names
# ------------------------------------------------------------------------------

indexReturn = diff(log(zDataIS[,1]))#book uses stetige Renditen, S. 42 Fn

# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - Datensimulation --------------------
# ------------------------------------------------------------------------------

set.seed(1)

n=length(indexReturn)
volas = c(0.03,0.02) 
means = c(0,0) 
rho = 0.85
VOLS = diag(,2,2)
diag(VOLS) = volas
VOLS
RHO <- matrix(c(1,rho,rho,1),2,2)
COV = t(VOLS) %*% RHO %*% VOLS
COV

EE <- mvrnorm(n,means,COV)
epsa = EE[,1]
epsb = EE[,2]

X=coredata(indexReturn) #this removes time stamps

Ya = 1 * X + epsa
Yb = 2 * X + epsb

head(Ya)
head(Yb)

# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - Ereignisbau --------------------
# ------------------------------------------------------------------------------

#now event of xtra return of 10%/2% on day 30/40
Ya[30]=Ya[30]+0.1
Yb[40]=Yb[40]+0.02

#create dummy
Da = rep(0,60)
Db=Da
Da[30]=1
Db[40]=1

Da[1:30]

# ------------------------------------------------------------------------------
# Step 2
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - NAIV --------------------
# ------------------------------------------------------------------------------

eq1 <- Ya~X+Da
eq2 <- Yb~X+Db
#two separate OLS
summary(lm(eq1))

summary(lm(eq2))

# ------------------------------------------------------------------------------
# Step 3
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - DIAG --------------------
# ------------------------------------------------------------------------------

#check correlation of resis of OLS
#H0: rho is zero
corResis = cor(residuals(lm(eq1)), residuals(lm(eq2)))
corResis 

#test as in assenmacher, 2002, 196, is based on resis of OLS 

T = n #sample size
G = 2 #no of eqs

sure_stat = T*corResis^2
#critical
sure_df = G * (G-1)/2

sure_crit = qchisq(0.99, sure_df)
#compare
sure_stat
sure_crit
#hence reject H0 = time for SURE

# ------------------------------------------------------------------------------
# Step 4
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - SURE --------------------
# ------------------------------------------------------------------------------

myData = data.frame(cbind(Ya,Yb,X,Da,Db))
#as before but compact
fitOLS <- systemfit( list(eq1, eq2), method = "OLS", data=myData)
#a more adequate approach
fitSUR <- systemfit( list(eq1, eq2), method = "SUR", data=myData)
summary(fitSUR)

#For comparison
coeftest(fitOLS)
coeftest(fitSUR)

# ------------------------------------------------------------------------------
# Step 5
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 2 Firmen Event Studie - SURE Diagnostik --------------------
# ------------------------------------------------------------------------------

#NOTE: Below only for eq1, for eq2 it is the same procedure ...

#systematic part of model, ie we can use ols if needed!!!-----

#Linearity?
x11()
regline = lm(Ya ~ X)
plot(Ya ~ X)
abline(regline)

#RESET Test von Ramsey H0 = Linearer Zusammenhang
resettest(regline,power=2,type="regressor")

#multicoll, how should it?---------------------
cor(X,Da)#says it all
vif(lm(eq1))

#breaks?
betavek = rep(0,10)
for (i in c(1:10))
{
	betavek[i]=coef(lm(Ya[1:(50+i)]~X[1:(50+i)]))[2]
}
plot(betavek, type = 'l')

#stochastic part-----------------------------------------------

#Autokorr---------------------------------------
#analyze resis of sure, here eq1
acf(residuals(fitSUR)$eq1, ci = 0.95) #etc

TT = length(Ya)
dw_SURE<-(sum((residuals(fitSUR)$eq1[-1]-residuals(fitSUR)$eq1[1:TT-1])^2))/(sum((residuals(fitSUR)$eq1)^2))
dw_SURE
#use DW Tables if u want exact reading

#hetero-----------------------------------------
x11()
plot(residuals(fitSUR)$eq1, type='l', ylab = "Residuals eq1")

#White Test (handles non-normal terms, details see schr?der book, p 115)
#H0: Homo
#aux reg

Xsq = X^2
Dsq = Da^2
XD = X*Da
aux_reg = lm((residuals(fitSUR)$eq1)^2~X+Da+Xsq+Dsq+XD)
summary(aux_reg)

#calc R? by feet
sigma_hat1 = coefficients(aux_reg)[1]+coefficients(aux_reg)[2]*X+coefficients(aux_reg)[3]*Da+
             coefficients(aux_reg)[4]*I(X^2) 
#other terms na coeffs, I() = take as is, no interpretation

aux_R_sq = cor(sigma_hat1,(residuals(fitSUR)$eq1)^2)^2

#test stat
white_stat = n*aux_R_sq

#crit val
k = 5 #count above
white_df = k

white_crit = qchisq(0.99, white_df)
#compare, H0: Homo
white_stat
white_crit
#hence keep H0

#normality---------------------------------------
resi1 = residuals(fitSUR)$eq1
x11()#smooth it
kernel_den = density(resi1)
plot(kernel_den, main="Smoothed Residual Distribution", xlab = " ")
x <- seq(min(kernel_den$x),max(kernel_den$x),length = 1000)
#compare to normal
std_den = dnorm(x,mean = mean(resi1),sd = sd(resi1))
lines(x,std_den,type="l",col="red")

shapiro.test(resi1)#H0: Is normal

jarque.bera.test(resi1)#Nullhypothese ?Normalverteilung?

#hence, keep H0

#BONUS: Event Study Old Style
#Unterstelle sogar Kenntnis des wahren Marktmodells, d.h. normal returns sind
NRa = 1 * X[30]
NRb = 2 * X[30]
ARa = Ya[30]-NRa
ARb = Yb[30]-NRb

AAR = (ARa+ARb)/2


t_stat<-sqrt(2)*AAR/sd(c(ARa,ARb))
t_stat

#crit value one sided
qnorm(0.95)

#Ende


