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

  return(as.data.frame(df_valores_normalizado))
}
