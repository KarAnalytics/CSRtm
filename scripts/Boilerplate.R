## 3. Compute boilerplate (Lang and Stice-Lawrence, 2015)

## Boilerplate definition: standardized disclosure that is so prevalent that it is unlikely to be informative.

#### LOGIC:
# Collect all tetragrams (ordered group of four words within each sentence) in each document in a list
# Remove frequently used tetragrams: Remove tetragrams that occur 75% or more across documents 
# from the list.   
# Identify tetragrams that occur in at least 30% of the documents or an average of at least 5 times 
# per document in the list (phrases commonly used in financial disclosures). Discard other tetragrams from the list.  
# BOILERPLATE = % of total words in document that are in sentences containing boilerplate tetragrams. 


######### loading all the packages that are going to be used
install.koRpus.lang("en")
library(koRpus.lang.en)

library(stringr)
library(tokenizers)

library(tidyverse)
library(tm)


########load original data sample
load("workspaces/CSR_documents_30samples.RData")

dim(text_stack_sample)

## Tokenize each tetragram in the document. Be mindful of the period in each sentence. 
### Remove numbers from strings before tokenizing


##############tokenize_sentences for all documents, we removed the numbers here as well
t<-list(length=30)
for(row in 1:nrow(text_stack_sample))
{
  print(row)
  if (text_stack_sample[row,1] != "")
  {
    t[[row]] =unlist(tokenize_sentences(removeNumbers(text_stack_sample[row,1])))
  }
}

t[[1]]


####warnings: In t[row] <- unlist(tokenize_sentences(text_stack_sample[row,  ... :
###number of items to replace is not a multiple of replacement length
##warnings()



################### ngrams for all documents
ngram <- list(length=length(t))
for(i in 1:length(t))
{
  print(i)
  ngram[[i]] = list(length = length(t[[i]]))
  for(j in 1:length(t[[i]]))
  {
    if(t[[i]][[j]] != "")
    {
      ngram[[i]][[j]] = tokenize_ngrams(t[[i]][[j]],n=4)
    }
  }
}

ngram[[4]][[1]]





####################labeling sentence number
for (a in 1:30) {
  text_stack_sample$SenCount[a] <- length(ngram[[a]])
}


######### Add length
text_stack_sample$Length<-str_count(text_stack_sample[,1], '\\w+')


#### have a look of new col
text_stack_sample%>%
  select(SenCount,Length)


### get all ngram to one list

list_tetragrams = list(length(nrow(text_stack_sample)))

for(row in 1:nrow(text_stack_sample))
{
  temp  = unlist(ngram[row])
  temp = as.data.frame(table(temp))
  # temp %>% arrange(desc(Freq))
  list_tetragrams[[row]] = temp$temp    
}

list_tetragrams[[1]]

#Fngram<- unlist(text_stack_sample_Boiler$ngram)
Fngram<- unlist(unlist(list_tetragrams))

Fngram<- list(Fngram)

N_table<-as.data.frame(table(Fngram))
names(N_table)
save(N_table, file = "workspaces/N_table.csv")

N_table2 = N_table%>%
  arrange(desc(Freq))%>%
  mutate(prop=Freq/30) %>% filter(prop>0.3 & prop<=0.75)

save(N_table2, file = "workspaces/N_table2.csv")
### you need to run the tokenize_sentences for each document. Next, you need to tokenize each sentence into tetragrams.
### FInally, you can append all the tetragrams together into a dataframe (or list), 
## labeling their sentence number in a separate column or as a key value pair.
### For each tetragram, find the frequency (i.e., how many times, each tetragram used in each document).
### Append all tetragrams across all documents. Find the frequency of tetragrams across all documents. 
### 30% and 75% cut-off can be set and the respective tetragrams can be identified. Using the sentence number, 
### we can find out the number of words in that sentence to find the number of words in that sentence. 
### Finally this can be used to find the boilerplate score for each document. 


