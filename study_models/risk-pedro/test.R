
source("risk-analysis.R")

# Definindo parâmetros
Producao = 200
CustoFixo = 800
CustoVariavelMinimo = 20
CustoVariavelMaximo = 30
PrecoMinimo = 30
PrecoMaximo = 40
DemandaMinima = 200
DemandaMaxima = 400


# Parametros que não se deve alterar:
iteracoes = 200
variaveisAleatorias = 3
VariaveisNoEnsemble = 6

# Observando os Dados Simulados!

dados = simular(CustoFixo, CustoVariavel, Preco, Producao, Demanda, iteracoes, variaveisAleatorias, VariaveisNoEnsemble)

qplot(dados[,"Lucro"],geom = "histogram")
