# app.R
library(openxlsx)
library(shiny)
library(readxl)
library(DT)

# Carregar a função mabacR do arquivo mabac.R
source("mabac.R")

ui <- fluidPage(
  titlePanel("Multi-Attributive Border Approximation area Comparison (MABAC)"),

  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Selecione o arquivo:"),






      tags$div(
        h5("Esta é uma implementação do Multi-Attributive Border Approximation area Comparison (MABAC), um método multicritério para tomada de decisão. Recomendamos assistir o vídeo 'Como preencher a planilha mabacr.xlsx?' para um melhor entendimento de como utilizar aplicativo. A planilha padrão para o preenchimento dos dados que serão analisados, você encontra para download abaixo."),
        hr(),
        HTML("Planilha padrão: <a href =
               'https://arslabadack.shinyapps.io/mabacR/mabacr.xlsx'>
               mabacr.xlsx</a>"),
        p(),
        HTML("YouTube Video: <a href =
               'https://youtu.be/KJA4SfVgRPY'>
               Como preencher a planilha mabacr.xlsx?</a>"),
        p(),
        HTML("Repositório no GitHub: <a href =
               ''>
               </a>"),
        p(),
        h5("Todos os direitos reservados. O uso não comercial (acadêmico) dos recursos disponíveis nessa página é gratuito. Solicitamos a gentileza de citar a ferramenta em seus resultados"),
        p(),
        HTML("Contact: <a href =
               'mailto:arslabadack@gmail.com'>arslabadack@gmail.com</a>"),

      )














































    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Dados", dataTableOutput("table")),
        tabPanel("Resultados", verbatimTextOutput("results")),
      )
    )
  )
)

server <- function(input, output, session) {
  observe({
    req(input$file)
    file <- input$file$datapath
    resultado <- mabacR(file)

    output$table <- renderDataTable({
      read.xlsx(file, sheet = 1)
    })

    output$results <- renderPrint({
      resultado
    })
  })
}

shinyApp(ui, server)
