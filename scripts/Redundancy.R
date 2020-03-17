##################### 4. Redundancy
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
    try(
    if(t[[i]][[j]] != "")
    {
      ngram[[i]][[j]] = tokenize_ngrams(t[[i]][[j]],n=10)
    }
    )
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

#TenGram[1]
#mean(text_stack_sample$Redundancy)
text_stack_sample$Redundancy

save.image("workspaces/RelPreval_redundancy_1431.RData")

write.csv(text_stack_sample[,c("file","Redundancy","RelaPre")],"scripts/RelaPre_Redun_file.csv")
