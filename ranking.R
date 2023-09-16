ranking <- function(itens_avaliados, matriz_q) {

  if (nrow(itens_avaliados) != nrow(matriz_q)) {
    stop("Os dataframes 'itens_avaliados' e 'matriz_q' devem ter o mesmo número de linhas.")
  }

  soma_linhas <- rowSums(matriz_q)

  ranking <- data.frame(Item = itens_avaliados$Critérios, Soma = soma_linhas)

  ranking <- ranking[order(-ranking$Soma), ]

  return(data.frame(ranking))
}
