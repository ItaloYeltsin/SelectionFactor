require(effsize)
library(stringr)
setwd('/home/italo/IdeaProjects/SelectionFactor/')

factor = "./results/ReleasePlanning_FACTOR_dataset-2.txt";
fitness = "./results/ReleasePlanning_dataset-2.txt";
max_risk ="./results/ReleasePlanning_MAX_RISK_dataset-2.txt";
max_score = "./results/ReleasePlanning_MAX_SCORE_dataset-2.txt";
min_risk = "./results/ReleasePlanning_MIN_RISK_dataset-2.txt";
min_score = "./results/ReleasePlanning_MIN_SCORE_dataset-2.txt";

headers = c("score", "risk", "prec", "time");
headers2 = c("score", "prec", "time");
headers3 = c("risk", "prec", "time");

factorData <- read.table(factor ,col.names = headers) 
factorData <- abs(factorData)
fitnessData <- read.table(fitness ,col.names = headers)
fitnessData <- abs(fitnessData)
maxRiskData <- read.table(max_risk ,col.names = headers3) 
maxScoreData <- read.table(max_score ,col.names = headers2)
maxScoreData <- abs(maxScoreData)
minRiskData <- read.table(min_risk ,col.names = headers3) 
minRiskData = abs(minRiskData)
minScoreData <- read.table(min_score ,col.names = headers2)  
minScoreData <- abs(minScoreData)

bestScore = max(maxScoreData$score)
worstScore = min(minScoreData$score)

bestRisk = min(maxRiskData$risk)
worstRisk = max(minRiskData$risk)

factorNormalizedScore = (factorData$score - worstScore)/(bestScore - worstScore)
factorNormalizedRisk = (factorData$risk - worstRisk)/(bestRisk - worstRisk)

fitnessNormalizedScore = (fitnessData$score - worstScore)/(bestScore - worstScore)
fitnessNormalizedRisk = (fitnessData$risk - worstRisk)/(bestRisk - worstRisk)

factorDispersion = abs(factorNormalizedScore-factorNormalizedRisk)
fitnessDispersion = abs(fitnessNormalizedScore-fitnessNormalizedRisk)

wt = wilcox.test(factorDispersion, fitnessDispersion, exact = FALSE)

output = matrix(nrow = 4, ncol = 6)

output[1,1] = str_c(round(mean(factorData$score), 2), "$\\pm$", round(sd(factorData$score), 2))
output[1,2] = str_c(round(mean(factorData$risk), 2), "$\\pm$", round(sd(factorData$risk), 2))
output[2,1] = str_c(round(mean(fitnessData$score), 2), "$\\pm$", round(sd(fitnessData$score), 2))
output[2,2] = str_c(round(mean(fitnessData$risk), 2), "$\\pm$", round(sd(fitnessData$risk), 2))
output[1,3] = str_c(round(mean(factorNormalizedScore), 4), "$\\pm$", round(sd(factorNormalizedScore), 4))
output[2,3] = str_c(round(mean(fitnessNormalizedScore), 4), "$\\pm$", round(sd(fitnessNormalizedScore), 4))
output[1,4] = str_c(round(mean(factorNormalizedRisk), 4), "$\\pm$", round(sd(factorNormalizedRisk), 4))
output[2,4] = str_c(round(mean(fitnessNormalizedRisk), 4), "$\\pm$", round(sd(fitnessNormalizedRisk), 4))
output[1,5] = str_c(round(mean(factorDispersion), 4), "$\\pm$", round(sd(factorDispersion), 4))
output[2,5] = str_c(round(mean(fitnessDispersion), 4), "$\\pm$", round(sd(fitnessDispersion), 4))
output[1,6] = wt$p.value
output[3,1] = bestScore
output[3,2] = bestRisk
output[4,1] = worstScore
output[4,2] = worstRisk

write.table(output, file="results/RP_dataset-2.result", quote = FALSE ,sep = "\t", na = "-")
noquote(output)

