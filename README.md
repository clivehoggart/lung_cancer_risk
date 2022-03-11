# Lung cancer risk
Prediction of lung cancer risk in age window implementing model described in:\
Hoggart C et al. A risk model for lung cancer incidence. Cancer Prev Res (Phila). 2012 Jun;5(6):834-46. doi: 10.1158/1940-6207.CAPR-11-0237. Epub 2012 Apr 11. PMID: 22496387; PMCID: PMC4295118.

# Installation
Clone this repository from your home directory using the following git command:

git clone https://github.com/clivehoggart/lung_cancer_risk.git

Alternatively, download the source files from the github website
(https://github.com/clivehoggart/lung_cancer_risk.git)

# To run
Load function in R \
source("")

Call function:\
  pred.lung( age, age.start, age.stop, smoke.intensity, future )

Arguments to the function are:
	age -- in years
  
	age.start -- age started smoking (years)
  
	age.stop -- age stopped smoking, leave blank or set to NA for current smokers (years)
  
	smoke.intensity -- average number of cigarettes smoked per day
  
	future -- number of years into the future you wish to predict the individuals' risk of lung cancer
