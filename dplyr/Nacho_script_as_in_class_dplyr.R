#this script introduces dplyr

# dplyr----
?grey
grey(c(0,1))

mean(x)
?seq
#seq(0,1, length.out = 20)

shadows <- function(n){
  seq(0,1, length.out = n)
}

grey(shadows(50))

50 %>% shadows %>% grey #shift cmd M

#break: create a se function:
x <- c(1:4,NA)
se <- function(x, na.rm = FALSE){
  if(na.rm == TRUE){
    x2 <- x[which(is.na(x) == FALSE)]
    #warning("NA are removed")
    sd(x2)/sqrt(length(x2))
  } else {
    sd(x)/sqrt(length(x))
  }
}

se(c(14,5,2,NA), na.rm = TRUE)

#more dplyr examples

install.packages("babynames")
library(babynames)

babynames

#filter() #subset
#arrenge() #sorts
#select() #columns
#mutate() #add new colums
#summarize() # aggregares
#group_by()


#most popular name in the 80's

babynames %>%
  filter(year  %>% in% c(1980:1989)) %>%
  group_by(name) %>%
  summarise(total = sum(n)) %>%
  arrange(desc(total))

temp <- subset(as.data.frame(babynames),
               year => 1980 & year =< 1989)
temp2 <- tapply(temp$n, temp$name, sum)
head(temp2)
head(sort(temp2, decreasing = TRUE))

#year with more female babies named Mary

babynames %>%
  filter(name == "Mary" & sex == "F") %>%
  group_by(year) %>%
  summarise(total = sum(n)) %>%
  arrange(desc(total))

#Mean number of Maries per decade
?round
temp <- babynames %>%
  filter(name == "Mary") %>%
  mutate(decade = ceiling(year/10)) %>% #here maybe floor is more correct? I need to check.
  group_by(decade) %>%
  summarise(mean_dec = mean(n))


plot(temp$decade, temp$mean_dec)













