#' Análise de Risco  (Imitando um modelo simples com Amostragem LHS)
#' ========================================================
#' Esta Análise simula 1000 casos usando distribuições uniformes.
#' A mesma análise foi realizada com o @Risk para a comparação dos resultados.
#' 
#' 
# Bibliotecas que vou usar
library(lhs)
library(ggplot2)
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
iteracoes = 1000
variaveisAleatorias = 3
VariaveisNoEnsemble = 6
# Setando a seed para o mesmo valor usado pelo @Risk
set.seed(1836642765)

#Definindo Meu Modelo
lucro = function(CustoFixo, CustoVariavel, Preco, Producao, Demanda) {
  lucro = min(Producao, Demanda)*Preco - Producao*CustoVariavel - CustoFixo
  return(lucro)
}

# Obtendo uma amostra LHS de 1000 pontos
amostra_lhs = randomLHS(iteracoes,variaveisAleatorias,preserveDraw = TRUE)

# Transformando o Hipercubo em variaveis

nomes_dados_simulados = c("CustoFixo", "CustoVariavel", "Preco", "Producao", "Demanda", "Lucro")
dados_simulados = matrix(NA,ncol=VariaveisNoEnsemble,nrow=iteracoes)
colnames(dados_simulados) = nomes_dados_simulados

# Atribuindo Variáveis Fixas
dados_simulados[,"CustoFixo"] = CustoFixo
dados_simulados[,"Producao"] = Producao

# Atribuindo Variaveis Aleatórias
dados_simulados[,"CustoVariavel"] = qunif(amostra_lhs[,1],min=CustoVariavelMinimo, max=CustoVariavelMaximo)
dados_simulados[,"Preco"] = qunif(amostra_lhs[,2],min=PrecoMinimo, max=PrecoMaximo)
dados_simulados[,"Demanda"] = qunif(amostra_lhs[,3],min=DemandaMinima, max=DemandaMaxima)


# Atribuindo as Variaveis de Output
dados_simulados [,"Lucro"] = lucro(dados_simulados[,"CustoFixo"],
                                   dados_simulados[,"CustoVariavel"],
                                   dados_simulados[,"Preco"], 
                                   dados_simulados[,"Producao"], 
                                   dados_simulados[,"Demanda"])

# Observando os Dados Simulados!
qplot(dados_simulados[,"Lucro"],geom = "histogram")

# Resumindo os Dados de Lucro
summary(dados_simulados[,"Lucro"])

quantile(dados_simulados[,"Lucro"],probs=c(0.05,0.95))
