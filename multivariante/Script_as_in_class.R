#Analisis multivariante


#Paquetes necesarios:
#install.packages()
library(vegan)
library(mvabund)
library(reshape2)

#PCA----
data(iris)
head(iris)

ir <- iris[,1:4]
pairs(ir)
cor(ir)
#run a PCA

#princomp()
pca <- prcomp(x = ir, center = TRUE, scale. = TRUE)
summary(pca)
#names(pca)
#pca$center
biplot(pca)
pca$x
#rda

#princomp(ir)

#NMDS / PERMANOVA----

Herbivores <- read.csv("multivariante/data/Herbivore_specialisation.csv")
head(Herbivores)
str(Herbivores)

herb <- dcast(data = Herbivores,
              formula = Habitat + DayNight + Replicate + Mass ~ species,
              fun.aggregate = sum,
              value.var = "abundance")
head(herb)

herb_comm <- herb[,5:11]
habitat <- herb$Habitat
daynight <- herb$DayNight

#1) matrix distances
?dist
?vegdist
?betadiver

vegdist(herb_comm, method = "bray")

#NMDS
herb_mds <- metaMDS(comm = herb_comm,
                    distance = "bray",
                    k = 2, autotransform = FALSE)
herb_mds$stress
#write.table(herb_mds, "path")
plot(herb_mds$points, col = habitat, pch = 16)
plot(herb_mds$points, col = daynight, pch = 16)
ordihull(herb_mds, group= habitat, draw = "polygon",
         col = "grey90")
#2) test

a <- adonis(herb_comm ~ habitat,
            method = "bray")
a

adonis(herb_comm ~ herb$Mass,
       method = "bray")

b <- betadisper(vegdist(herb_comm, "bray"),
                group = habitat,
                type = "centroid")
names(b)
anova(b)
boxplot(b)
TukeyHSD(b)
