# This scripy plays with null models as an
#excuse to learn loops

#a simple null model to test correlations

#data
abundance <- c(1,3,4,8,7,13)
body_size <- c(9,6,3,3,1,1)

plot(abundance ~ body_size)
corr <- cor(abundance,body_size)
corr
cor.test(abundance,body_size)

#NUll model approach
#brake all processess execpt chance.
#Expected vs observed

#let's break the abundance - bodysize association
temp <- sample(x = body_size,
       size = length(body_size),
       replace = FALSE)

plot(abundance ~ temp)
cor(abundance, sample(x = body_size,
                        size = length(body_size),
                        replace = FALSE))
#loop it 1000 times
cor_dis <- c()
for(i in 1:1000){
  temp <- sample(x = body_size,
                 size = length(body_size),
                 replace = FALSE)
  cor_dis[i] <- cor(abundance, temp)
}

hist(cor_dis)
abline(v = corr, col = "red")
?pnorm
pnorm(q = corr,
      mean = mean(cor_dis),
      sd = sd(cor_dis))

#How uneven are abundance distributions??
abundance
#function to calculate puelou's

#J shannon/log(richness)
#S The proportion of species i
#relative to the total number of species ->p(i)
#multiplied by the natural logarithm of this
#proportion (lnPi).
#The resulting product is sumed across
#species and multiplied by -1:
#S = -sum(pi * log (pi))
J <- function(v){
  p <- v/sum(v)
  s <- -sum(p*log(p))
  s/log(length(v))
}
J(v = abundance)
#Is this eveneness higher than expected?
#calculate expected evenness
#tip: We need to sample 36 individuals
 #and assign them to species randomly
#them group by species
rand <- sample(c("sp1","sp2", "sp3", "sp4", "sp5", "sp6"),
       size = sum(abundance),
       replace = TRUE)
comm <- table(rand)
J(comm)

eve <- c()
for(k in 1:1000){
  rand <- sample(c("sp1","sp2", "sp3", "sp4", "sp5", "sp6"),
                 size = sum(abundance),
                 replace = TRUE)
  comm <- table(rand)
  eve[k] <- J(comm)
}
hist(eve)
abline(v = J(abundance), col = "red")

#Is body size driving the eveness pattern?


body_size <- c(9,6,3,3,1,1)

eve_bs <- c()
for(k in 1:1000){
  rand <- sample(c("sp1","sp2", "sp3", "sp4", "sp5", "sp6"),
                 size = sum(abundance),
                 replace = TRUE,
                 prob = 1/body_size)
  comm <- table(rand)
  eve_bs[k] <- J(comm)
}
hist(eve_bs)
abline(v = J(abundance), col = "red")

pnorm(J(abundance),
      mean = mean(eve_bs),
      sd = sd(eve_bs))











