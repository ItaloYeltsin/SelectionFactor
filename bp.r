require(effsize)
library(stringr)
setwd('/home/italo/IdeaProjects/SelectionFactor/')

factor = "./results/BugPrioritization_FACTOR_dataset_inst100.txt";
fitness = "./results/BugPrioritization_FITNESS_dataset_inst100.txt";
max_risk ="./results/BugPrioritization_MAX_RISK_dataset_inst100.txt";
max_score = "./results/BugPrioritization_MAX_SCORE_dataset_inst100.txt";
min_risk = "./results/BugPrioritization_MIN_RISK_dataset_inst100.txt";
min_score = "./results/BugPrioritization_MIN_SCORE_dataset_inst100.txt";
min_importance = "./results/BugPrioritization_MIN_IMPORTANCE_dataset_inst100.txt";
max_importance = "./results/BugPrioritization_MAX_IMPORTANCE_dataset_inst100.txt";

headers = c("priority", "score", "risk", "prec", "time");
headers2 = c("score", "prec", "time");
headers3 = c("risk", "prec", "time");
headers4 = c("priority", "prec", "time");
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
maxImportanceData <- abs(read.table(max_importance ,col.names = headers4))
minImportanceData <- abs(read.table(min_importance ,col.names = headers4))

bestScore = max(maxScoreData$score)
worstScore = min(minScoreData$score)

bestRisk = min(maxRiskData$risk)
worstRisk = max(minRiskData$risk)

bestImportance = max(maxImportanceData$priority)
worstImportance = min(minImportanceData$priority)

factorNormalizedScore = (factorData$score - worstScore)/(bestScore - worstScore)
factorNormalizedRisk = (factorData$risk - worstRisk)/(bestRisk - worstRisk)
factorNormalizedPriority = (factorData$priority- worstImportance)/(bestImportance - worstImportance)

fitnessNormalizedScore = (fitnessData$score - worstScore)/(bestScore - worstScore)
fitnessNormalizedRisk = (fitnessData$risk - worstRisk)/(bestRisk - worstRisk)
fitnessNormalizedPriority = (fitnessData$priority - worstImportance)/(bestImportance-worstImportance)

factorDispersion = abs(factorNormalizedScore-factorNormalizedRisk) + abs(factorNormalizedScore-factorNormalizedPriority)+ abs(factorNormalizedPriority - factorNormalizedRisk)
factorDispersion = factorDispersion/3

fitnessDispersion = abs(fitnessNormalizedScore-fitnessNormalizedRisk) + abs(fitnessNormalizedScore - fitnessNormalizedPriority) + abs(fitnessNormalizedRisk - fitnessNormalizedPriority)
fitnessDispersion = fitnessDispersion/3
wt = wilcox.test(factorDispersion, fitnessDispersion, exact = FALSE)
wt

output = matrix(nrow = 4, ncol = 8)
output[1,1] = str_c(round(mean(factorData$priority), 2), "$\\pm$", round(sd(factorData$priority), 2))
output[1,2] = str_c(round(mean(factorData$score), 2), "$\\pm$", round(sd(factorData$score), 2))
output[1,3] = str_c(round(mean(factorData$risk), 2), "$\\pm$", round(sd(factorData$risk), 2))

output[2,1] = str_c(round(mean(fitnessData$priority), 2), "$\\pm$", round(sd(fitnessData$priority), 2))
output[2,2] = str_c(round(mean(fitnessData$score), 2), "$\\pm$", round(sd(fitnessData$score), 2))
output[2,3] = str_c(round(mean(fitnessData$risk), 2), "$\\pm$", round(sd(fitnessData$risk), 2))

output[1,4] = str_c(round(mean(factorNormalizedPriority), 4), "$\\pm$", round(sd(factorNormalizedPriority), 4))
output[2,4] = str_c(round(mean(fitnessNormalizedPriority), 4), "$\\pm$", round(sd(fitnessNormalizedPriority), 4))

output[1,5] = str_c(round(mean(factorNormalizedScore), 4), "$\\pm$", round(sd(factorNormalizedScore), 4))
output[2,5] = str_c(round(mean(fitnessNormalizedScore), 4), "$\\pm$", round(sd(fitnessNormalizedScore), 4))
output[1,6] = str_c(round(mean(factorNormalizedRisk), 4), "$\\pm$", round(sd(factorNormalizedRisk), 4))
output[2,6] = str_c(round(mean(fitnessNormalizedRisk), 4), "$\\pm$", round(sd(fitnessNormalizedRisk), 4))
output[1,7] = str_c(round(mean(factorDispersion), 4), "$\\pm$", round(sd(factorDispersion), 4))
output[2,7] = str_c(round(mean(fitnessDispersion), 4), "$\\pm$", round(sd(fitnessDispersion), 4))
output[1,8] = wt$p.value
bestImportance
output[3,1] = bestImportance
output[3,2] = bestScore
output[3,3] = bestRisk

output[4,1] = worstImportance
output[4,2] = worstScore
output[4,3] = worstRisk

write.table(output, file="results/BP_dataset_inst100.result", quote = FALSE ,sep = "\t", na = "-")
noquote(output)

