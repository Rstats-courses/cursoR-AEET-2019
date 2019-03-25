#This script loads and merges datasets


# Ejercicio: load dataset "extinction" -----
#en la carpeta /data_exploration/data" y explorar.


dat <- read.csv(file = "data_exploration/data/extinction.csv")
#read.table

#explore
summary(dat)
str(dat)
head(dat)

#plot
plot(dat)
hist(dat$body_size)
boxplot(dat$body_size)

#preliminar analysis
cor(dat, method = "spearman")
scatter.smooth(dat$extinction_risck
               ~ dat$body_size,
               col = "red")

#Data manipulation----

#cargar dos datos, limpiarlos y unirlos

#1) Site Data:

#"bumblebee_sites.csv"


sites <- read.csv("data_exploration/data/bumblebee_sites.csv",
                  sep = ";", dec = ",")
head(sites)
str(sites)

#install.packages("reshape2")
library(reshape2)

sites2 <- dcast(data = sites,
                formula = Site ~ Corridor,
                fun.aggregate = sum,
                value.var = "Fower_abundance")
head(sites2)

colnames(sites2)[1:3] <- c("site", "flw_no_corridor", "flw_corridor")

head(sites2)

#2) occurrencias

#bumblebees.csv

occ <- read.csv("data_exploration/data/bumblebees.csv")
head(occ)
str(occ)
table(occ$Gen_sp)
#levels(occ$Gen_sp)[21] <- "Bombus_terrestris"
position <-  which(levels(occ$Gen_sp) == "Bombus_terrestre")
levels(occ$Gen_sp)[position]

position <-  which(occ$Gen_sp == "Bombus_terrestris")
occ$Gen_sp[position]

#eliminar no identificados

occ$Gen_sp[-which(occ$Gen_sp %in% c("Bombus_spp", "Bombus_spp."))]

occ2 <- subset(x = occ, subset = !Gen_sp %in% c("Bombus_spp", "Bombus_spp."))

occ$Gen_sp[-which(is.na(occ$Gen_sp))]

occ <- droplevels(occ)

#Use taxize
#install.packages("taxize")
library(taxize)
#erratas:
temp <- gnr_resolve(names = c("Bombus terrestres", "Cyphon ilaris"))
temp$matched_name
#recuerar familias
tax_name(query = c("Homo sapiens", "Pinus canariensis", "Osmia rufa"),
         get = "family", db = "itis")

head(occ)

#regular expresions
position <- regexpr(pattern = "_", text = occ$Flower_species, fixed = TRUE)
occ$plant_genus <- substr(x = occ$Flower_species,
                          start = 0,
                          stop = position-1)
occ$plant_species <- substr(x = occ$Flower_species,
                          start = position+1,
                          stop = nchar(as.character(occ$Flower_species)))

#3) Juntar sites2 y occ2

data <- merge(x = sites2,
              y = occ,
              by.x = c("site"),
              by.y = "Site",
              all.x = TRUE)
dim(sites2)
dim(occ)
dim(data)
