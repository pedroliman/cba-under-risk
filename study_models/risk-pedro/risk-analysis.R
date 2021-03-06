#' An�lise de Risco  (Imitando um modelo simples com Amostragem LHS)
#' ========================================================
#' Esta An�lise simula 1000 casos usando distribui��es uniformes.
#' A mesma an�lise foi realizada com o @Risk para a compara��o dos resultados.
#' 
#' 
# Bibliotecas que vou usar
library(lhs)
library(ggplot2)


# Setando a seed para o mesmo valor usado pelo @Risk
set.seed(2000)

#Definindo Meu Modelo
lucro = function(CustoFixo, CustoVariavel, Preco, Producao, Demanda) {
  lucro = min(Producao, Demanda)*Preco - Producao*CustoVariavel - CustoFixo
  return(lucro)
}

#Rodando a An�lise

simular = function(CustoFixo, CustoVariavel, Preco, Producao, Demanda, iteracoes, variaveisAleatorias, VariaveisNoEnsemble) {
  # Obtendo uma amostra LHS de 1000 pontos
  amostra_lhs = randomLHS(iteracoes,variaveisAleatorias,preserveDraw = TRUE)
  
  # Transformando o Hipercubo em variaveis
  
  nomes_dados_simulados = c("CustoFixo", "CustoVariavel", "Preco", "Producao", "Demanda", "Lucro")
  dados_simulados = matrix(NA,ncol=VariaveisNoEnsemble,nrow=iteracoes)
  colnames(dados_simulados) = nomes_dados_simulados
  
  # Atribuindo Vari�veis Fixas
  dados_simulados[,"CustoFixo"] = CustoFixo
  dados_simulados[,"Producao"] = Producao
  
  # Atribuindo Variaveis Aleat�rias
  dados_simulados[,"CustoVariavel"] = qunif(amostra_lhs[,1],min=CustoVariavelMinimo, max=CustoVariavelMaximo)
  dados_simulados[,"Preco"] = qunif(amostra_lhs[,2],min=PrecoMinimo, max=PrecoMaximo)
  dados_simulados[,"Demanda"] = qunif(amostra_lhs[,3],min=DemandaMinima, max=DemandaMaxima)
  
  
  # Atribuindo as Variaveis de Output
  dados_simulados [,"Lucro"] = lucro(dados_simulados[,"CustoFixo"],
                                     dados_simulados[,"CustoVariavel"],
                                     dados_simulados[,"Preco"], 
                                     dados_simulados[,"Producao"], 
                                     dados_simulados[,"Demanda"])
  
  return(dados_simulados)
}