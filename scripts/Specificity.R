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

#spacy_install(conda = "auto", version = "latest", lang_models = "en",
              #python_version = "3.6", envname = "spacy_condaenv", pip = FALSE,
              #python_path = NULL, prompt = TRUE)

spacy_initialize(model = 'en_core_web_sm')

##### load files
load("workspaces/CSR_documents_30samples.RData")
load("workspaces/CSR_documents_file.RData")

#### parse the first document
document <- spacy_parse(text_stack_sample[1,1])
names(document)
document_entity<- entity_extract(document, type = "all")
dim(document_entity)
head(document_entity,4)


############################################## parse all the documents
##the lapply will take about 2 mins 10 sec
#document<- lapply(text_stack_sample[,1],spacy_parse) 

## the loop takes about 2 mins 10 sec for 30 files
document<-NULL
for (i in 1:nrow(text_stack_sample)){
  print(i)
  if(text_stack_sample[,1] != ""){
    document[[i]]<-spacy_parse(text_stack_sample[i,1])
  }
}

#warings()
#In spacy_parse.character(text_stack_sample[i, 1]) :
#lemmatization may not work properly in model 'en_core_web_sm'


########################################### extract all the entities
document_entity<- NULL
for (i in 1:length(document)){
  print(i)
    document_entity[[i]]<- entity_extract(document[[i]], type = "all")
}

################################### Add length
text_stack_sample$Length<-str_count(text_stack_sample[,1], '\\w+')


################################## Add Entity Counts
text_stack_sample$EntityCount <- lapply(document_entity, nrow)


#################################  calculate the specificity
text_stack_sample$Specificity <- unlist(text_stack_sample$EntityCount) / text_stack_sample$Length

#text_stack_sample$Specificity

#save(text_stack_sample, file = "workspaces/Specificity.RData")

save.image("workspaces/Specificity_1431.RData")

write.csv(text_stack_sample[,c("file","Length", "Specificity")],"scripts/Specificity_file.csv",row.names=F)
