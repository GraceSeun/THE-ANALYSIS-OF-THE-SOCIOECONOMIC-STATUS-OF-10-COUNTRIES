

#PROJECT TITLE
THE ANALYSIS OF THE SOCIOECONOMIC STATUS OF THE G7 COUNTRIES, BRAZIL, CHINA, AND NIGERIA ACROSS TEN YEARS

#OVERVIEW OF PURPOSE
This file is to give a brief description of the application of R and Tableau in the analysis of the socioeconomic status of 10 countries within the years 2011- 2020.

#PROJECT DESCRIPTION
This project is about analysis the social and economic status of countries of the G7 countries (Canada, France, Germany, Italy, Japan, United Kingdom, and United States of America), Brazil, China, and Nigeria. The indicators used for this study are are Population, Urban Population, Rural Population, Gross Domestic Product (GDP), Per Capita Income (GDP), Final Consumption Expenditure (% of the GDP), Trade (Domestic and Foreign trade), Life Expectancy, Gross National Income (GNI), GNI Per Capita, Labor Force, and Unemployment (% of the Labor Force). 
R studio was used to carry out the statistical analysis which were comprehensive descriptive analysis, correlation analysis, regression analysis, time series analysis, and hypothesis testing.
Tableau was used to for the data visualisation aspect of this study.


#GETTING STARTED
The dataset used for this study was downloaded from the WorldBank data repository. Two different versions of the same dataset was used for the different parts of the report. The dataset titled 'Data Set Grace.csv' was used for the Data visualisation part and the dataset titled 'Data Set Grace copy.csv' was used for the statistical analysis part.
To get started, the applications R studio and Tableau needs to be downloaded using the following links https://cran.r-project.org/mirrors.html for R and https://www.tableau.com/en-gb/support/releases/desktop/2022.4#esdalt for Tableau. R studio is an open source app which means no payment is required but tableau needs a subscription. 
Depending on the type of software you use, there are different versions for different softwares which are Windows, Linus or OS for MacBook.
The datasets used for these studies are included in the zip file but they can also be downloaded by following this link 
https://databank.worldbank.org/source/world-development-indicators and then selecting the countries, years, and indicators.


#DEPENDENCIES
The programs can be run on Windows, Linus and OS. You only need to have the version compatible with your software downloaded and already installed. The libraries needed for the R analysis are listed below. Using the 'Install.packages() function on R, you can easily download these packages. 
install.packages("datarium") 
install.packages("qqplotr") 
install.packages("RVAideMemoire")install.packages("car")
install.packages("corrplot")
install.packages("tidyverse")
#install.packages("dplyr") #This package will be installed by tidyverse 
#install.packages("ggplot2") #This package will be installed by tidyverse
install.packages("caret")
install.packages("TTR")
install.packages("forecast")
install.packages("moments")
install.packages("its")
install.packages("pastecs")
The code for calling these installed packages into the program are included in the R code so you do not have to do this.
For the Tableau analysis, there is no needed to install any packages.


#INSTALLING AND EXECUTING PROGRAM
The codes and datasets needed are included in the ZIP file. 
To access the codes required for the R analysis, you just need to open the R file called 'Grace Oluwaniyi R Codes.R' using R studio. Make sure to put this R file and the dataset used called 'Data Set Grace copy.csv' in the same folder and then set the path of this folder as the working directory on R studio.
To access the sheets and the single screen interactive dashboard, you only need to open the file called 'Grace Oluwaniyi Dashboard.twb' using Tableau desktop. Also ensure that the dataset called 'Data Set Grace.csv' is also in the same folder as the tableau file. When you open the Dashboard and it gives an error "'Data Set Grace.csv' not found", click on the locate file option and go to the directory where the dataset is saved.

NOTE: 1/ The file of the dataset used for both analysis are different
      2/ Take note of the extension type at the end of each document as they are important


#HELP
If you run into any problems running the code, please confirm if all dependencies have been install and that each step of the code is run in succession as is on the R script. Do not miss any step. You can use the Help tab on R Studio as well.

#AUTHORS
Grace Oluwaseun Oluwaniyi
G.O.Oluwaniyi@edu.salford.ac.uk


#VERSION HISTORY
* 0.1
    * Initial Release

#LICENSE
None - Open Source

