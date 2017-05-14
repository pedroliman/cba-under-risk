
### Pedro Nascimento de Lima
### Arquivo com a Função de Análise CBA


### Função CBA ANALYSIS ####
cba_analysis = function(mean_cost, sd_cost, mean_benefit, sd_benefit) {
  

# Criando um Vetor de Anos para os Investimentos
years_vector = seq(from=initial_year, to=initial_year+n-1, by=1)

# Criando o vetor de custos
costs_vector = c()

for(i in 1:n) {
  costs_vector[i]=rnorm(n=1,mean=mean_cost,sd=sd_cost)
}


# Criando o vetor de Benefícios
benefits_vector = c()

for(i in 1:n) {
  benefits_vector[i]=rnorm(n=1,mean=mean_benefit,sd=sd_benefit)
}

# Montando nomes para o Array

col_names = c("Ano", "Custos", "Beneficios","VPL")
row_names = years_vector
matrix_names = c("Matriz CBA")
# Montando o Array de Custos e Benefícios

cba_array = array(data=c(years_vector,costs_vector,benefits_vector),dim=c(n,4))
# rownames(cba_array) = row_names
colnames(cba_array) = col_names


# Calculando o VPL
cba_array[,4]=cba_array[,3]-cba_array[,2]


# Somando Custos e Benefícios a Valor Presente
costs = sum(cba_array[,2])
benefits = sum(cba_array[,3])
vpl = benefits - costs

# Calculando as Estatísticas
vpl = benefits - costs
cbr = cbr(costs = costs,benefits = benefits)
roi = roi(costs = costs,benefits = benefits)

# Vetor de Resultados
cba_results_vector = c(vpl,cbr,roi)

cba_results_array = array(data=c(cba_results_vector),dim=c(1,3))
# rownames(cba_array) = row_names
colnames(cba_results_array) = c("VPL", "CBR", "ROI")


# Aqui estou apenas retornando o custo benefício
return(cba_results_vector)
}

