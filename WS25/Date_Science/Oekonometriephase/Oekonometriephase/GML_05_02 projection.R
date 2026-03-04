### Willkommen in R!

# ------------------------------------------------------------------------------
# lin algebra of lin reg in a nutshell
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Clean previous variables
# ------------------------------------------------------------------------------
rm(list=ls(all=TRUE))

#define a Y
Y = matrix(0,2,1)
Y[1,1]=3
Y[2,1]=2
Y

X = matrix(0,2,1)
X[1,1]=2
X[2,1]=1
X

plot(c(0,4),c(0,4),xlab="Point in time t=1", ylab ="Point in time t=2", type = "n", main = "Our Data")
arrows(0,0,Y[1,1],Y[2,1],lwd=3)
text(Y[1,1],Y[2,1],"Y",pos=4,cex=2)
arrows(0,0,X[1,1],X[2,1],lwd=3)
text(X[1,1],X[2,1],"X",pos=4,cex=2)

#do reg without abcissa cause it would be trivial to explain two obs with two regressors X and (1,1)!
#would result in zero residuals!
reg = lm(Y~X-1)
summary(reg)

#so what's going on here?
x11()
plot(c(0,4),c(0,4),xlab="Point in time t=1", ylab ="Point in time t=2", type = "n", main = "Our Regression")
arrows(0,0,Y[1,1],Y[2,1],lwd=3)
text(Y[1,1],Y[2,1],"Y",pos=4,cex=2)
arrows(0,0,X[1,1],X[2,1],lwd=3)
text(X[1,1],X[2,1],"X",pos=4,cex=2)

sample_XY = crossprod(X,Y)#scalar product x1y1+x2y2
sample_XY 
sample_XX = crossprod(X,X)

b_hat = sample_XY / sample_XX
Y_hat = coef(reg)[1] * X

arrows(X[1,1],X[2,1],Y_hat[1,1],Y_hat[2,1],lwd=3,col="red")
text(Y_hat[1,1],Y_hat[2,1],expression(hat(Y)),pos=4,cex=2,col="red")

#compare slope b estimators
b_hat#as we have learned
coef(reg)[1]#the easy way

#do dumb stuff
reg_dumb = lm(Y~X)
summary(reg_dumb)

#and conclude with some reflections
var(X)#note that the squared diffs to mean are divided by n-2=1!

#for the following read Assenmacher page 87ff (relation between crossproducts and moments)
#in case we had an abcissa as in the last regression we could determine the slope by
cov(X,Y)/var(X)
coef(reg_dumb)[2]
#but without intercept it is as above and cov/var does not work so easily ...



#and what about the residuals?-------------------------------------------------
Xinv = solve(crossprod(X))
resis = Y-X %*% Xinv %*% crossprod(X,Y)

#cross check
residuals(reg)
resis

#ready to get the std dev!----------------------------------------------

#go for sigma-hat...................................
n=length(X)
k=dim(X)[2]
n
k #number of regressors
sigma_hat = sqrt(sum(resis^2)/(n-k))
#note division by degrees of freedom makes this an unbiased estimator! in contrast ML esti!

#cross check
summary(reg)
sigma_hat

#and std err of slope..............................
std_error = sqrt(diag(Xinv))*sigma_hat

#cross check
summary(reg)
std_error

#and a final word:
#demean X towards Xd
Xd = X-mean(X)
crossprod(Xd,Xd)
var(X)#now it fits

Yd=Y-mean(Y)
crossprod(Yd,Xd)
cov(Y,X)#now it fits


#end