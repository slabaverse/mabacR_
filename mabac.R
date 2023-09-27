mabacR <- function(mabac_df) {

  source("calcular_maxmin_diferenca.R")
  source("normalizar_valores.R")
  source("normalizar_valores_peso.R")
  source("border_aproximation_area.R")
  source("matrix_q.R")
  source("ranking.R")


  if (missing(mabac_df)) {
    return("ERRO: Parâmetro 'mabac_df' ausente")
  }

  dados <- read_excel(mabac_df)

  if (is.null(dados) || nrow(dados) < 4 || ncol(dados) < 2) {
    return("ERRO: Formato de dados inválido. Certifique-se de que há pelo menos 4 linhas e 2 colunas no arquivo Excel.")
  }

  peso <- data.frame(peso = dados[1, -1])

  if (sum(peso) != 1) {
    return("ERRO: A soma dos pesos deve ser igual a 1")
  }

  tipo <- data.frame(tipo = dados[2, -1])

  itens_avaliados <- data.frame(itens_avaliados = dados[3:nrow(dados), 1])

  valores <- dados[-c(1, 2), -1]

  dados_maxmin <- calcular_maxmin_diferenca(valores)

  if (is.null(dados_maxmin)) {
    return("ERRO: Falha ao calcular os valores máximos e mínimos")
  }

  matriz_normalizada <- normalizar_valores(valores, tipo, dados_maxmin)

  if (is.null(matriz_normalizada)) {
    return("ERRO: Falha ao normalizar os valores")
  }

  matriz_normalizada_peso <- normalizar_valores_peso(matriz_normalizada, peso)

  if (is.null(matriz_normalizada_peso)) {
    return("ERRO: Falha ao normalizar os valores com peso")
  }

  baa <- border_aproximation_area(matriz_normalizada_peso)

  if (is.null(baa)) {
    return("ERRO: Falha ao calcular a área de aproximação da fronteira")
  }

  matriz_q <- matrix_q(baa, matriz_normalizada_peso)

  if (is.null(matriz_q)) {
    return("ERRO: Falha ao calcular a matriz Q")
  }

  ranking <- ranking(itens_avaliados, matriz_q)

  if (is.null(ranking)) {
    return("ERRO: Falha ao calcular o ranking")
  }

  return(list(ranking = ranking, baa = baa, matriz_q = matriz_q))
}
