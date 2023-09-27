grafico_baa <- function(dataframe, coluna) {
  # Criar um dataframe de rótulos com base na coluna 1
  rotulos <- unique(dataframe[, 1])

  # Use aes() para mapear cores e rótulos das legendas com base na coluna 1
  grafico_dispersao <- ggplot(dataframe, aes(x = dataframe[, 2], y = dataframe[, 2], color = dataframe[, 1])) +
    geom_point(size = 3) +  # Tamanho dos pontos aumentado para 3
    geom_hline(yintercept = dataframe[2, coluna], color = "red", linetype = "dashed", size = 1.2) +  # Linha central aumentada para size 1.2
    xlab(NULL) +
    ylab(NULL) +
    ggtitle("Gráfico de Dispersão") +
    #scale_color_manual(values = rainbow(length(rotulos)), breaks = rotulos, labels = rotulos) +
    scale_color_brewer(palette = "Set1") +
    guides(color = guide_legend(title = NULL, keywidth = 3, keyheight = 3, label.theme = element_text(size = 14)))+  # Tamanho da legenda aumentado para size 14 e tamanho da chave (key) aumentado para 2

  # Configurar o fundo branco
  theme_set(theme_classic())+
  theme(axis.text = element_text(size = 14), axis.title = element_text(size = 16),plot.title = element_text(hjust = 0.5))

  return(grafico_dispersao)
}
