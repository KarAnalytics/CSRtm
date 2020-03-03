################################## 5. Relative_prevalence
### Since we do not have footnotes in CSR document (unlike 10-K)
###we will calculate relative prevalence as follows:
######  (Count of numbers in document i)/(Total number of words in document i)

## load package
library(qdap)
library(stringr)


###### load data
load("workspaces/CSR_documents_30samples.RData")


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

#save(text_stack_sample, file = "workspaces/Relative_prevalece.RData")
