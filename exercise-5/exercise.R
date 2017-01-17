# Exercise 5: Vector practice

# Create a vector `words` of 6 (or more) words.
# You can Google for a "random word generator" if you wish!
words <- c("a","black","book","is","a","scary","read")

# Create a new vector `words.of.the.day` that is your `words` vector with the string
# "is the word of the day!" pasted on to the end.
# BONUS: Surround the word in quotes (single or double) (e.g., `"data" is the word of the day!`)
words.of.day <- paste0("'", words, "'is the word of the day!'")
words.of.day

# Create a vector `a.f.words` which are the elements in `words` that start with "a" through "f"
# Hint: use a comparison operator to see if the word comes before "f" alphabetically!
# Tip: make sure all the words are lower-case, and only consider the first letter of the word!
a.f.words <- words[substring(words,1,1) <= "f"]
a.f.words

# Create a vector `g.m.words` which are the elements in `words` that start with "g" through "m"
g.m.words <- words[words >= "g" & substring(words,1,1) <= "m"]
g.m.words

# Define a function `WordBin` that takes in three arguments: a vector of words, and two letters. The function
# should return a vector of words that go between those letters alphabetically.
WordBin <- function(words, start, end){
  return(words[word >= start & substring(words,1,1) <= end])
}

# Use your `WordBin` function to determine which of your words start with "e" through "q"
WordBin(words, "e", "q")