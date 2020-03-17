## 1. Compute length of document (in terms of number of words)
## 2. Compute the Fog-index based on (Loughran and McDonald, 2014) 


library(stringr)
library(koRpus)

install.koRpus.lang("en")
# load the package
library(koRpus.lang.en)

load("workspaces/CSR_documents_30samples.RData")
load("workspaces/CSR_documents_file.RData")

text_stack_sample = text_stack

dim(text_stack_sample)

## Length of document in terms of number of words
text_stack_sample$length = str_count(text_stack_sample[,1], '\\w+')

## Readability or Fog-index of each document
system.time(
  for(row in 1:nrow(text_stack_sample))
  {
    print(row)
    # temp = tokenize(text_stack[row,1], format = "obj", lang="en",doc_id=paste("sample_",row,sep="") )
    if (text_stack_sample[row,1] != "")
    {
      temp = tokenize(text_stack_sample[row,1], format = "obj", lang="en",doc_id="sample" )
      text_stack_sample[row,"FOG"] =   try(as.numeric(FOG(temp)[1])) 
    }
  }
)

text_stack_sample_FOG = text_stack_sample

write.csv(text_stack_sample_FOG[,2:ncol(text_stack_sample_FOG)],"scripts/fog_file.csv")

#save(text_stack_sample_FOG, file = "workspaces/CSR_documents_30samples_FOG.RData")
save.image("workspaces/Fog_index_1431.RData")
