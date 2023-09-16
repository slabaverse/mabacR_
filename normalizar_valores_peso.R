normalizar_valores_peso <- function(matriz_normalizada, peso) {

  df_normalizado_peso <- matriz_normalizada

  for (col in 1:ncol(matriz_normalizada)) {
    for (row in 1:nrow(matriz_normalizada)) {
      valor_atual <- matriz_normalizada[row, col]
      peso_atual <- peso[1, col]
      df_normalizado_peso[row, col] <- peso_atual * (valor_atual + 1)
    }
  }

  return(as.data.frame(df_normalizado_peso))
}
