
# From: https://www.youtube.com/watch?v=xuUMz8exU8Q


# funções do R para gerar números aleatórios
runif(n=1, min=0, max=1) # rNameofDist gera números

runif(n=1000) # mil números aleatórios...

# Gerando uma distribuição uniforme...
random.uniform.1000 <- runif(n=10000,min=0,max=1)
hist(random.uniform.1000)

# Gerando uma distribuição normal..
random.normal.1000 <- rnorm(n=10000,mean=5,sd=2)

par(mfrow=c(3,1)) # essa função altera a estrutura do gráfico gerando uma imagem apenas
plot(random.normal.1000)
boxplot(random.normal.1000)
hist(random.normal.1000)


# pegando estatísticas descritivas da distribuição
mean(random.normal.1000)
sd(random.normal.1000)


generateNormal <- function(x) {
  result <- rnorm(n=x,mean=5,sd=2)
  return(result) 
}

random.normal.100.1 = generateNormal(100)
random.normal.100.2 = generateNormal(100)
random.normal.100.3 = generateNormal(100)
random.normal.100.4 = generateNormal(100)
par(mfrow=c(2,2))
hist(random.normal.100.1)
hist(random.normal.100.2)
hist(random.normal.100.3)
hist(random.normal.100.4)
mean(random.normal.100.1); mean(random.normal.100.2); mean(random.normal.100.3); mean(random.normal.100.4)





### uma forma mais eficiente de realizar a simulação

## Gerando uma replicação
random.normal.100.rep <- replicate(n=4,generateNormal(10))
par(mfrow=c(2,2))

# A função apply repete a chamada à função hist, para cada coluna (colocando MARGIN=2) ou para cada linha (usando MARGIN=1).
apply(X=random.normal.100.rep,MARGIN=2,FUN=hist)

apply(random.normal.100.rep,2,mean)

apply(random.normal.100.rep,2,sd)

summary(random.normal.100.rep)

sd(apply(random.normal.100.rep,2,mean))



## Executando esta ideia com um modelo melhor..
# y =  n(a+b*x, sd)
par(mfrow=c(2,2))
a=5
b=0.7
x = seq(2,5)
y_fixed = a + b*x
plot(y_fixed~x, main= "Componente Determinístico do Modelo")
abline(a=5,b=0.7)

# Incorporando variabilidade aos resultados

y_simulated = rnorm(length(x),mean=y_fixed,sd=2)
plot(y_simulated~x)
abline(a=5,b=0.7)

# Realizando uma regressão com os dados...

y_simulated_lm = lm(y_simulated ~ x) # realizando uma regressão
summary(y_simulated_lm) # resumo da regressão

y_simulated_lm

confint(y_simulated_lm,level=0.90) # intervalo de confiança


# plotando a linha de regressão normal
abline(reg=y_simulated_lm,lty=2)
