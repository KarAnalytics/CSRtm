library(tm)
library(stringr)

load("workspaces/CSR_documents_file.RData")

text_stack_sample = text_stack

##### Calculate the score

for (i in 1:nrow(text_stack_sample)){
  if (text_stack_sample[i,1] != ""){
    print(i)
    a<-str_count(text_stack_sample[i,1],'\\w+')
    b<-str_count(removeNumbers(text_stack_sample[i,1]),'\\w+')
    text_stack_sample$NewRPscore[i]<- (a-b)/a
  }
}

save.image("workspaces/New_RelPrevelance_1431.RData")

#save(text_stack_sample, file = "workspaces/Relative_prevalece.RData")


