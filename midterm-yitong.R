library(ggplot2)
library(qualityTools)
library(MASS)

# create a vector of n exponential waiting times with lambda = lam
set.seed(50)

wait <- function(n,lam){
  a = NULL
  for(i in 1:n){
    a = c(a,rexp(1,rate = lam))
  }
  return(a)
}

wait(100,5)


# now simlate the waiting time for k events to occur with lambda = lam
set.seed(50)
wait.for <- function(k, lam){
  time = 0
  count = 0
  a = NULL
  while(count < k){
    inter=rexp(1,lam)
    count = count + 1
    time = time+inter
  }
  
  return(time)
} 

# Simulate gamma test to show total waiting time is gamma distributed. 
gam.test <-function(rep, max.e, lam ){
  a=NULL
  for (i in 1:rep){
    t = wait.for(max.e,lam)
    a = c(a,t)
    
  }
  
  return(a)
}

gam <- gam.test(1000,10,5)

#  Plot density function of gamma dist.
scale <- length(gam)/10
lambda <- mean(gam)/var(gam)
shape <- mean(gam)^2/var(gam)
x <- seq(min(gam),max(gam),.1)
y <- dgamma(x,shape,rate=lambda)*scale
qplot(gam, binwidth = 0.1) + geom_line(aes(x,y,color='red'))


# Summary of the relationship between exponential and gamma distribution
# take sum of n exponential waiting times with lambda = lam,
# if xi ~ exp(lam), i=1:n     let y= x1+x2+...+xn
# then y ~ gamma(shape= n, rate = lam, scale = 1/lam)

# function for y 
sumexp <- function(n,lam){
  d <- matrix(c(rep(0,1000)),ncol = 1)
  for(i in 1:1000){
    d[i] <- sum(wait(n,lam))
  }
  print(d)
}

# Check
# take n=10, lambda=5 as an example
example <- sumexp(10,5)

# suppose data follows gamma distribution, finding parameters
params <- fitdistr(example, "gamma")
params

# test whether gamma distribution fit data well using Q-Q plot
ks.test(example, "pgamma", shape = params$estimate[1], rate = params$estimate[2]) 
simdata <- qgamma(ppoints(length(example)), shape = params$estimate[1], rate = params$estimate[2])
qqplot(example, simdata)


# we can also compare plot for data and plot for the gamma distribution
df <- data.frame(example)
ggplot(df, aes(df[,1])) + geom_density()   # plot for y

x <- rgamma(1000,shape=2,scale=1/5)
mean(x)
hist(x,prob=T,main='Gamma,scale=1/5')
lines(density(x),col='red',lwd=2)          # plot for gamma distribution 




# Summary of the relationship between exponential and poisson distribution
# if the number of events in the unit time period follows poission distribution with parameter 1/lambda
# then the waiting time between two events is exponential distribution with parameter lambda 


# create a vector of exponential waiting times which total t <= Max with lambda = lam
set.seed(50)
wait.until <- function(Max,lam){
  time = 0
  a = NULL
  while(time < Max){
    inter = rexp(1,lam)
    a = c(a,inter)
    time = time + inter
  }
  return(a[1:(length(a)-1)])  
}

wait.until(10,5)


# now simulate the number of events to show that the number of events divided by
# exponential waiting times are Poisson distributed

poi.test <- function(rep, Max, lam){
  a = NULL
  for(i in 1:rep){
    q = wait.until(Max,lam)
    a = c(a,length(q))
  }
  return(a)
}

poi <- poi.test(1000,10,5)

# Plot density function of poisson dist.
lambda <- mean(poi)
scale <- length(poi)
x <- seq(min(poi),max(poi),1)
y <- dpois(x,lambda)*scale
qplot(poi, binwidth = 1) + geom_line(aes(x,y,color='red'))


# Check
# take lambda=5 as an example
example2 <- poi.test(1000,1,5)

# check whether number of events is Poisson distributed
fit <- fitdistr(example2, "poisson") 
simdata <- qpois(ppoints(length(example2)), lambda=fit$estimate)
qqplot(example2, simdata)



  

