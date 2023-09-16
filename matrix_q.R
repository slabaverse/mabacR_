matrix_q <- function(baa, matriz_normalizada_peso){

  df_dist_alternativas_baa <- matriz_normalizada_peso

  for (col in 1:ncol(matriz_normalizada_peso)) {
    for (row in 1:nrow(matriz_normalizada_peso)) {
      valor_atual <- matriz_normalizada_peso[row, col]
      baa_atual <- baa[1, col]
      df_dist_alternativas_baa[row, col] <- valor_atual - baa_atual
    }
  }

  return(as.data.frame(df_dist_alternativas_baa))
}
