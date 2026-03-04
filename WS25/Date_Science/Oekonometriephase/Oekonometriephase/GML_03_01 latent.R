# feb 2023
# r script for simulation of BINARY RESPONSE MODELS
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load packages
# ------------------------------------------------------------------------------

library(logistf)
library(pscl)

#sample size
n=1000
set.seed(2023)

#NOTE: R assumes that Y=1 if latent variable is above zero
e=rlogis(n, location = 0, scale = 1) #pi/sqrt(3))is another scale setting usual in logit models
#wir sparen uns e=-e wg Symmetrie der Dichte
x=round(runif(n,min = 20, max = 70),0)#mit 18 Fuehrerschein, mit 70+ besser nicht

x11()
hist(x, main = "Alter Autointeressenten")

c=-45
b=0.9
#latent variable
a =c+b*x+e    
#binary outcome, buys car if unknown income or whatever is >0
y=(a>0)
for (i in 1:length(y)){ 
 if(y[i]) y[i]=1 else y[i]=0
}
mean(y)#percentage responders
x11()
hist(y, main = "Response Histogram")
x11()
hist(a, main = "Agitation Histogram")

#logit estimation way 1
fit1 <- logistf(y~x,pl=FALSE, method = "Standard ML",firth = F)
#if firth is true u get a penalty deducted from likelihood 
#pl=FALSE makes it use the Wald method
fit1 

#logit estimation way 2
fit2 = glm(y~x, family = "binomial")
summary(fit2) 

#COMPARE
c(c, b)
coef(fit1)
coef(fit2)

#end