# mar 2024
# r script for estimation of discrimantion 
# written by Frank Lehrbass (->lehrbass.de) for teaching purposes only
# students are solely responsible for whatever they do with this coding
# this R coding is WITHOUT ANY WARRANTY

#wages data from example in Verbeek book, pls read the stuff to get the background

# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------

rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# Load libs, more than u need here, but then we are ready for much more stuff!!!!
# ------------------------------------------------------------------------------
library(lmtest)
library(car)
library(sandwich)
library(corrplot)

# ------------------------------------------------------------------------------
# STEP 1 Load data, data is from econometrics book by Marno Verbeek
# M. Verbeek (2012), A Guide to Modern Econometrics. Wiley
# ------------------------------------------------------------------------------
wage_data = read.table("GML_02_02_wages.txt", header=TRUE, sep="\t", na.strings="NA", dec=".", strip.white=TRUE)
head(wage_data)
dim(wage_data)
summary(wage_data)

# ------------------------------------------------------------------------------
# STEP 2
# ------------------------------------------------------------------------------
#warm up yourself w dfs
#wage data is a data frame, ie various types of vars included
#get diemsnion of data frame
dim(wage_data)
#get slots
str(wage_data)
#see first rows in full
head(wage_data)
#get a certain recordset, eg row 5 column 1
wage_data[5,1]
#get a certain column
head(wage_data$WAGE)

# ------------------------------------------------------------------------------
# Plot ad hoc charts
# ------------------------------------------------------------------------------
hist(wage_data$WAGE, nclass = 100)

# ------------------------------------------------------------------------------
# STEP 3 - Datenvisualisierung!!!
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Calc mean, SD etc and show graphics
# ------------------------------------------------------------------------------
mean(wage_data$WAGE)
sd(wage_data$WAGE)
summary(wage_data$WAGE)#the easy way

#collect regressors
X=(wage_data)#cbind(wage_data$SCHOOL,wage_data$MALE,wage_data$EXPER))
head(X)

#colored rhos
x11()
corrplot(cor(wage_data[,c("WAGE","SCHOOL","MALE","EXPER")]))

#hence, u feel there is s th gooing between MALE and WAGE

#BOXPLOT IT
x11()
boxplot(wage_data$WAGE, main = "Boxplot of wage")
#remember: help(boxplot) and that 25%,50% and 75% quantile are shown as well as range and what is 
#out of 1.5 (75-25) = 1.5 InterQrtsRange = Outlier = dots
x11()
boxplot(wage_data$WAGE ~ wage_data$MALE,  main = "Conditioned boxplots of wage")
#compare this view with a look at a huge data table! In the latter u see nothing but here ..

# ------------------------------------------------------------------------------
# STEP 4 what follows are math arguments which get stronger each step to prove discrimination!
# ------------------------------------------------------------------------------
#how many males?
no_males = sum(wage_data$MALE)
no_females = length(wage_data$MALE)-no_males
# cross chk
no_total = no_males + no_females

wages_males = rep(0,no_males)
wages_females = rep(0,no_females)

m = f = 1
for (i in (1:no_total)){
	if(wage_data$MALE[i] == 1)
	{
		wages_males[m] = wage_data$WAGE[i]
		m = m+1
	}
	else
	{
		wages_females[f] = wage_data$WAGE[i]
		f = f+1
	}
}
#some details of female wages
wfs = sort(wages_females)
head(wfs)
tail(wfs)

wilcox.test(wages_males,wages_females)
#and now with a direction
#H0 males earn less than females?
wilcox.test(wages_males,wages_females,alternative = c("greater"))
#rather not ....
max(wages_males)#this is the one to the right in the conditoned histogram

#see that plain vanilla argument is weaker! And on top judge would ask you:
#How can you simply compare average wages for male and female, 
#when the males are the janitors and the ladies are all data analysts???
mean(wages_males)-mean(wages_females)
# ------------------------------------------------------------------------------
# STEP 5
# ------------------------------------------------------------------------------
cor(wage_data)
x11()
plot(wage_data$WAGE ~ wage_data$SCHOOL)

