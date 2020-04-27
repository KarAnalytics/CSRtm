################################## 5. Relative_prevalence
### Since we do not have footnotes in CSR document (unlike 10-K)
###we will calculate relative prevalence as follows:
######  (Count of numbers in document i)/(Total number of words in document i)

## load package
library(RColorBrewer)
Sys.setenv(JAVA_HOME = 'C:/Program Files/Java/jdk-14.0.1')
library(rJava)
library(openNLP)
library(qdap)
library(stringr)



###### load data
load("workspaces/CSR_documents_30samples.RData")
load("workspaces/CSR_documents_file.RData")

text_stack_sample = text_stack

##### count all the numbers

for (i in 1:nrow(text_stack_sample)){
  print(i)
  if (text_stack_sample[i,1] != ""){
    a<-sum(word_count(text_stack_sample[i,1],digit.remove = FALSE),na.rm = TRUE)
    b<-sum(word_count(text_stack_sample[i,1],digit.remove = TRUE),na.rm = TRUE)
    text_stack_sample$countNum[i]<- a-b
  }
}

#text_stack_sample$countNum


################################### Add length
text_stack_sample$Length<-str_count(text_stack_sample[,1], '\\w+')



## calculate the relative prevalence
text_stack_sample$RelaPre <- text_stack_sample$countNum / text_stack_sample$Length
text_stack_sample$RelaPre

save.image("workspaces/RelPrevelance_1431.RData")

f
save(NewScore, file = "workspaces/NewRP.csv")

NewScore<- NULL
NewScore$file<-text_stack_sample$file
NewScore$OldScore<-text_stack_sample$RelaPre
NewScore$NEW<-text_stack_sample$NewRPscore
NewScore<-as.data.frame(NewScore)
head(NewScore,100)
mean(na.omit((NewScore$NEW-NewScore$OldScore)/NewScore$OldScore))

