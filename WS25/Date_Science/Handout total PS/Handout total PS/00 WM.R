### Willkommen in R!

# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------
rm(list=ls(all=TRUE))

# ------------------------------------------------------------------------------
# STEP 1 Use R as handheld calculator, data machine ...
# ------------------------------------------------------------------------------

#basic arithmetics
5+4
sqrt(9)
exp(1)
log(2.718282)
x=2
x^2

#Set up your own data
#Konstruktion eines Spaltenvektors und Zugriff-----------------------
#note that i use = instead of <- cause it is quicker (but dirty)
ALTER=c(21,24,28) #c = combine ...
ALTER=c(22,ALTER,39) #nice trick, to build vector stepwise
ALTER[1:4] #how to select elements
ALTER[-5]
ALTER[c(2,5)]
ALTER[-c(1,3,4)]

GEWICHT=c(56,63,80,49,75)
GROSSE=c(1.64,1.73,1.85,1.6,1.81)

#Konstruktion einer Matrix und Zugriff-----------------------
X=cbind(ALTER,GEWICHT,GROSSE) #column bind
X[2,3] # how to select again, row/col index

colnames(X)
namen=c("Gerda","Ka","Ha","Do","Lu")
rownames(X)=namen
X["Ka",] #how to select, new way ..., don't forget the ,
X[c("Ka","Lu"),]

#Konstruktion eines Data Frames-----------------------
SEX = c("w","w","m","w","m")
GEWICHTSDATEN = data.frame(SEX,X)#works like cbind but does not unify data types!
GEWICHTSDATEN
str(GEWICHTSDATEN)

# ------------------------------------------------------------------------------
# STEP 2 - towards the power of charts
# ------------------------------------------------------------------------------
#load a package, which has to be installed first! -> Pakete | Installiere Paket ...

library(mosaic)
library(corrplot)

# ------------------------------------------------------------------------------
# Load data
# ------------------------------------------------------------------------------
tips = read.table("tips.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
head(tips)
summary(tips)

# ------------------------------------------------------------------------------
# STEP 3 - see the power of charts
# ------------------------------------------------------------------------------

bargraph(~sex, data=tips, main = "MyFirstTitleBar")
x11()
histogram(~tip, data=tips, main = "mysecond")
x11()
histogram(~tip | sex, data=tips, xlab = "Trinkgeld")
x11()
#Boxplot mit metrischen Daten
bwplot(~tip, data=tips)
x11()
#Boxplot mit metrischen Daten f?r Gruppen
bwplot(~tip |sex, data=tips)
x11()
bwplot(tip~sex |smoker, data=tips, main = "Ja ja die Raucher")
x11()
#Scatterplot (Streudiagramm) mit zwei metrischen Variablen
xyplot(tip~total_bill, data=tips)
x11()

#mosaicplot mit zwei kategorialen Variablen
#Vorher muss eine Tabelle mit dem Befehl tally generiert werden
tally(sex~smoker, data=tips)

#Tabelle wir einem Objet zugewiesen
Tabelle1<-tally(sex~smoker, data=tips)
mosaicplot(Tabelle1)

#differnezierte stats
favstats(tip~sex, data=tips)
x11()
corrplot(cor(tips[,c("total_bill", "tip", "size")]))

#end

