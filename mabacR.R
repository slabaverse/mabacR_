processar_dados <- function(nome_arquivo) {

  dados <- read_excel(nome_arquivo)

  peso <- data.frame(peso = dados[1, -1])

  tipo <- data.frame(tipo = dados[2, -1])

  itens_avaliados <- data.frame(itens_avaliados = dados[3:nrow(dados), 1])

  valores <- dados[-c(1, 2), -1]

  return(list(peso = peso, tipo = tipo, valores = valores, itens_avaliados = itens_avaliados))

}

calcular_maxmin_diferenca <- function(valores) {
  maximos <- apply(valores, 2, max)
  minimos <- apply(valores, 2, min)

  diferencas <- maximos - minimos
  diferencas_negativas <- -diferencas

  dados_maxmin <- data.frame(
    maximo = maximos,
    minimo = minimos,
    diferenca = diferencas,
    diferenca_negativa = diferencas_negativas
  )

  row.names(dados_maxmin) <- colnames(valores)
  dados_maxmin <- t(dados_maxmin)

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

border_aproximation_area <- function(df_normalizado_peso) {

  media_geometrica <- exp(colMeans(log(df_normalizado_peso)))

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

  if (length(itens_avaliados) != nrow(matriz_q)) {
    stop("Os vetores 'itens_avaliados' e 'matriz_q' devem ter o mesmo número de elementos.")
  }

  soma_linhas <- rowSums(matriz_q)

  ranking <- data.frame(Item = itens_avaliados, Soma = soma_linhas)

  resultado_ranking <- ranking[order(-ranking$Soma), ]

  return(resultado_ranking)
}
