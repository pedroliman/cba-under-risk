
library("lhs")

variaveis = 3

pontos = 2000

# Obtendo números aleatórios com LHS
X <- randomLHS(pontos, variaveis)

# Transformando o Hypercubo em variáveis
Y <- matrix(0, nrow=pontos, ncol=variaveis)

# Primeira variável é normal com média 3 e desv. pad. 0.1
Y[,1] <- qnorm(X[,1], mean=3, sd=0.1)

# Segunda Variável é beta, com média 2
Y[,2] <- qbeta(X[,2], shape1=2, shape2=3)

# Terceira Variável é uniforme, entre 10 e 100
Y[,3] = qunif(p=X[,3],min=10, max=100)


#Observando as Variáveis Do Hypercubo:

plot(X[,3],X[,2])

# Observando as Variáveis Das Distribuições
plot(Y[,3],Y[,2])

# check the preserveDraw option
set.seed(1976)
X <- randomLHS(6,3,preserveDraw=TRUE)
set.seed(1976)
Y <- randomLHS(6,5,preserveDraw=TRUE)
all(abs(X - Y[,1:3]) < 1E-12) # TRUE