## 3. Compute boilerplate (Lang and Stice-Lawrence, 2015)

## Boilerplate definition: standardized disclosure that is so prevalent that it is unlikely to be informative.

#### LOGIC:
# Collect all tetragrams (ordered group of four words within each sentence) in each document in a list
# Remove frequently used tetragrams: Remove tetragrams that occur 60% or more across documents 
# from the list.   
# Identify tetragrams that occur in at least 30% of the documents or an average of at least 5 times 
# per document in the list (phrases commonly used in financial disclosures). Discard other tetragrams from the list.  
# BOILERPLATE = % of total words in document that are in sentences containing boilerplate tetragrams. 

library(stringr)
library(tokenizers)

install.koRpus.lang("en")
# load the package
library(koRpus.lang.en)

load("workspaces/CSR_documents_30samples.RData")

dim(text_stack_sample)

## Tokenize each tetragram in the document. Be mindful of the period in each sentence. 
### Remove numbers from strings before tokenizing

## Example for one document
t2 <- unlist(tokenize_sentences(text_stack_sample[1,1]))
summary(t2)

##############tokenize_sentences for all documents
t<-rep(list(0),30)
for(row in 1:nrow(text_stack_sample))
{
  print(row)
  if (text_stack_sample[row,1] != "")
  {
    t[row]=unlist(tokenize_sentences(text_stack_sample[row,1]))
  }
}

t[[1]]
install.packages(gsub)

####warnings: In t[row] <- unlist(tokenize_sentences(text_stack_sample[row,  ... :
###number of items to replace is not a multiple of replacement length
##warnings()


## Example for one sentence in one document
t3 <- tokenize_ngrams(t2[1],n=4)

as.factor(t3)

################### ngrams for all documents
ngram <- list(length=length(t))
for(i in 1:length(t))
{
  print(i)
  if(t[i] != "")
  {
    ngram[i] = tokenize_ngrams(t[[i]],n=4)
  }
}
ngram[[4]][[1]]
####################labeling sentence number
text_stack_sample$NumSenc= lapply(t,length) ###error

length(t[1]) ###535


install.packages()
######frequency
as.data.frame(table(text_stack_sample$ngrams))


### you need to run the tokenize_sentences for each document. Next, you need to tokenize each sentence into tetragrams.
### FInally, you can append all the tetragrams together into a dataframe (or list), 
## labeling their sentence number in a separate column or as a key value pair.
### For each tetragram, find the frequency (i.e., how many times, each tetragram used in each document).
### Append all tetragrams across all documents. Find the frequency of tetragrams across all documents. 
### 30% and 60% cut-off can be set and the respective tetragrams can be identified. Using the sentence number, 
### we can find out the number of words in that sentence to find the number of words in that sentence. 
### Finally this can be used to find the boilerplate score for each document. 


