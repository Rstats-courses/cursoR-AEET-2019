#This script will introduce multivarate anaysis


#load libraries----
library(vegan) #ade4
library(mvabund)
library(dplyr)

#PCA----
data(iris)
head(iris)
str(iris)
levels(iris$Species)

pairs(iris, lower.panel = NULL,
      col = as.numeric(iris$Species))
pairs(iris[,-5])
pairs(iris[,1:4])
cor(iris[,-5])

#pca
?princomp
?prcomp
#PCA {factoMineR}
#rds {vegan}

pca <- prcomp(iris[,1:4],
              scale. = TRUE,
              center = TRUE)
pca
summary(pca)
biplot(pca)

#R basics
#values
a <- 1
a <- "hola"
#vectors
b <- c(1:4)
b <- c("hola", "adios")
#matrices

c <- matrix(data = 1:4,
            nrow = 2,
            ncol = 2)
d <- list(a,b,c)

c(1,2,3) + c(1,2)

x <- c("hola", "adios", "casa", "perro")
which(x == "hola")
which(x %in% c("hola", "casa"))
which(x == "hola" | x == "casa") #&&
which(x == c("hola", "casa"))


#c(1,2,3) * c(1,2,3)

#NMDS & Permanova
#data
Herbivores <- read.csv(
  file = "multivariante/data/Herbivore_specialisation.csv")
head(Herbivores)
str(Herbivores)

habitat <- Herbivores$Habitat
daynight <- Herbivores$DayNight
community <- Herbivores[,5:11]
colnames(Herbivores)

?dist
?vegdist
?betadiver


#NMDS

mds <- metaMDS(comm = community,
               distance = "jaccard",
               k = 2,
               autotransform = TRUE)
?vegdist

names(mds)
plot(mds$points, col = habitat)

plot(mds$points, col = daynight)

mds$stress

ordiplot(mds, type = "n")
ordihull(mds, groups = habitat,
         draw = "polygon",
         col = "grey",
         labels = FALSE)
orditorp(mds, display = "species",
         col = "red")

#PERMANOVA
#Are centroids different?
a <- adonis(formula = community ~ habitat, method = "bray")
names(a)

a$coefficients

#is the spread different?
dist_com <- vegdist(x = community, method = "jaccard")
b <- betadisper(dist_com, group = habitat)
b
anova(b)
boxplot(b)


#mvabund example----

herb_data <- mvabund(community)
boxplot(community, horizontal = TRUE,
        las = 2, main = "abundance")
meanvar.plot(herb_data, xlab = "mean",
             ylab = "var")
plot(herb_data ~ habitat, cex.axis = 0.8,
     cex = 0.8)
#the model: GLM with shared error structure

mod1 <- manyglm(herb_data ~ habitat,
                family = "poisson")
plot(mod1)
#refit
mod2 <- manyglm(herb_data ~ habitat,
                family = "negative_binomial")
plot(mod2)
#test
anova(mod2)
#per sp
anova(mod2, p.uni = "adjusted")
names(mod2)

mod2$coefficients

#glm(response ~ gradient*species)












