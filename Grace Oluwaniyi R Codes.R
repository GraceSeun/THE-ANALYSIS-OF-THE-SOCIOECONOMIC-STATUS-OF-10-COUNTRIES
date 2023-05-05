#Loading the dataset into R
dataset<- read.csv(file='Data Set Grace.csv', header = TRUE)

#Getting the distribution for total population across all countries
summary(dataset$PopulationTotal)

#Dividing the countries into groups using the median of the total population
dataset$group = NA
for ( i in 1 : 100){
  if (dataset$PopulationTotal[i] <= 1.047e+08){
  dataset$group[i] = 'GroupA'}
  else {dataset$group[i] = 'GroupB'}
}

###############################################################################################

#4.1 DESCRIPTIVE ANALYSIS

install.packages("moments") 
library("moments")  
library(ggplot2)
library(dplyr)
attach(dataset)
#Computing descriptive analysis for all countries
by(dataset, INDICES=CountryName, FUN = summary)
#for a more comprehensive summary for all countries
install.packages("pastecs")
library(pastecs)
by(dataset, INDICES=CountryName, FUN = stat.desc, norm = TRUE)

###############################################################################################

#4.2 CORRELATION ANALYSIS 

library(qqplotr)
library(RVAideMemoire)
library(corrplot)
library(tidyverse)
# remove country name, year and group variables
library(tidyverse)
dat <- dataset %>% select(-CountryName, -Year, -group)
dat
#correlation plot for all continuous variables
corrplot(cor(dat), method = "number", type = "upper", tl.cex = 0.5, cl.cex = 0.5)
#multiple scatter plots for correlation visualization
pairs(dat[, c("GDPPerCapita", "GNIPerCapita", "LifeExpectancy", "PopulationTotal")])

###############################################################################################

#4.3 REGRESSION ANALYSIS

library(caret)
#Simple Linear Regression Analysis
model1 <- lm(GNIPerCapita ~ LifeExpectancy, dat)
summary(model1)
#Assumption 1 - Linearity
#draw scatter plot with regression line
plot(GNIPerCapita ~ LifeExpectancy, dat, col = "green",
     main = "Regression: GNI Per Capita and Life Expectancy",
     xlab = "Life Expectancy",
     ylab = "GNI Per Capita")
abline(model1, col="red")
#Assumption 2 - Residuals' Independence
plot(model1, 1)
#Assumption 3 - Normality of Residuals
plot(model1, 2)
#Assumption 4 - Homoscedasticity
plot(model1, 3)

#MULTIPLE LINEAR REGRESSION (MLR)
#forward stepwise
model2 <- lm(GNIPerCapita ~ GDPPerCapita + LifeExpectancy, dat)
summary.lm(model2)
model3 <- lm(GNIPerCapita ~ GDPPerCapita + LifeExpectancy + UrbanPopulation, dat)
summary.lm(model3)
#Assumption 1 - Linearity
data.frame(colnames(dat))
pairs(dat[ ,c(1,10,9)], lower.panel = NULL, pch = 19, cex = 0.2)
#Assumption 2 - Residuals' Independence
plot(model2, 1)
#Assumption 3 - Normality of Residuals
plot(model2, 2)
#Assumption 4 - Homoscedasticity
plot(model2, 3)
#Assumption 5 - No multicollinearity
library(car)
vif(model2) #VIF less than 5

###############################################################################################

#4.4 TIME SERIES ANALYSIS 

library("TTR")
library("forecast")
library(xts)
#Converting the dataset into a time series data using GNI per capita and year columns
gnipercapita <- dataset %>% select(Year, GNIPerCapita)
summary(gnipercapita) #summary of new data
str(gnipercapita) #structure of new data
as.numeric(gnipercapita$GNIPerCapita)
#Grouping the data set by year and mean values for all years
gni_year <- gnipercapita %>% group_by(Year) %>% summarise_all(mean)
#to create dates using the year column
date <- seq(from = as.Date("2011/12/31"), to = as.Date("2020/12/31"), by = 'years')
date
#Create a time series using gni per year and date
gnipercapita_ts <- xts(gni_year$GNIPerCapita, date)
view(gnipercapita_ts)
#Plotting the time series
autoplot(gnipercapita_ts) + geom_line(color = "green") + labs(x = "Years", y = "GNI per capita", 
                              title = "Time series plot of GNI per capita")
#Decomposing the Time series
gniSMA2 <- SMA(gnipercapita_ts,n=2)
plot.ts(gniSMA2)
#Building ARIMA model
gnidiff2 <- diff(gnipercapita_ts, differences=2) #differencing the series
plot.ts(gnidiff2)
#ACF and PACF plots
acf(gnipercapita_ts, lag.max=20)
pacf(gnipercapita_ts, lag.max=20)
# fit an ARIMA(0,0,1) model
gnipercapitaarima <- arima(gnipercapita_ts, order=c(0,0,1)) 
gnipercapitaarima 
#Prediction for the next 5 years
gnipercapitaforecast <- forecast(gnipercapitaarima, h=5)
gnipercapitaforecast
#plot for the forecast values
plot(gnipercapitaforecast)
#Checking the forecast residuals
acf(gnipercapitaforecast$residuals, lag.max=20)
plot.ts(gnipercapitaforecast$residuals)
#Creating a function for plotting residuals histogram
plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4 
  mysd	<- sd(forecasterrors)
  mymin <- min(forecasterrors) - mysd*5 
  mymax <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

plotForecastErrors(gnipercapitaforecast$residuals) #plotting histogram

###############################################################################################

#4.5 TESTS

#One way ANOVA
#Assumption 4 to check for outliers
boxplot( GNIPerCapita ~ group, data= dataset, names=c("A","B"),
         xlab="Groups of Population", ylab="GNI per capita",
         main='GNI per capita for Each Group')
#A5 assumption to check for normality
byf.shapiro(GNIPerCapita ~ group, data=dataset)
#Transforming dataset to follow a normal distribution
library(moments)
datasett <- dataset
skewness(datasett$GNIPerCapita, na.rm = TRUE) #checking skewness of GNI per capita
skewness(dataset$GDPPerCapita, na.rm = TRUE) #checking skewness of GDP per capita
skewness(dataset$LifeExpectancy, na.rm = TRUE) #checking skewness of Life Expectancy
datasett$GNIPerCapita <- log10(datasett$GNIPerCapita)
datasett$GDPPerCapita <- log10(datasett$GDPPerCapita)
datasett$LifeExpectancy <- log10(datasett$LifeExpectancy)
datasett$GNIPerCapita <- exp(datasett$GNIPerCapita)
datasett$GDPPerCapita <- exp(datasett$GDPPerCapita)
datasett$LifeExpectancy <- exp(datasett$LifeExpectancy)
summary(dataset)
#A5 assumption to check for normality
byf.shapiro(GNIPerCapita ~ group, data=datasett)
#Bartlett homogeneity test
var<- bartlett.test(GNIPerCapita ~ group, data= dataset) 
var
#TWO SAMPLE T-TEST
t.test(GNIPerCapita ~ group, dataset) #for GNI per capita
t.test(LifeExpectancy ~ group, dataset) #for Life expectancy

