#read package
#REF: MatsuuraKentaro's products.
#"https://github.com/MatsuuraKentaro/RStanBook"
#in Chapter5.

library(rstan)

d <- read.csv("RStanBook/chap05/input/data3a.csv")

d2 <- data.frame(X=c(0,1))
rownames(d2)<-c('C','T')
data <- list(N=nrow(d),X=d$x,Y=d$y,f=d2[d$f,])

#run.
fit <- stan(file="lastex.stan",data=data, seed = 123)
#If seed is 123"4"(over 4 digit number?), error is occured.
fit2 <- stan(file="lastex.stan",data=data, seed = 1234)

