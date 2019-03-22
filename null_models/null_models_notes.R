#This script plays with null models as a way to practice more loops.

#A simple null model used to test correlations----

#The data
abundance <- c(1,3,4,7,8,13)
body_size <- c(9,6,3,3,1,1)
plot(abundance ~ body_size)
corr <- cor(abundance,body_size)
cor.test(abundance,body_size)

#The null model:
#idea: Brake all procesess except for the proces of interest and compare the
#observed with the expected data.

#In this case we want to test if this correlation may be due to randomness.
#We brake then the "body_size" process and left only randomness. use `sample()`

cor(sample(body_size, size = length(body_size), replace = FALSE), abundance)

#we do it 1000 times
cor_dis <- c()
for (k in 1:1000){
  cor_dis[k] <- cor(sample(body_size, size = length(body_size), replace = FALSE), abundance)
}

#plot
hist(cor_dis)
lines(c(corr, corr), c(0,200), col = "red")

#test p-value
(p <- pnorm(corr, mean = mean(cor_dis), sd = sd(cor_dis)))


#Another example----
#We observe a pattern: How uneven are abundance distributions?
abundance <- c(1,3,4,7,8,13)
#calculate pielou's evenees (shannon/logarithm of number of species)
#Shannon The proportion of species i relative to the total number of species
#(pi) is calculated, and then multiplied by the natural logarithm of
#this proportion (lnpi). The resulting product is summed across species,
#and multiplied by -1:
J <- function(v){
  p <- v/sum(v)
  S <- -sum(p * log(p))
  S/log(length(v))
}
eve <- J(abundance)
#is this eveness higher than expected?
#calculate evenness of a random assembly
#tip: we need to sample 36 individuals and assign them a species randomly
#then, we can group per species.
rand <- sample(c(1:6), sum(abundance), replace = TRUE)
abundance2 <- table(rand)
#abundance2 <- hist(rand, breaks = seq(0,6,1))$counts #this does the same, plots store data!
#Calculate J of the simulated community
J2 <- J(abundance2)
# now make it 1000 times
out <- c()
for(i in 1:100){
  rand <- sample(c(1:6), 36, replace = TRUE)
  abundance2 <- hist(rand, breaks = seq(0,6,1))$counts
  J2 <- J(abundance2)
  out <- c(out, J2)
}
#calculate p-value
hist(out)
lines(c(eve, eve), c(0,20), col = "red")
(p <- pnorm(eve, mean = mean(out, na.rm = TRUE), sd = sd(out, na.rm = TRUE)))

#null model 2.
#We want to test now if body size is driving the eveness patterns.
#we create a null model where body_size is the only responsible of the
#observed pattern
abundance <- c(1,3,4,7,8,13)
body_size <- c(9,6,5,3,2,1)
#Do one iteration
sample(c(1:6), 36, replace = TRUE, prob = body_size)
# make a loop
out_bs <- c()
for(i in 1:1000){
  rand <- sample(c(1:6), 36, replace = TRUE, prob = body_size)
  abundance2 <- hist(rand, breaks = seq(0,6,1))$counts
  J2 <- J(abundance2)
  out_bs <- c(out_bs, J2)
}
#And test significance
hist(out_bs)
lines(c(eve, eve), c(0,400), col = "red")
(p <- pnorm(eve, mean = mean(out_bs, na.rm = TRUE), sd = sd(out_bs, na.rm = TRUE)))
(p <- 1- pnorm(eve, mean = mean(out_bs, na.rm = TRUE), sd = sd(out_bs, na.rm = TRUE)))
#we remove NA's as in function J, log(richness) is NA when a species abundance is 0.
#basically we ignore those cases, as we are only interested in communities with all species
#having positive abundances.

#Other implmented null models in R
library(vegan)
library(bipartite)

#vegan example
## Use quantitative null models to compare
## mean Bray-Curtis dissimilarities
data(dune)
meandist <- function(x) mean(vegdist(x, "bray"))
mbc1 <- oecosimu(dune, meandist, "r2dtable")
mbc1


#bipartite example
data(Safariland)
head(Safariland)
plotweb(Safariland)
nullmodel(Safariland, N=2, method=1)
nullmodel(Safariland>0, N=2, method=4)
# analysis example:
obs <- unlist(networklevel(Safariland, index="weighted nestedness"))
nulls <- nullmodel(Safariland, N=100, method=1)
null <- unlist(sapply(nulls, networklevel, index="weighted nestedness")) #takes a while ...

plot(density(null), xlim=c(min(obs, min(null)), max(obs, max(null))),
     main="comparison of observed with null model Patefield")
abline(v=obs, col="red", lwd=2)

praw <- sum(null>obs) / length(null)
ifelse(praw > 0.5, 1-praw, praw)    # P-value



#further reading:

#neutral model Hubell: http://artax.karlin.mff.cuni.cz/r-help/library/untb/html/expected.abundance.html
#EcoSIm: http://www.uvm.edu/~ngotelli/EcoSim/Niche%20Overlap%20Tutorial.html
#vegan: http://cc.oulu.fi/~jarioksa/softhelp/vegan/html/oecosimu.html
#Against Null models:https://theoreticalecology.wordpress.com/2017/06/06/whats-wrong-with-null-models/
