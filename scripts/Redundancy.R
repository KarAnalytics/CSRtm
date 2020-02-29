##################### 2. Redundancy
####### % of 10-grams that occur more than once in each document 
load("workspaces/CSR_documents_30samples.RData")

################## load all the packages
library(koRpus.lang.en)

library(stringr)
library(tokenizers)

library(tidyverse)
library(tm)
library(rlist)

#################  tokenize_sentences for all documents, we removed the numbers here as well
t<-list(length=nrow(text_stack_sample))
for(row in 1:nrow(text_stack_sample))
{
  print(row)
  if (text_stack_sample[row,1] != "")
  {
    t[[row]] =unlist(tokenize_sentences(removeNumbers(text_stack_sample[row,1])))
  }
}

################  10-ngrams for all documents
ngram<- NULL
for(i in 1:length(t))
{
  print(i)
  ngram[[i]] = list(length = length(t[[i]]))
  for(j in 1:length(t[[i]]))
  {
    if(t[[i]][[j]] != "")
    {
      ngram[[i]][[j]] = tokenize_ngrams(t[[i]][[j]],n=10)
    }
  }
}


################ Calculate Redundancy
#<- as.data.frame(table(unlist(ngram)))%>%arrange(desc(Freq))

TenGram <- lapply(ngram,unlist)
TenGram <- lapply(TenGram, table)
TenGram <- lapply(TenGram, as.data.frame)

for (i in 1:length(TenGram)){
  text_stack_sample$Redundancy[i]<-sum(TenGram[i][[1]]$Freq>=2)/sum(TenGram[i][[1]]$Freq)
}


mean(text_stack_sample$Redundancy)

save(text_stack_sample, file = "workspaces/Redundancy.RData")



##### For document level:
###############

#for (i in 1:length(t))
#{
#  print(i)
#  temp = 0
#  for (j in 1:nrow(N_table))
#  {
#    ngrams = na.omit(unlist(ngram[[i]]))
#    
#    if(any(str_detect(ngrams,as.character(N_table[j,"Fngram"]))))
#    {
#      temp = temp + 1 
#    }
#  }
#  text_stack_sample$DocFlag[i] = temp   
#}



#text_stack_sample$DocFlag