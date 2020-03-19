#################################### 3.	Specificity:

#Extract named entities using Stanford NER tool.
#Specificity is the no. of specific entity names, quantitative values, times/dates
#all scaled by the total number of words in document.

################################## load packages
library(stringr)
library(reticulate)
#use_python("C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Python 3.8")
use_python("/usr/bin/python")
#install.packages("spacyr")
library(spacyr)

#spacy_install(conda = "auto", version = "latest", lang_models = "en_core_web_sm",
              #python_version = "3.6", envname = "spacy_condaenv", pip = FALSE,
              #python_path = NULL, prompt = TRUE)

spacy_initialize(model = 'en_core_web_sm')

##### load files
load("workspaces/CSR_documents_30samples.RData")
load("workspaces/CSR_documents_file.RData")

text_stack_sample <- text_stack
#### parse the first document
document <- spacy_parse(text_stack_sample[,1])
names(document[[1]])
document_entity<- entity_extract(document, type = "all")
dim(document_entity)
head(document_entity,4)


############################################## parse all the documents
##the lapply will take about 2 mins 10 sec
#document<- lapply(text_stack_sample[,1],spacy_parse)

## the loop takes about 2 mins 10 sec for 30 files
document<-NULL

document[[458]] = 0
# for (i in 1:nrow(text_stack_sample)){
for (i in 459:nrow(text_stack_sample)){
  print(i)
  try(
  if(text_stack_sample[i,1] != ""){
    document[[i]]<-spacy_parse(text_stack_sample[i,1])
  }
  )
}

#warings()
#In spacy_parse.character(text_stack_sample[i, 1]) :
#lemmatization may not work properly in model 'en_core_web_sm'


########################################### extract all the entities
document_entity<- NULL
for (i in 1:length(document)){
  print(i)
    try( document_entity[[i]]<- entity_extract(document[[i]], type = "all") )
}

################################### Add length
text_stack_sample$Length<-str_count(text_stack_sample[,1], '\\w+')


################################## Add Entity Counts
text_stack_sample$EntityCount <- lapply(document_entity, nrow)


#################################  calculate the specificity
text_stack_sample$Specificity <- unlist(text_stack_sample$EntityCount) / text_stack_sample$Length

#text_stack_sample$Specificity
#CSR<-text_stack_sample[,-1]
#save(CSR, file = "workspaces/CSR.RData")

save.image("workspaces/Specificity_1431.RData")

write.csv(text_stack_sample[,c("file","Length", "Specificity")],"scripts/Specificity_file.csv",row.names=F)
