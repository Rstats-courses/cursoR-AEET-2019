#This script loads a few datasets
  #as an excuse to learn different functions in R

#Exersise 1: load dataset "extinction" in the folder "data" and
 # do an explorative analysis----

#read data
dat <- read.csv("data_exploration/data/extinction.csv", h = TRUE)

#explore data
head(dat)
str(dat)
summary(dat)
hist(dat$body_size)
hist(dat$extinction_risck)

#preliminar analysis
cor.test(dat$extinction_risck, dat$body_size)
m <- lm(dat$extinction_risck ~ dat$body_size)
summary(m)
plot(dat$extinction_risck ~ dat$body_size)
abline(m)
plot(m)
scatter.smooth(dat$extinction_risck ~ dat$body_size)

#take home message. Always plot your data

#Data manipulation----

#load 2 datasets, check them, make summary statistics of one and merge

#sites data:
sites <- read.csv("data_exploration/data/bumblebee_sites.csv", h=T)
str(sites)
head(sites)
#we need unique sites
unique(sites$Site)
#reshape package
#install.packages("reshape2")
library(reshape2)
sites2 <- dcast(data = sites, formula = Site + Corridor ~ . , fun.aggregate = mean, value.var = "landscape")
sites2
colnames(sites2)[3] <- "landscape"
sites2

#occurrence data:
occ <- read.csv("data_exploration/data/bumblebees.csv", h=T)
head(occ)
#fix species
table(occ$Gen_sp)
levels(occ$Gen_sp)[20] <- "Bombus_terrestris"
levels(occ$Gen_sp)[which(occ$Gen_sp == "Bombus_terrestre")] <- "Bombus_terrestris"
#remove species
occ2 <- subset(occ, !Gen_sp %in% c("Bombus_spp", "Bombus_spp."))

#Do the same using taxize
library(taxize)
#example using smaller species vectors, as taxize is slow.
#fix mispellings
gnr_resolve(names = "Osmia ruffa") # real name is "Osmia rufa"
#retrieve the species family
tax_name(query = c("Homo sapiens", "Osmia rufa", "Pinus canariensis"), get = "family", db = "itis")
#more at https://ropensci.org/tutorials/taxize_tutorial/

#Get plant genus! #grep y substr
position <- regexpr(pattern = "_", occ2$Flower_species)
occ2$plant_genus <- substr(occ2$Flower_species, 1, position-1)

#joins, reshape, merge
dat <- merge(occ2, sites2, by = "Site", all = TRUE)
str(occ2)
str(sites2)
str(dat)
head(dat)

#family apply()
?tapply
tapply(dat$Highest_temp, dat$Gen_sp, max)
dat <- droplevels(dat)
tapply(dat$Highest_temp, dat$Gen_sp, max)

# aggregate es slow sometimes and less flexible
aggregate(Highest_temp ~ Gen_sp,
          data = dat, FUN = max)



