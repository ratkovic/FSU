library(sparsereg)
library(CBPS)
library(xtable)
library(stargazer)
rm(list=ls())
source("../../Simulations/InfluenceSimsBase.R")


if(F){
 w <- read.csv ('Cong_daught.csv' ,head=T)
 w<-w[!is.na(w$totchi),]
w$age2 <- w$age^2
 w$srvlng2 <- w$srvlng^2
 w$norelig <- ifelse (w$rgroup==0 , 1 , 0 )
w$catholic <- ifelse (w$rgroup==2 , 1 , 0 )
w$otherchrist <- ifelse (w$rgroup==3 , 1 , 0 )
w$jewish <- ifelse (w$rgroup==4 , 1 , 0 )
lm.rep <- lm (nowtot ~ ngirls + female + white + repub + age + age2 + srvlng + srvlng2 +
norelig + catholic + otherchrist + jewish + demvote +
as.factor (region) + as.factor (totchi), data =  w)

X0<-model.matrix(lm.rep)

lm.rep2 <- lm (nowtot ~ ngirls + female + white + repub + age + age2 + srvlng + srvlng2 +
norelig + catholic + otherchrist + jewish + demvote + (totchi)+
as.factor (region) , data =  w)

X<-model.matrix(lm.rep2)[,-c(1,2,7,9)]
treat<-model.matrix(lm.rep)[,"ngirls"]
y<-lm.rep$model$nowtot
totchi<-X[,"totchi"]

keeps<-(totchi!=0)

treat<-treat[keeps]
y<-y[keeps]
X<-X[keeps,]
X0<-X0[keeps,]

coef.null<-NULL
set.seed(1);dmodel<-predict(randomForest(totchi,x=X[,!colnames(X)%in%"totchi"],nt=2000))
n<-length(dmodel)
totchi<-totchi[keeps]
for(i in 1:200){
	r1<-sample(c(-1,0,1),n,T)
	#ps.use<-pmin(dmodel/totchi,.95)
	#ng2<-sapply(1:n,FUN=function(x)rbinom(1,max(totchi[x],1),ps.use[x]))
ng2<-dmodel/2+r1#*(treat-dmodel)
ng2<-sapply(1:n,FUN=function(x) ifelse(runif(1)>0.5,floor(ng2[x]),ceiling(ng2[x])))
ng2<-pmax(0,pmin(ng2,totchi))
lm.null <- lm (y~ ng2+X0[,-c(1:2)] )
coef.null[i]<-lm.null$coef[2]
}


lm1<-lm(y~treat+X0)
lmr1<-lm(lm1$res^2~X0)

set.seed(1)
d1<-DML(y,treat,X)
res1<-d2$treat^2
summary(lm(res1~X0[,-c(1:2)]))

d2<-DML(y,treat,X0[,-c(1:2)])

set.seed(1)
h1<-hoe(Y=y,D=treat,X=X,20)

res2<-lm(h1$treat~h1$ortho1X[,1:50])$res^2


gcv(lm(treat~d1$treat))
gcv(lm(h1$treat~X[,-2]))
gcv(lm(h1$treat~h1$ortho1X))
gcv<-function(obj){
	res<-obj$res
	X<-model.matrix(obj)
	X<-X[,!is.na(obj$coef)]
	h1<-diag(X%*%(ginv(t(X)%*%X)%*%t(X)))
	mean((res/(1-h1))^2)
}

res3<-lm(h2$treat~h2$orthoX)$res^2

summary(lm(res3~X0[,-c(1:2)]))
set.seed(1)
h4<-hoe(Y=y,D=ng2,X=,X0[,-c(1:2)],20)
set.seed(1)

h5<-hoe(Y=y,D=ng3,X=X,20)
}

load('WashingtonMPSA')

#w.cb<-npCBPS(treat~X0[,-c(1:2,ncol(X0))]);save(w.cb,file="w.cb")
load("w.cb")
##Assessing f
t1<-c(
gcv(lm(y~1)),
gcv(lm(y~X0[,-c(1:2)])),
gcv(lm(y~h1$ortho2X)),
gcv(lm(y~X0[,-c(1:2)]+h1$ortho2X)),
gcv(lm(y~I(y-d1$Y))),
gcv(lm(y~X0[,-c(1:2)],w=w.cb$w))
)/1000

##Assessing g_1
t2<-c(
gcv(lm(treat~1)),
gcv(lm(treat~X0[,-c(1:2)])),
gcv(lm(treat~h1$ortho1X)),
gcv(lm(treat~X0[,-c(1:2)]+h1$ortho1X)),
gcv(lm(treat~I(treat-d1$treat))),
gcv(lm(treat~X0[,-c(1:2)],w=w.cb$w))
)

##Assessing g_2
res1<-(treat-predict(randomForest(treat,x=X)))^2
t3<-c(
gcv(lm(res1~1)),
gcv(lm(res1~X0[,-c(1:2)])),
gcv(lm(res1~h1$ortho1X)),
gcv(lm(res1~X0[,-c(1:2)]+h1$ortho1X)),
gcv(lm(res1~I(treat-d1$treat))),
gcv(lm(res1~X0[,-c(1:2)],w=w.cb$w))
)*10

table.assess<-rbind(t1,t2,t3)

colnames(table.assess)<-c("Null","Linear","PLCE","Linear+PLCE","DML","CBPS")
rownames(table.assess)<-c("Predictors (f)","Confounders (g_1)","Treatment Heterogeneity (g_2)")
stargazer(table.assess)

tab2<-apply(table.assess,2,FUN=function(x) as.vector(1-x/table.assess[,1]))[,-1]
rownames(tab2)<-rownames(table.assess)
stargazer(tab2)

s1<-svd(apply(X0[,-c(1:2,ncol(X0))],2,scale))

X2<-apply(X0[,-c(1:2)],2,scale)
eig2<-eigen(crossprod(X2))
crossprod(X2)-((eig2$vec)%*%diag(eig2$val)%*%t(eig2$vec))
X3<-X2%*%t(eig2$vec[1:28,])
lm0.out<-lm(y~treat+X3)
v1(lm0.out)

lm0.out<-lm(y~treat+X3)
lm1.out<-lm(y~treat+h1$orthoX)
lm2.out<-lm(y~treat+X3+h1$orthoX[,-c(ncol(h1$orthoX))]);v1(lm2.out)
v1<-function(x) vcovHC(x)[2,2]^.5
coefs<-c(lm0.out$coef[2],lm1.out$coef[2],lm2.out$coef[2])
ses.out<-c(v1(lm0.out),v1(lm1.out),v1(lm2.out))

reg.out<-rbind(coefs,ses.out)
rownames(reg.out)<-c("Coefficient","Standard Error")
colnames(reg.out)<-c("Linear","PLCE","PLCE+Linear")
stargazer(reg.out)
