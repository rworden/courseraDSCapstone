## https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
# unzip("Coursera-SwiftKey.zip")
library(stringr)
library(tidyr)
library(dplyr)
library(tidytext)
library(gsubfn)

# twitter<-readLines("en_US.twitter.txt")
# blog<-readLines("en_US.blogs.txt")
# news<-readLines("en_US.news.txt")
# all<-c(twitter,blog,news)

all_sample <- readLines("test.txt")

# #########
# Sample #
# #########
# sampler <- function(ds,prob) {
#     obs <- length(ds)
#     obs_out <- obs * prob
#     ds_samp<-sample(ds,obs_out)
#     return(ds_samp)
# }
# all_sample<-sampler(all,.01)
# all_sample<-tolower(gsub("[^a-zA-Z ]","",all_sample))

docs_unigram <- data_frame(text=all_sample) %>% 
    unnest_tokens(word,text,token="words")
docs_bigram <- data_frame(text=all_sample) %>% 
    unnest_tokens(ngram,text,token="ngrams",n = 2)
docs_trigram <- data_frame(text=all_sample) %>% 
    unnest_tokens(ngram,text,token="ngrams",n = 3)
docs_quadgram <- data_frame(text=all_sample) %>% 
    unnest_tokens(ngram,text,token="ngrams",n = 4)

docs_quadgram_cnt <- docs_quadgram %>%
    count(ngram, sort = TRUE)
docs_trigram_cnt <- docs_trigram %>%
    count(ngram, sort = TRUE) 
docs_bigram_cnt <- docs_bigram %>%
    count(ngram, sort = TRUE) 
docs_unigram_cnt <- docs_unigram %>%
    count(word, sort = TRUE) 

docs_quadgram_cnt <- as.data.frame(docs_quadgram_cnt)
docs_trigram_cnt <- as.data.frame(docs_trigram_cnt)
docs_bigram_cnt <- as.data.frame(docs_bigram_cnt)
docs_unigram_cnt <- as.data.frame(docs_unigram_cnt)
names(docs_unigram_cnt) <- c("ngram","n")