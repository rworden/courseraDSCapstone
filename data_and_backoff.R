# prediction method: direct, back off, least common word correlation

findStart <- function (phrase) { ## count the number of words in a phrase
    phrase <- trimws(phrase,which = c("both")) # trim whitespace
    if (nchar(phrase) == 0) {
        print("please enter something")
    }
    else {
        n <- length(str_extract_all(phrase,"[a-z]+")[[1]])
    }
    if (n > 3) { # restrict our max word count to three for backoffModel
        n <- 3
    }
    return(n)
}

bigSentence <- function(phrase, n) { ## for large sentences, only consider last three words
    if (n > 3) {
        word_count <- length(strsplit(phrase," ")[[1]])
        last_word_pos <- word_count - 0
        secondlast_word_pos <- word_count - 1
        thirdlast_word_pos <- word_count - 2
        last_word <- strsplit(phrase," ")[[1]][last_word_pos]
        secondlast_word <- strsplit(phrase," ")[[1]][secondlast_word_pos]
        thirdlast_word <- strsplit(phrase," ")[[1]][thirdlast_word_pos]
        phrase <- paste(thirdlast_word,secondlast_word,last_word)
        print(phrase)
    } else {
        phrase <- phrase
    }
    return(phrase)
}

findNext <- function(phrase) {
    n<-findStart(phrase) # count words
    phrase <- bigSentence(phrase, n) # process phrase
    if (n == 1) { # set tables based on word count
        assign("start_lookup","docs_bigram_cnt", pos = 1)
    } else if (n == 2) {
        assign("start_lookup","docs_trigram_cnt", pos = 1)
    } else if (n == 3) {
        assign("start_lookup","docs_quadgram_cnt", pos = 1)
    } 
    match <- paste(start_lookup,"$ngram",sep="") # select field from table
    assign("matchset", match,pos = 1) 
    # TODO bug on outputChoice("i am not a") == "am not aware of" but returns "i am not a of"
    a<-as.data.frame(subset(eval(parse(text=start_lookup)),grepl(paste("^",phrase,sep=""),eval(parse(text=matchset))),perl = TRUE))
    print(nrow(a))
    while (nrow(a) == 0 & n > 0) {
        depth <- n
        b <- backoffModel(phrase, depth)
        print(n)
        n <- n - 1
        a<-as.data.frame(subset(eval(parse(text=start_lookup)),grepl(paste("^",b,sep=""),eval(parse(text=matchset))),perl = TRUE))
    }
    print(nrow(a))
    return(a)  
}

backoffModel <- function(phrase, depth) {
    ln_backoff <- length(strsplit(phrase," ")[[1]]) # 3 2 or 1
    start_backoff <- ln_backoff - depth + 1
    phrase <- paste0(str_extract_all(phrase,"[a-z]+")[[1]][start_backoff:ln_backoff], collapse =" ")
    return(phrase)
}

## find the last word or words for our input phrase in ngram+1 table
## input phrase should be processed with findNext() first and input as data
findLast <- function(phrase) { 
    data <- findNext(phrase)
    mx <- max(data$n)
    nxt <- data[data$n == mx,]$ngram
    nxt <- strapplyc(nxt, "(\\S[a-z]*)$")
    nxt <- nxt[[1]] # arbitrarily break the tie for now TODO. Fails if no match
    return(nxt) ## if length(nxt > 1), we have a list of tied elements b[[1]]
}

outputChoice <- function(phrase) {
    data <- findLast(phrase)
    out <- paste(phrase,data[[1]],sep=" ")
    out
}