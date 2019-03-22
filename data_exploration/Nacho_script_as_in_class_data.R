#This script will explora data as an excuse to lear R


#Exersice 1: load data/extinction.csv" and explore.----

dat <- read.csv(file = "data_exploration/data/extinction.csv",
                header = TRUE,
                sep = ",")

#read.table
#read.delim

str(dat)
head(dat)
tail(dat)
dim(dat)
summary(dat)
plot(dat)
plot(dat$body_size, dat$extinction_risck)
hist(dat$body_size)

cor(dat)
m <- lm(extinction_risck ~ body_size, dat = dat)
plot(dat)
abline(m, col = "red")
scatter.smooth(dat$body_size,
               dat$extinction_risck,
               col = "red")
#take home message: Always plot your data.


#Data handling----

#bumblebee_sites.cvs, data folder.
sites <- read.csv("data_exploration/data/bumblebee_sites.csv")
str(sites)
head(sites)

unique(sites$Site)
library(reshape2)

#dcast
#1 row per site. Means onf landscape in cells. Corridor as column
sites2 <- dcast(data = sites,
                formula = Site + Corridor ~ .,
                fun.aggregate = mean, na.rm = TRUE,
                value.var = "landscape")
sites2
colnames(sites2)[3] <- "landscape"
#x <- c(10,20,30)
#x[1]

#bumblebee.csv

occ <- read.csv("data_exploration/data/bumblebees.csv")
head(occ)

table(occ$Gen_sp)

which(occ$Gen_sp %in% "Bombus_terrestre")
#==
#>
#<
#!=
#%in%

occ[which(occ$Gen_sp %in% "Bombus_terrestre"),
    "Gen_sp"] <- "Bombus_terrestris"
occ$Gen_sp[which(occ$Gen_sp %in% "Bombus_terrestre")] <- "Bombus_terrestris"

levels(occ$Gen_sp)
occ <- droplevels(occ)

#levels(occ$Gen_sp)[21] <- "Bombus_terrestris"
#occ[2, 1]

#remove spp and spp.

#which(occ$Gen_sp == c("Bombus_spp", "Bombus_spp."))

occ3 <- occ[-which(occ$Gen_sp %in% c("Bombus_spp", "Bombus_spp.")),]
occ2 <- occ[which(!occ$Gen_sp %in% c("Bombus_spp", "Bombus_spp.")),]
str(occ2)

dim(occ3)
dim(occ2)

#subset

#install.packages(taxize)
library(taxize)

sp <- c("Homo sapiens", "Osmia rufa", "Pinus canariensi")
temp <- gnr_resolve(names = "Pinus canariensi")
temp$matched_name

tax_name(query = sp, get = "family", db = "itis")

position <- regexpr(pattern = "_", text = occ$Flower_species,
        fixed = TRUE)

occ$Plant_genus <- substr(occ$Flower_species,
                          start = 1,
                          stop = position-1)

#

good_data <- merge(x = sites2, y = occ2, by = "Site", all = TRUE)


