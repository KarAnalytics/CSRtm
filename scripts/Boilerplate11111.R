library(stringr)
library(tokenizers)

install.koRpus.lang("en")
library(koRpus.lang.en)

load("workspaces/CSR_documents_30samples.RData")

install.packages("stringr")
install.packages("tm")

library(stringr)
library(tm)

#take off all the numbers and special characters
text_stack_sample[1,1]
t1<-removeNumbers(text_stack_sample[1,1])
######t1<-gsub("[^a-zA-Z]", "", t1)

## Tokenize each tetragram in the document.
t1<-unlist(tokenize_sentences(t1))
summary(t1) #570
t1

###ngram
t1 <- tokenize_ngrams(t1,n=4)
t1



#2
t2<-removeNumbers(text_stack_sample[2,1])
t2<-unlist(tokenize_sentences(t2))
summary(t2) #1064
t2 <- tokenize_ngrams(t2,n=4)


#3
t3<-removeNumbers(text_stack_sample[3,1])
t3<-unlist(tokenize_sentences(t3))
summary(t3) #884
t3 <- tokenize_ngrams(t3,n=4)


#4
t4<-removeNumbers(text_stack_sample[4,1])
t4<-unlist(tokenize_sentences(t4))
summary(t4) #562
t4 <- tokenize_ngrams(t4,n=4)


#5
t5<-removeNumbers(text_stack_sample[5,1])
t5<-unlist(tokenize_sentences(t5))
summary(t5) #2007
t5 <- tokenize_ngrams(t5,n=4)

#6
t6<-removeNumbers(text_stack_sample[6,1])
t6<-unlist(tokenize_sentences(t6))
t6 <- tokenize_ngrams(t6,n=4)


#7
t7<-removeNumbers(text_stack_sample[7,1])
t7<-unlist(tokenize_sentences(t7))
t7 <- tokenize_ngrams(t7,n=4)


#8
t8<-removeNumbers(text_stack_sample[8,1])
t8<-unlist(tokenize_sentences(t8))
t8 <- tokenize_ngrams(t8,n=4)
 

#9
t9<-removeNumbers(text_stack_sample[9,1])
t9<-unlist(tokenize_sentences(t9))
t9 <- tokenize_ngrams(t9,n=4)


#10
t10<-removeNumbers(text_stack_sample[10,1])
t10<-unlist(tokenize_sentences(t10))
t10 <- tokenize_ngrams(t10,n=4)


#11
t11<-removeNumbers(text_stack_sample[11,1])
t11<-unlist(tokenize_sentences(t11))
t11 <- tokenize_ngrams(t11,n=4)


#12
t12<-removeNumbers(text_stack_sample[12,1])
t12<-unlist(tokenize_sentences(t12))
t12 <- tokenize_ngrams(t12,n=4)


#13
t13<-removeNumbers(text_stack_sample[13,1])
t13<-unlist(tokenize_sentences(t13))
t13 <- tokenize_ngrams(t13,n=4)


#14
t14<-removeNumbers(text_stack_sample[14,1])
t14<-unlist(tokenize_sentences(t14))
t14 <- tokenize_ngrams(t14,n=4)


#15
t15<-removeNumbers(text_stack_sample[15,1])
t15<-unlist(tokenize_sentences(t15))
t15 <- tokenize_ngrams(t15,n=4)

#16
t16<-removeNumbers(text_stack_sample[16,1])
t16<-unlist(tokenize_sentences(t16))
t16 <- tokenize_ngrams(t16,n=4)


#17
t17<-removeNumbers(text_stack_sample[17,1])
t17<-unlist(tokenize_sentences(t17))
t17 <- tokenize_ngrams(t17,n=4)


#18
t18<-removeNumbers(text_stack_sample[18,1])
t18<-unlist(tokenize_sentences(t18))
t18 <- tokenize_ngrams(t18,n=4)


#19
t19<-removeNumbers(text_stack_sample[19,1])
t19<-unlist(tokenize_sentences(t19))
t19 <- tokenize_ngrams(t19,n=4)


#20
t20<-removeNumbers(text_stack_sample[20,1])
t20<-unlist(tokenize_sentences(t20))
t20 <- tokenize_ngrams(t20,n=4)


#21
t21<-removeNumbers(text_stack_sample[21,1])
t21<-unlist(tokenize_sentences(t21))
t21 <- tokenize_ngrams(t21,n=4)


#22
t22<-removeNumbers(text_stack_sample[22,1])
t22<-unlist(tokenize_sentences(t22))
t22 <- tokenize_ngrams(t22,n=4)


#23
t23<-removeNumbers(text_stack_sample[23,1])
t23<-unlist(tokenize_sentences(t23))
t23 <- tokenize_ngrams(t23,n=4)


#24
t24<-removeNumbers(text_stack_sample[24,1])
t24<-unlist(tokenize_sentences(t24))
t24 <- tokenize_ngrams(t24,n=4)


#25
t25<-removeNumbers(text_stack_sample[25,1])
t25<-unlist(tokenize_sentences(t25))
t25 <- tokenize_ngrams(t25,n=4)


#26
t26<-removeNumbers(text_stack_sample[26,1])
t26<-unlist(tokenize_sentences(t26))
t26 <- tokenize_ngrams(t26,n=4)


#27
t27<-removeNumbers(text_stack_sample[27,1])
t27<-unlist(tokenize_sentences(t27))
t27 <- tokenize_ngrams(t27,n=4)


#28
t28<-removeNumbers(text_stack_sample[28,1])
t28<-unlist(tokenize_sentences(t28))
t28 <- tokenize_ngrams(t28,n=4)


#29
t29<-removeNumbers(text_stack_sample[29,1])
t29<-unlist(tokenize_sentences(t29))
t29 <- tokenize_ngrams(t29,n=4)


#30
t30<-removeNumbers(text_stack_sample[30,1])
t30<-unlist(tokenize_sentences(t30))
t30 <- tokenize_ngrams(t30,n=4)


###add to data set
for (a in 1:30) {
  text_stack_sample$ngram[[a]] <- eval(parse(text = paste0("t", a)))
}


###label sentence number
for (a in 1:30) {
  text_stack_sample$SenCount[a] <- length(text_stack_sample$ngram[[a]])
}


text_stack_sample_Boiler = text_stack_sample

save(text_stack_sample_Boiler, file = "workspaces/CSR_documents_30samples_Boiler.RData")