#define above avg features
above_school = (wage_data$SCHOOL > mean(wage_data$SCHOOL))
above_wage = (wage_data$WAGE > mean(wage_data$WAGE))
table(above_school,above_wage)
chisq.test(table(above_school,above_wage))

test = chisq.test(table(above_school,above_wage))
test$p.value 
test$statistic

x11()#bonus stuff
mosaicplot(table(above_school,above_wage))

#cross check chi sq test
table(above_school,above_wage)
#put into RowsCols
RowsCols = table(above_school,above_wage)
#total sample size
TotalSample = sum(RowsCols)
TotalSample

#now go for eij as in Script WM 02 page 102
h2. = sum(RowsCols[2,]) # is h2., ie sum over 2nd row
#accordingly
h1. = sum(RowsCols[1,]) # is h1., ie sum over 1st row

h.1 = sum(RowsCols[,1]) 
h.2 = sum(RowsCols[,2]) 

#IF H0 that column and rows are independent THEN the expected probs in 2nd row are
#eij = hi. * h.j / TotalSample , note that independence allows multiplication of individual
#row and column probs, ie as usual to get joint prob if above shool and above wage are independent

e11 = h1.*h.1 / TotalSample
e12 = h1.*h.2 / TotalSample
e22 = h2.*h.2 / TotalSample
e21 = h2.*h.1 / TotalSample

#test stat by feet

my_stat = (RowsCols[1,1]-e11)^2 / e11 + (RowsCols[1,2]-e12)^2 / e12 
my_stat = my_stat + (RowsCols[2,1]-e21)^2 / e21 + (RowsCols[2,2]-e22)^2 / e22
#compare
my_stat
test$statistic

# ------------------------------------------------------------------------------
# STEP 6
# ------------------------------------------------------------------------------
reg = lm(wage_data$WAGE ~ wage_data$SCHOOL)
summary(reg)
plot(wage_data$WAGE ~ wage_data$SCHOOL, xlim = c(0,17))
abline(reg)

#cross check beta
coef(reg)[2]
#by feet
cov(wage_data$WAGE ,wage_data$SCHOOL)/var(wage_data$SCHOOL)
#transform into correlation
coef(reg)[2]*sd(wage_data$SCHOOL)/sd(wage_data$WAGE)
#compare
cor(wage_data$SCHOOL,wage_data$WAGE)

# ------------------------------------------------------------------------------
# STEP 7
# ------------------------------------------------------------------------------
#go from simple to multiple regression
#with multiple we can control for other factors beside MALE, see here:
regMult = lm(wage_data$WAGE ~ wage_data$SCHOOL + wage_data$MALE + wage_data$EXPER)
summary(regMult)
#note how much a transformation (treatment) from female to male pays off in terms of hourly wage! 
#Note the c.p. !!! see below

# ------------------------------------------------------------------------------
# STEP 8
# ------------------------------------------------------------------------------

reg = regMult

##Fehlspezifikation------------------------------------------
#a0
resettest(reg)#H0 No spec error

##Hetero---------------------------------------------------
plot(residuals(reg), type='l')

#Breusch-Pagan-Test auf Heteroskedastizit?t
bptest(reg)#H0: Homoscedasticity!

##Autokorrelation-------------------------------------------

#n.a.

##conclusion-----------------------------------------------
#Newey-West-Korrektur demzufolge sinnvoll
coeftest(reg)
#vs
coeftest(reg,vcov=NeweyWest(reg))#now use heteroskedasticity and autocorrelation
#consistent (HAC) covariance matrix estimators. Note the decreased t value!
#manchmal muss man ausprobieren mit den Ans?tzen bis es l?uft numerisch (-> R Hilfe!), oder Wechsel auf
coeftest(reg,vcov = vcovHC(reg, type = "HC0"))#White estimator, argu kann man ?ndern falls problem


#end
