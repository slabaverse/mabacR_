barras_analise <- function(data, selected_column) {
  # Remove as linhas "Pesos" e "Tipo" do conjunto de dados
  data_filtered <- data[-c(1, 2), ]

  # Cria o gráfico
  grafico <- ggplot(data_filtered, aes_string(x = "Critérios", y = selected_column)) +
    geom_bar(stat = "identity", fill = "#E56A5DFF", color = "black") +
    labs(x = NULL, y = NULL,title = NULL) +
    theme_classic() +  # Estilo minimalista
    theme(legend.position = "none", axis.text = element_text(size = 14), axis.title = element_text(size = 16),plot.title = element_text(hjust = 0.5))

  return((grafico))
}
