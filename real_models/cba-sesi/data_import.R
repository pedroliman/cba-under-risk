### Solução Temporária: 
### Depois verificar solução complea em> http://stackoverflow.com/questions/25360173/error-installing-r-package


import_data = function (data_file) {
  ## Ajustando variável de ambiente do Java
  Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jdk1.8.0_101\\jre\\')
  
  # Carregando os Dados
  library(xlsx)
  
  params = read.xlsx(data_file, sheetName="Parametros")
  
  dados_projetados = read.xlsx("Dados.xlsx", sheetName="Dados_Projetados")
  
  dados_projetados = na.omit(dados_projetados)
  
  return(dados_projetados)
  
}

