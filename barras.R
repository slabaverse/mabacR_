barras <- function(resultado) {
  resultado <- resultado[order(resultado$Soma, decreasing = TRUE), ]
  grafico <- ggplot(resultado, aes(x = reorder(Item, -Soma), y = Soma)) +
    geom_bar(stat = "identity", fill = "#E56A5DFF", color = "black") +
    labs(x = NULL, y = NULL, title = "Resultados") +
    theme_minimal() +
    theme(legend.position = "none", axis.text = element_text(size = 14), axis.title = element_text(size = 16), plot.title = element_text(hjust = 0.5))
  return(grafico)
}
