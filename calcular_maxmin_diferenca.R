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

  return(as.data.frame(dados_maxmin))
}
