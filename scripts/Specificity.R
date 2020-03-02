#################################### 3.	Specificity:
  
#Extract named entities using Stanford NER tool. 
#Specificity is the no. of specific entity names, quantitative values, times/dates 
#all scaled by the total number of words in document.

############# load packages
library(koRpus.lang.en)

library(stringr)
library(tokenizers)

library(tidyverse)
library(tm)

library(rJava)
library(XML)

library(coreNLP)

downloadCoreNLP(type = "english")

initCoreNLP()

##################################
