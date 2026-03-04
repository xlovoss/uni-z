# mar 2024
# r script for simulation of BINARY RESPONSE MODELS
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

#data from example in book M. Verbeek (2012), A Guide to Modern Econometrics, p 223

# ------------------------------------------------------------------------------
# Step 1
# ------------------------------------------------------------------------------

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load packages
# ------------------------------------------------------------------------------

library(logistf)
library(GGally)
library(pscl)
library(lmtest)       # Tests für (generalisierte) lineare Modelle
library(broom)        # Ausgabe und Formatierung verschiedener Objekte
library(pscl)         #ord logit
library(MASS)

dfrm_clean <- read.table("GML_03_02_rating.csv", header=TRUE, sep=";",dec=",")

dfrm = as.data.frame(dfrm_clean)
dfrm[1:5,]
#remove incomplete rows
dfrm_clean = na.omit(dfrm)

#cross check with txt file descr, also page 223 in book
summary(dfrm_clean)

#to be explained
rating <- dfrm_clean$RATING #the higher the better, <3 = non IG
IG<-dfrm_clean$INVGRADE

#the regressors 
booklev <- dfrm_clean$BOOKLEV #for leverage
ebit  <- dfrm_clean$EBIT #current profitability, already divided by ta!
logsales  <- dfrm_clean$LOGSALES #for firm size
wk  <- dfrm_clean$WKA #proxies liquidity WC
re  <- dfrm_clean$RETA #retained earnings = past profitability

X = cbind(booklev,ebit,logsales,re,wk)
Data = cbind(IG,X)
X = as.data.frame(X)

x11()#again no simple rules visible
ggpairs(cbind(rating,X))

#end data mining ... start binary choice modelling

# ------------------------------------------------------------------------------
# Step 2
# ------------------------------------------------------------------------------
#NOW LOGIT model as in book------------------------------------

#use logistf for binary logit way 1
   fit1 <- logistf(IG~booklev+ebit+logsales+re+wk,pl=FALSE, method = "Standard ML", firth = F) 
   fit1
   
   exp(coef(fit1))

#note that LR test amounts to 585, compares loglik of model, 
#where all paras except intercept are set to zero (Verbeek, 212),
#to the estimated model. The p value (p=0) shows that H0 "both equal" 
#can be discarded with near certainty
fit1$loglik
   
#logit estimation way 2
fit2 = glm(IG~booklev+ebit+logsales+re+wk, family = "binomial")

#LR either way
fit1
# Anzahl der Freiheitsgrade = Anzahl Koeffizienten minus Intercept
df <- length(coef(fit2)) - 1
# Chi2-Test
pchisq(fit2$null.deviance - fit2$deviance, df, lower.tail = FALSE)
## R-Code 4.11 ----
lrtest(fit2)

#compare
coef(fit1)
coef(fit2)

#nice
summary(fit2) 
##McFaddens Pseudo R? just for info but no added val
pR2(fit2)[4]

# ------------------------------------------------------------------------------
# Step 3
# ------------------------------------------------------------------------------

exp(coef(fit2))

# Residuen auslesen und Deltas berechnen, use this if u want to proceed further w diags
DevResid <- resid(fit2)
PearsonResid <- resid(fit2, type = "pearson")
hats <- hatvalues(fit2)
DeltaChiSq <- PearsonResid^2 / (1 - hats)
DeltaBetas <- PearsonResid^2 * hats / (1 - hats)^2
ProbDach <- fitted(fit2)
# Plots anlegen
#g1 <- gf_point(hats ~ ProbDach)
#g2 <- gf_point(DeltaChiSq ~ ProbDach)
#g3 <- gf_point(DeltaBetas ~ ProbDach)
# in einer Zeile ausgegeben
#grid.arrange(g1, g2, g3, nrow = 1)

## R-Code 4.24 ----
# Identifikation
which(DeltaChiSq > 300)
## R-Code 4.28 ----
dfbetas(fit2)[which(DeltaChiSq > 300), ]

augment(fit2, type.predict = "response")
dfbetas(fit2)[which(DeltaChiSq > 300), ]

# ------------------------------------------------------------------------------
# Step 4
# ------------------------------------------------------------------------------

Y_hat = (fit1$predict>0.5)#cut off at 0.5 arbitrarily chosen
Y_real = (IG>0)

##Simple Hit rate SHR
d=Y_real
d_hat = Y_hat
tt = table(d, d_hat) #, exclude = NULL)
print(tt)

ttpc = prop.table(tt, 1)#percenatge correct per category
print(ttpc)

# total percent correct
sum(diag(prop.table(tt)))
#hence a bit better than linear discriminant analysis 
#BUT only here statistical evaluation possible!

# ------------------------------------------------------------------------------
# Step 5
# ------------------------------------------------------------------------------

#forecast Ig for a new "mean type" firm, BUT with double leverage-------------
newfirm = c(2*mean(booklev),mean(ebit),mean(logsales),mean(re),mean(wk)) #rep(0.5,5)
newlinpred = newfirm %*% coef(fit1)[2:6]+coef(fit1)[1]
levP = 1 /(1+exp(-newlinpred))#less typing than P/(1-P)
levP

#now create the vector of a mean firm, except double the ebit and size, 
#and spot its higher chance to get an IG!!!
newfirm = c(mean(booklev),2*mean(ebit),2*mean(logsales),mean(re),mean(wk))
newlinpred = newfirm %*% coef(fit1)[2:6]+coef(fit1)[1]
newP = exp(newlinpred)/(1+exp(newlinpred))#old style, watch missing -
newP

# ------------------------------------------------------------------------------
# Step 6
# ------------------------------------------------------------------------------
#NOW ORDERED LOGIT model as in book------------------------------------

RatingFactor = as.factor(dfrm_clean$RATING)
#Ordered Logit Model
m <- polr(RatingFactor ~ booklev+ebit+logsales+re+wk, data = dfrm_clean, Hess=TRUE)
summary(m)
#Likelihood-Ratio-Test
lrtest(m)
##McFaddens Pseudo R?
pR2(m)[4]
#this is Table 7.5 in Verbeek, feel good that coeffs are similar to logit model
#chi sq statistic is same = 862
#the intercepts are the borders for eta (n) in slides, i.e. if ?x is smaller than -0.36
#the corresponding firms gets worst rating = 1, best = 7 if eta is above 14.78

##Koeffiziententabelle
(ctable <- coef(summary(m)))

##p-Werte berechnen
p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2

##Kombinierter Output
(ctable <- cbind(ctable, "p value" = p))

#Konfidenzintervalle berechnen
(ci <- confint(m)) 
#hier assuming asymptotic normality! 

#feeld again good that signs are noot changing from left to right border of conf int

##Odd-Ratios
exp(coef(m))

#chk, k?nnte man auswerten-)
head(cbind(predict(m), RatingFactor))

#end

