# app.R
library(openxlsx)
library(shiny)
library(readxl)
library(DT)
library(ggplot2)


# Carregar a função mabacR do arquivo mabac.R
source("mabac.R")
source("barras.R")
source("barras_analise.R")

ui <- fluidPage(
  titlePanel("Multi-Attributive Border Approximation area Comparison (MABAC)"),

  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Selecione o arquivo:"),
      tags$div(
        hr(),
        h5("Esta é uma implementação do Multi-Attributive Border Approximation area Comparison (MABAC), um método multicritério para tomada de decisão. Recomendamos assistir o vídeo 'Como preencher a planilha mabacr.xlsx?' para um melhor entendimento de como utilizar aplicativo. A planilha padrão para o preenchimento dos dados que serão analisados, você encontra para download abaixo."),
        hr(),
        #incluir o manual de uso aqui
        HTML("Guia de uso: <a href =
               'Manual waspasWEB PT.pdf'>
               Portuguese</a>"),
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
        h5("Todos os direitos reservados. O uso não comercial (acadêmico) dos recursos disponíveis nessa página é gratuito. Solicitamos a gentileza de citar a ferramenta em seus resultados"),
        p(),
        HTML("Contato: <a href =
               'mailto:arslabadack@gmail.com'>arslabadack@gmail.com</a>"),
      )
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Dados", dataTableOutput("table")),
        tabPanel("Resultados", verbatimTextOutput("results"),
                 plotOutput("barPlot"),
                 ),
        tabPanel("Gráficos",
                 selectInput("coluna", "Escolha a Coluna:", choices = NULL),
                 plotOutput("plot"),

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
    grafico_de_barras <- barras(resultado)

    file <- read.xlsx(file, sheet = 1)
    available_columns <- names(file[-c(1, 2), -1])

    updateSelectInput(session, "coluna", choices = available_columns)

    output$table <- renderDataTable({
      file
    })

    output$results <- renderPrint({
      resultado
    })

    output$barPlot <- renderPlot({
      grafico_de_barras
    })

    output$plot <- renderPlot({
      selected_column <- input$coluna
      barras_analise(file, selected_column)
    })
  })
}

shinyApp(ui, server)

