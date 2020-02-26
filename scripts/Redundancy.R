##### For document level:

###############

for (i in 1:length(t))
{
  print(i)
  temp = 0
  for (j in 1:nrow(N_table2))
  {
    ngrams = na.omit(unlist(ngram[[i]]))
    
    if(any(str_detect(ngrams,as.character(N_table2[j,"Fngram"]))))
    {
      temp = temp + 1 
    }
  }
  text_stack_sample$DocFlag[i] = temp   
}



#text_stack_sample$DocFlag