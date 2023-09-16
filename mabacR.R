library(readxl)

processar_dados <- function(nome_arquivo) {
  # Lê o arquivo xlsx
  dados <- read_excel(nome_arquivo)

  # Cria o dataframe "peso" usando a primeira linha
  peso <- data.frame(peso = dados[1, -1])

  # Cria o dataframe "tipo" usando a segunda linha
  tipo <- data.frame(tipo = dados[2, -1])

  # Extrair a primeira coluna a partir da quarta linha
  itens_avaliados <- data.frame(itens_avaliados = dados[3:nrow(dados), 1])

  # Cria o dataframe "valores" excluindo as duas primeiras linhas e a primeira coluna
  valores <- dados[-c(1, 2), -1]

  # Retorna os dataframes resultantes
  return(list(peso = peso, tipo = tipo, valores = valores, itens_avaliados = itens_avaliados))
  #return(peso, tipo, valores, itens_avaliados)
}

calcular_maxmin_diferenca <- function(valores) {
  maximos <- apply(valores, 2, max)  # Calcula os máximos das colunas
  minimos <- apply(valores, 2, min)  # Calcula os mínimos das colunas

  diferencas <- maximos - minimos  # Calcula as diferenças entre máximos e mínimos
  diferencas_negativas <- -diferencas  # Multiplica as diferenças por -1

  dados_maxmin <- data.frame(
    maximo = maximos,
    minimo = minimos,
    diferenca = diferencas,
    diferenca_negativa = diferencas_negativas
  )

  row.names(dados_maxmin) <- colnames(valores)  # Define os nomes das linhas
  dados_maxmin <- t(dados_maxmin)  # Transpõe o dataframe

  return(dados_maxmin)
}

normalizar_valores <- function(valores, tipo, dados_maxmin) {
  df_valores_normalizado <- valores

  for (col in 1:ncol(valores)) {
    for (row in 1:nrow(valores)) {
      if (tipo[1, col] == 1) {
        valor_atual <- valores[row, col]
        valor_min <- dados_maxmin[2, col]
        diferenca <- dados_maxmin[3, col]

        df_valores_normalizado[row, col] <- (valor_atual - valor_min) / diferenca
      } else if (tipo[1, col] == -1) {
        valor_atual <- valores[row, col]
        valor_max <- dados_maxmin[1, col]
        diferenca_negativa <- dados_maxmin[4, col]

        df_valores_normalizado[row, col] <- (valor_atual - valor_max) / diferenca_negativa
      }
    }
  }

  return(df_valores_normalizado)
}

normalizar_valores_peso <- function(matriz_normalizada, peso) {
  df_normalizado_peso <- matriz_normalizada

  for (col in 1:ncol(matriz_normalizada)) {
    for (row in 1:nrow(matriz_normalizada)) {
      valor_atual <- matriz_normalizada[row, col]
      peso_atual <- peso[1, col]
      df_normalizado_peso[row, col] <- peso_atual * (valor_atual + 1)
    }
  }

  return(df_normalizado_peso)
}

# Função para calcular a média geométrica e salvar em um novo dataframe
border_aproximation_area <- function(df_normalizado_peso) {
  # Calcular a média geométrica das colunas
  media_geometrica <- exp(colMeans(log(df_normalizado_peso)))

  # Criar um novo dataframe com os resultados
  df_daa <- data.frame(MediaGeometrica = media_geometrica)

  return(t(df_daa))
}

matrix_q <- function(baa, matriz_normalizada_peso){
  df_dist_alternativas_baa <- matriz_normalizada_peso

  for (col in 1:ncol(matriz_normalizada_peso)) {
    for (row in 1:nrow(matriz_normalizada_peso)) {
      valor_atual <- matriz_normalizada_peso[row, col]
      baa_atual <- baa[1, col]
      df_dist_alternativas_baa[row, col] <- valor_atual - baa_atual
    }
  }

  return(df_dist_alternativas_baa)
}

ranking <- function(itens_avaliados, matriz_q) {
  # Verificar se os dataframes têm o mesmo número de linhas
  if (nrow(itens_avaliados) != nrow(matriz_q)) {
    stop("Os dataframes 'itens_avaliados' e 'matriz_q' devem ter o mesmo número de linhas.")
  }

  # Calcular a soma de cada linha da matriz_q
  soma_linhas <- rowSums(matriz_q)

  # Criar o dataframe de ranking
  ranking <- data.frame(Item = itens_avaliados$Critérios, Soma = soma_linhas)

  ranking <- ranking[order(-ranking$Soma), ]

  return(ranking)
}


arquivo <- "mabacr.xlsx"

  resultado <- processar_dados(arquivo)

  # Acessando os dataframes resultantes
  #peso <- resultado$peso
  #tipo <- resultado$tipo
  #valores <- resultado$valores
  #itens_avaliados <- resultado$itens_avaliados

  dados_maxmin <- calcular_maxmin_diferenca(resultado$valores)

  matriz_normalizada <- normalizar_valores(resultado$valores, resultado$tipo, dados_maxmin)

  matriz_normalizada_peso <- normalizar_valores_peso(matriz_normalizada, resultado$peso)

  baa <- border_aproximation_area(matriz_normalizada_peso)

  matriz_q <- matrix_q(baa, matriz_normalizada_peso)

  ranking <- ranking(resultado$itens_avaliados, matriz_q)

  matriz_normalizada <- as.data.frame(matriz_normalizada)

  matriz_normalizada_peso <- as.data.frame(matriz_normalizada_peso)

  baa <- as.data.frame(baa)

  matriz_q <- as.data.frame(matriz_q)

  ranking <- as.data.frame(ranking)

