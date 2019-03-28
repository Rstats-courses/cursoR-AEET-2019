#Este script usa models nulos para parcticar loops
#y funciones.


#Un modelo simple para testar correlaciones----

abundance <- c(1,3,4,7,8,13)
body_size <- c(9,6,3,3,1,1)
plot(abundance ~ body_size)
cor(abundance, body_size)
cor.test(abundance, body_size)

#nuestro modelo nulo
#Vamos a romper el patron de correlación:
null <- sample(x = abundance,
       size = length(abundance),
       replace = FALSE)
cor(null, body_size)

for (i in 1:10){
  print(i)
}


out <- matrix()
for (i in 1:1000){
  null <- sample(x = abundance,
                 size = length(abundance),
                 replace = FALSE)
  out[i] <- cor(null, body_size)
  }
hist(out)
abline(v = cor(abundance, body_size),
       col = "red")
#quantile(out, 0.01)
1-sum(out > cor(abundance, body_size))/length(out)

#More examples-----
abundance

#my first function
saluda <- function(x = "hola"){
  print(x)
}

saluda()

saluda(x = "hola")


#pielous

J <- function(x){
  pi <- x/sum(x)
  S <- -sum(pi*log(pi, base = 2))
  S/log(length(x), base = 2)
}

J(abundance)

#Calculate the evenness of a random assembly.
#tip: We need to sample 36 individuals and assing them to 6 species randomly

temp <- sample(x = c(1:6),
       size = sum(abundance), replace = TRUE)
J(table(temp))
#now do it 1000 times
out <- c()
for( i in 1:1000){
  out[i] <- J(table(sample(1:6,
                           sum(abundance),
                           replace = TRUE)))
}
hist(out)
abline(v = J(abundance),
       col = "red")


out <- c()
prob <- (body_size/sum(body_size))
for( i in 1:1000){
  out[i] <- J(table(sample(1:6,
                           sum(abundance),
                           replace = TRUE,
                           prob = prob)))
}
hist(out)
abline(v = J(abundance),
       col = "red")













