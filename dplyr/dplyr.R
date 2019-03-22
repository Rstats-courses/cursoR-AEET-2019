# Exersise dplyr----
# using pipes (this is not a %>% )

#let's create 50 shadows of grey.
?grey
grey(c(0.1,0.3,0.4))

#make a function called shadows that gives you n secuential numbers between 0 y 1
shadows <- function(n){
  seq(0,1, length.out = n)
}

#calculate 50 shadows of grey:
grey(shadows(50))

#Now, let's do it dplyr stile
#install.packages("dplyr")
library(dplyr)
50 %>%  shadows %>% grey # %>% is shift cmd M

# dplyr as sintaxis
# Verbs
#* `filter()` - subset rows; like `base::subset()`
#* `arrange()` - reorder rows; like `order()`
#* `select()` - select columns
#* `mutate()` - add new columns
#* `summarise()` - like `aggregate`

#More examples:
#install.packages("babynames")
library(babynames)

head(babynames)
babynames

babynamesdf <- as.data.frame(babynames)
head(babynamesdf)

#family apply()
?tapply
tapply(babynamesdf$n, babynamesdf$year, max)

# aggregate
aggregate(n ~ year,
          data = babynamesdf, FUN = max)

#dplyr
babynames %>% group_by(year, sex)

babynames %>%
  group_by(year, sex) %>%
  filter(name == "Mary") %>%
  select(-prop)


#Exercise extra: #debug this function-----
#learn how to debug, split in pieces the problem, seacrh in stack overflow,
#learn that diferent fixes are always available

source(file = "extra/function.R")
#the function count_numbers will count how many times a given number appears
#has the following arguments:
#number: the number to search for
#vector: the vector where to search the number
#match: TRUE: return the number of matched numbers, FALSE return the number not matched numbres
x <- c(1, NA, 3, 2, 4, 2)

count_numbers(number = 2, vector = x, match = TRUE) #wrong
count_numbers(number = 5, vector = x, match = TRUE) #wrong
count_numbers(number = 2, vector = x, match = FALSE) #right?
count_numbers(number = 5, vector = x, match = FALSE) #right?

fixed_count_numbers <- function(number, vector = x, match = TRUE){
  if(match) y <- x[which(x == number)]
  if(!match) y <- x[-which(x == number)]
  length(y)
}

fixed_count_numbers(number = 2, vector = x, match = TRUE) #right!
fixed_count_numbers(number = 5, vector = x, match = TRUE) #right!
fixed_count_numbers(number = 2, vector = x, match = FALSE) #right?
fixed_count_numbers(number = 5, vector = x, match = FALSE) #wrong!!

fixed_count_numbers2 <- function(number, vector = x, match = TRUE){
  if(match) y <- x[which(x == number)]
  if(!match) y <- x[!(x %in% number)]
  length(y)
}

fixed_count_numbers2(number = 2, vector = x, match = TRUE) #right!
fixed_count_numbers2(number = 5, vector = x, match = TRUE) #right!
fixed_count_numbers2(number = 2, vector = x, match = FALSE) #right?
fixed_count_numbers2(number = 5, vector = x, match = FALSE) #right?
