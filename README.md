# Implementação do Método Multicritério MABAC em R

Este repositório contém a implementação do método multicritério **MABAC (Multi-Attributive Border Approximation Area Comparison)** usando a linguagem de programação R. A aplicação foi desenvolvida com o intuito de facilitar a tomada de decisão multicritério através de um aplicativo web acessível e intuitivo.

## Descrição do Projeto

A tomada de decisão multicritério é uma ciência que utiliza modelos matemáticos complexos para avaliar e selecionar a melhor alternativa entre várias opções, minimizando vieses. Este projeto visa disponibilizar uma ferramenta web que implementa o método MABAC, permitindo que os usuários realizem os cálculos automaticamente a partir de uma planilha predefinida.

A ferramenta foi desenvolvida utilizando a linguagem de programação **R**, em conjunto com a biblioteca **Shiny**, para criar uma interface gráfica interativa. O aplicativo foi hospedado no **shinyapps.io** e está disponível para acesso público.

## Funcionalidades

- Upload de planilhas em formato `.xlsx` para análise.
- Execução automática dos cálculos do método MABAC.
- Visualização dos resultados na forma de tabelas e gráficos.
- Interface intuitiva para análise detalhada de critérios e alternativas.
- Disponibilização de uma planilha padrão para os usuários iniciarem suas análises.

## Tecnologias Utilizadas

- **R (versão 4.2.3)**: Linguagem de programação utilizada para análise de dados e implementação do método.
- **RStudio (versão 2023.06.1)**: IDE utilizada para o desenvolvimento do código em R.
- **Shiny (versão 1.7.5)**: Biblioteca usada para criação da interface web.
- **shinyapps.io**: Plataforma utilizada para hospedagem do aplicativo.
- **Git e GitHub**: Ferramentas de controle de versão e armazenamento do código.

## Como Executar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/mabac-r.git
   cd mabac-r
   ```

2. Certifique-se de ter o R e o RStudio instalados.

3. Abra o projeto no RStudio.

4. Instale as dependências necessárias:

   ```R
   install.packages(c("shiny", "readxl", "ggplot2"))
   ```

5. Execute a aplicação:

   ```R
   shiny::runApp()
   ```

## Como Utilizar o Aplicativo

1. Faça o download da planilha padrão disponibilizada no aplicativo.
2. Preencha a planilha com os critérios e alternativas que deseja avaliar.
3. Realize o upload da planilha no aplicativo.
4. Visualize os resultados gerados automaticamente na aba **Resultados**.
5. Utilize a aba **Gráficos** para visualizar a análise gráfica das alternativas em relação aos critérios.

## Resultados

A ferramenta foi validada utilizando dados de trabalhos acadêmicos e apresentou os mesmos resultados dos estudos originais, demonstrando sua precisão e robustez.

Acesse a versão web do aplicativo [aqui](https://arslabadack.shinyapps.io/mabacR).

## Referências

Este projeto foi desenvolvido como parte do **Trabalho de Conclusão de Curso** para a obtenção do título de especialista em Data Science e Analytics - 2023.

Autores:
- **Adam Roger Slabadack**: [arslabadack@gmail.com](mailto:arslabadack@gmail.com)
- **Marcos dos Santos**: Doutor em Pesquisa Operacional, Instituto Militar de Engenharia

---
