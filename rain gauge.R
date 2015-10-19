library(ggplot2)
library(MASS)

filelist = list.files(pattern = "*.txt")
datalist = lapply(filelist, function(x)read.csv(x,skip = 2, stringsAsFactors = F))
raw = do.call("rbind", datalist)


# put all the raw data into a vector
matrix.raw <- as.matrix(raw)[,-1]
vector.raw <- as.vector(t(matrix.raw))
length(vector.raw)
vector.data <- vector.raw[-length(vector.raw)] 
length(vector.data) 
 

# find position of the starting time of a rain storm
find.start <- function(vec){
  tmp <- rep(0,length(vec))
  for (i in 1:length(vec)-1){
    if(vec[i]=="----"&&vec[i+1]!="----"){
      tmp[i]=i+1
    }
  }
  return(tmp[tmp!=0])
}
starting.pos <- find.start(vector.data)
length(starting.pos)


# find position of the ending time of a rain storm
find.end <- function(vec){
  tmp <- rep(0,length(vec))
  for (i in 1:(length(vec)-1)){
    if(vec[i] != "----" && vec[i+1] == "----"){
      tmp[i]=i
    }
  }
  return(tmp[tmp!=0])
}

ending.pos <- find.end(vector.raw)
length(ending.pos)


# get the date by summing up the time interval rain storms
sum_rain_seq <- rep(NA,length(starting.pos))
vector.raw[vector.raw=="T   "] <- 0
vector.raw[vector.raw =="M"] <- 0
vector.raw[vector.raw =="M    "] <- 0
vector.raw[1:100]

for (i in 1:length(starting.pos)){
  sum_rain_seq[i] <- sum(as.numeric(vector.raw[starting.pos[i]:ending.pos[i]]))
}

raindata1 <- sum_rain_seq[!is.na(sum_rain_seq)]
raindata <- raindata1[!raindata1==0]

# Method of Moment
hist(raindata)
mean(raindata)
var(raindata)
alpha <- mean(raindata)^2/var(raindata)  
lambda <- mean(raindata)/var(raindata)

# Estimated parameters using Method of Moment
# alpha = 0.3621776
# lambda = 1.276349


# MLE (method 1)
n <- length(raindata)
minus.likelihood <- function(theta) {-(n*theta[1]*log(theta[2])-n*lgamma(theta[1])+(theta[1]-1)*sum(log(raindata))-theta[2]*sum(raindata))}

max.likelihood <- nlminb(start=c(alpha, lambda), obj = minus.likelihood)

max.likelihood$par

# MLE (method 2)
params <- fitdistr(raindata, "gamma")
params

# MLE estimators for gamma distribution
# shape = 0.54579027
# rate = 1.92341816

# Check whether gamma distribution fit data well
simdata <- qgamma(ppoints(length(raindata)), shape = params$estimate[1], rate = params$estimate[2])
qqplot(raindata, simdata)

