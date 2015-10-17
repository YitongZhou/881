L.00.01 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-01.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.02 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-02.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.03 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-03.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.04 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-04.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.05 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-05.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.06 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-06.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.07 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-07.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.08 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-08.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.09 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-09.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.10 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-10.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.11 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-11.txt", skip=2,header=T, stringsAsFactors=FALSE)
L.00.12 <- read.csv("C:/Users/yiton/Desktop/881/Midterm/rain gauge raw data/L-00-12.txt", skip=2,header=T, stringsAsFactors=FALSE)
raw <- rbind(L.00.01,L.00.02,L.00.03,L.00.04,L.00.05,L.00.06,L.00.07,L.00.07,L.00.08,L.00.09,L.00.10,L.00.12)

tmp[,j][strtrim(tmp[,j],1)%in%]
raw[raw =="T   "] <- 0
raw[raw =="----"] <- 0
raw[raw =="M"] <- 0
raw[raw =="M    "] <- 0
dim(raw)
raw <- raw[,(2:24)]




