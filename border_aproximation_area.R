border_aproximation_area <- function(df_normalizado_peso) {
  # Calcular a média geométrica das colunas
  media_geometrica <- exp(colMeans(log(df_normalizado_peso)))

  # Criar um novo dataframe com os resultados
  df_daa <- data.frame(MediaGeometrica = media_geometrica)

  return(t(df_daa))
}
