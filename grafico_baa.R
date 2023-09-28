grafico_baa <- function(dataframe, coluna) {

  rotulos <- unique(dataframe[, 1])

  grafico_dispersao <- ggplot(dataframe, aes(x = dataframe[, 2], y = dataframe[, 2], color = dataframe[, 1])) +
    geom_point(size = 3) +
    geom_hline(yintercept = dataframe[2, coluna], color = "red", linetype = "dashed", size = 1.2) +
    xlab(NULL) +
    ylab(NULL) +
    ggtitle(NULL) +
    scale_color_brewer(palette = "Set1") +
    guides(color = guide_legend(title = NULL, keywidth = 3, keyheight = 3, label.theme = element_text(size = 14)))+
  theme_set(theme_classic())+
  theme(axis.text = element_text(size = 14), axis.title = element_text(size = 16),plot.title = element_text(hjust = 0.5))

  return(grafico_dispersao)
}
