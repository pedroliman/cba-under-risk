library(shiny)
source("risk-analysis.R", local = TRUE)

# O que Roda aqui roda uma vez para sempre na sessao
CustoVariavelMinimo <- 20
CustoVariavelMaximo <- 30
PrecoMinimo <- 30
PrecoMaximo <- 40
DemandaMinima <- 200
DemandaMaxima <- 400

# Parametros que nao se deve alterar:
iteracoes <- 2000
variaveisAleatorias <- 3
VariaveisNoEnsemble <- 6


texto_de_ajuda = ("Voce deve decidir quanto produzir em um determinado ano, e qual sera o custo fixo. O Custo Variavel varia uniformemente entre 20 e 30 reais, o Preco entre 30 e 40 reais, e a Demanda entre 200 e 400 Unidades. Mude os parametros abaixo, e observe o quanto voce podera lucrar.")

ui <- fluidPage(
  # Titulo
  # titlePanel("Simulador Probabilistico - v0"),
  navbarPage("Calculadora",
             tabPanel("Calcuadora e Histograma",
                      sidebarLayout(
                        sidebarPanel(
                          helpText(texto_de_ajuda),
                          sliderInput(inputId = "producao", 
                                      label = "Escolha o Quanto Produzir", 
                                      value = carregar_input(), min = 0, max = 500),
                          sliderInput(inputId = "custoFixo", 
                                      label = "Escolha seu Nivel de custo fixo", 
                                      value = 1000, min = 600, max = 1400),
                          actionButton("usar_parametro_do_arquivo", "Usar Parametro!")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          plotOutput("hist"),
                          "Leia abaixo um resumo das variaveis simuladas",
                          verbatimTextOutput("resumo")
                          
                        )
                      )
             ),
             tabPanel("Dados",
                      "Abaixo voce vera uma tabela de cada uam das 10.000 simulacoes Realizadas.",
                      dataTableOutput("tabela_simulada")
             )
  )
)

server <- function(input, output) {
  

  
  
  
  
# O que roda aqui roda uma vez por ario final.
# deveria colocar aqui o codigo que deve ser para cada usuario

  carregar_input = observeEvent(output$usar_parametro_do_arquivo,
                                  {
                                    # Carregar arquivo de dados
                                    return(300)
                                  })
  
  # Uma funcao reativa para os dados
  dados_simulados = reactive(
  {
    dados = simular(input$custoFixo, 
                    CustoVariavel, 
                    Preco, 
                    input$producao, 
                    Demanda, 
                    iteracoes, 
                    variaveisAleatorias, 
                    VariaveisNoEnsemble)
    dados = round(dados,2)
    return(dados)
  })
  
  output$hist <- renderPlot({
    qplot(dados_simulados()[,"Lucro"],geom = "histogram",
          main="Histograma dos Resultados Simulados")
  })
  
  output$resumo = renderPrint({summary(dados_simulados())})
  
  output$tabela_simulada = renderDataTable({dados_simulados()})
  
}

shinyApp(ui = ui, server = server)