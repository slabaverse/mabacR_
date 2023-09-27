# app.R
library(openxlsx)
library(shiny)
library(readxl)
library(DT)
library(ggplot2)
library(bslib)
library(viridis)

# Carregar a função mabacR do arquivo mabac.R
source("mabac.R")
source("barras_analise.R")
source("grafico_baa.R")

ui <- fluidPage(
  theme = bs_theme(version = version_default(), bootswatch = "lumen"),
  titlePanel("mabacR"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Selecione o arquivo:"),
      tags$div(
        hr(),
        h6("Esta é uma implementação do Multi-Attributive Border Approximation Area Comparison (MABAC), um método multicritério para tomada de decisão. Recomendamos fazer o download do manual de uso do aplicativo (manual.pdf) e assistir ao vídeo 'Como preencher a planilha mabacr.xlsx?' para uma melhor compreensão de como usar o aplicativo. A planilha padrão para o preenchimento dos dados que serão analisados está disponível para download abaixo."),
        hr(),
        HTML("Manual de uso: <a href =
               'https://arslabadack.shinyapps.io/mabacR/manual.pdf'>
               manual.pdf</a>"),
        p(),
        HTML("Planilha padrão: <a href =
               'https://arslabadack.shinyapps.io/mabacR/mabacr.xlsx'>
               mabacr.xlsx</a>"),
        p(),
        HTML("YouTube Video: <a href =
               'https://youtu.be/KJA4SfVgRPY'>
               Como preencher a planilha mabacr.xlsx?</a>"),
        p(),
        HTML("Repositório no GitHub: <a href =
               'https://github.com/arslabadack/mabacR.git'>
               GitHub</a>"),
        p(),
        #upar o tcc aqui
        HTML("Implementação do Método Multicritério MABAC na Linguagem R: Uma Ferramenta para Tomada de Decisão <a href =
               'Manual waspasWEB PT.pdf'>
               tcc.pdf</a>"),
        p(),
        hr(),
        h6("Ficamos imensamente felizes por você ter escolhido nosso aplicativo para auxiliar em sua tomada de decisão. Sinta-se à vontade para utilizá-lo e, se desejar conhecer mais a fundo, o código-fonte está disponível no item 'Repositório no GitHub: GitHub'. Ficaríamos gratos se você nos mencionasse em seus resultados. Caso queira conferir o trabalho resultante deste aplicativo, ele está disponível no item 'Implementação do Método Multicritério MABAC na Linguagem R: Uma Ferramenta para Tomada de Decisão'."),
        p(),
        HTML("Fonte para citação: <em>SLABADACK, Adam; SANTOS, Marcos dos. Aplicativo MABAC em R (v.1), 2023.</em>"),
        p(),
        HTML("Contato: <a href =
               'mailto:arslabadack@gmail.com'>arslabadack@gmail.com</a>"),
      )
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Dados",
                 h4("Dados da Planilha Padrão"),
                 dataTableOutput("table")),
        tabPanel("Resultados",
                 fluidRow(
                   column(6,
                          h4("Escolha Ótima"),
                          verbatimTextOutput("results")
                   ),
                   column(6,
                          h4("Valores da Área de Aproximação de Fronteira (BAA)"),
                          verbatimTextOutput("baa")
                   )
                 ),
                 h4("Comportamento dos Resultados em Relação a Área de Aproximação de Fronteira (BAA)"),
                 selectInput("filtro", "Escolha um critério:", choices = NULL),

                 plotOutput("scatterplot")
        ),
        tabPanel("Gráficos",
                 selectInput("coluna", "Escolha a Coluna:", choices = NULL),
                 plotOutput("plot")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  observe({
    req(input$file)
    file <- input$file$datapath
    resultado <- mabacR(file)
    baa_df <- resultado$baa
    ranking_df <- resultado$ranking
    lista_dataframes <- list(ranking_df = ranking_df, baa_df = baa_df)
    analise_df <- do.call(cbind, lista_dataframes)
    colnames(analise_df)[3:ncol(analise_df)] <- colnames(baa_df)

    file <- read.xlsx(file, sheet = 1)
    available_columns <- names(file[-c(1, 2), -1])

    updateSelectInput(session, "coluna", choices = available_columns)

    updateSelectInput(session, "filtro", choices = names(analise_df)[3:ncol(analise_df)])

    output$table <- renderDataTable({
      file
    })

   output$results <- renderPrint({
      resultado$ranking
    })

   output$baa <- renderPrint({
     t(baa_df)
   })

    output$scatterplot <- renderPlot({
      coluna_selecionada <- input$filtro
      grafico_baa(analise_df, coluna_selecionada)
    })

    output$plot <- renderPlot({
      selected_column <- input$coluna
      barras_analise(file, selected_column)
    })
  })
}

shinyApp(ui, server)

