border_aproximation_area <- function(df_normalizado_peso) {

  media_geometrica <- exp(colMeans(log(df_normalizado_peso)))
  df_daa <- data.frame(MediaGeometrica = media_geometrica)

  return(t(df_daa))
}
