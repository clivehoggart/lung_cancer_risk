# Lung cancer risk
Prediction of lung cancer risk in age window implementing model described in:\
Hoggart C et al. A risk model for lung cancer incidence. Cancer Prev Res (Phila). 2012 Jun;5(6):834-46. doi: 10.1158/1940-6207.CAPR-11-0237. Epub 2012 Apr 11. PMID: 22496387; PMCID: PMC4295118.

# Installation
Clone this repository from your home directory using the following git command:

git clone https://github.com/clivehoggart/lung_cancer_risk.git

Alternatively, download the source files from the github website
(https://github.com/clivehoggart/lung_cancer_risk.git)

# To run
Load function in R

	source("lung_cancer_risk/lung_cancer_risk.R")

Call function:

	pred.lung( age, age.start, age.stop, smoke.intensity, future )
	
	age -- in years
	
	age.start -- age started smoking (years)
	
	age.stop -- age stopped smoking, leave blank or set to NA for current smokers (years)
	
	smoke.intensity -- average number of cigarettes smoked per day
	
	future -- number of years into the future you wish to predict the individuals' risk of lung cancer
	
Examples:

	pred.lung( age=c(60,60,65), age.start=c(20,25,30), age.stop=c(40,50,60), smoke.intensity=c(20,20,20), future=5 )

		    [,1]
	[1,] 0.012405999
	[2,] 0.002867859
	[3,] 0.001406955
	
	pred.lung( age=c(60,60,65), age.start=c(20,25,30), smoke.intensity=c(20,20,20), future=5 )
                    [,1]
	[1,] 0.103097151
	[2,] 0.009852979
	[3,] 0.011400595

