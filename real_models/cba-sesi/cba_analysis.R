
# Análise de Custo Benefício

library(fitdistrplus)


# Carregando arquivos com Funções
source("financial_functions.R")
source("cba.R")
source("data_import.R")

### TODO: Importar aqui
dados = import_data("Dados.xlsx")
dados

## Primeiro teste para rodar uma análise de custo benefício probabilística

### Parâmetros para Rodar a Análise 

#Número de Períodos a Analisar e Ano Inicial
n = 10
initial_year = 2017

### Rodando a Análise CBA 200 vezes
cba_replications = replicate(n=100,
                             cba_analysis(mean_cost=30,
                                          sd_cost=5, 
                                          mean_benefit=30, 
                                          sd_benefit=10)
                             )


# Separando os resultados em vetores diferentes
# vendo o VPL
vpl = cba_replications[1,]

# retornando o CBR
cbr = cba_replications[2,]

# retornando o ROI
roi = cba_replications[3,]


# Ajustando o Gráfico para 3 imagens:
par(mfrow=c(1,3))
# Vendo a Distribuição do VPL
hist(vpl,main="Distribuição do VPL")

# Vendo a Distribuição do CBR
hist(cbr,main="Distribuição do CBR")

# Vendo a Distribuição do ROI
hist(roi,main="Distribuição do ROI")


# Ajustando o CBA para uma distribuição normal
cbr_fit = fitdist(cbr,"norm")
roi_fit = fitdist(roi,"norm")
vpl_fit = fitdist(vpl,"norm")

# Estimando o CBR

cbr_medio = as.numeric(cbr_fit$estimate[["mean"]])
cbr_medio = round(cbr_medio, digits=2)

cat("Para cada 1 real investido em SST, retornam em média ", cbr_medio, " Reais.")


# Estimando o ROI
roi_medio = as.numeric(roi_fit$estimate[["mean"]])*100
roi_medio = round(roi_medio,digits = 2)

cat("O retorno sobre investimento esperado é de ", roi_medio, " %.")

# Informando o VPL
vpl_medio = as.numeric(vpl_fit$estimate[["mean"]])
vpl_medio = round(vpl_medio,digits = 2)

cat("O Valor Presente Líquido do Investimento esperado é ", vpl_medio, " Reais.")

# # Mostrando o Intervalo de Confiança do CBR..
# confint(cba_fit)
# 
# # Ajustando o gráfico...
# par(mfrow=c(2,2))
# # Mostrando os resultados do Ajuste à distribuição Normal
# plot(cba_fit)