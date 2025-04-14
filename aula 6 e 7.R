# AULA 7
# MELHORANDO OS GRÁFICOS


# GRAFICO_DADOS_EM_PAINEL
#PASSAGEIROS_TRANSPORTADOS

#install.packages("ggplot2")
#install.packages("WDI")
#install.packages("dplyr")

#CARREGAR BIBLOTECAS
library(WDI)
library(ggplot2)
library(dplyr)

install.packages("png")
# Instale se não tiver
install.packages("magick")

# Carregue o pacote
library(magick)

# Leia a imagem
bandeira <- image_read("bandeira_brasil.png")

# Ajuste a opacidade (alpha) - por exemplo, 0.2 para 20% visível
bandeira_opaca <- image_colorize(bandeira, opacity = 80, color = "white")

# Salve a nova imagem com opacidade ajustada
image_write(bandeira_opaca, path = "bandeira_brasil_opaca.png", format = "png")

# Pacotes necessários
library(ggplot2)
library(WDI)
library(png)
library(grid)
library(magick)

# Passo 1: Leia e edite a imagem para aplicar opacidade apenas na imagem
bandeira <- image_read("bandeira_brasil.png")
bandeira_opaca <- image_colorize(bandeira, opacity = 80, color = "white")
image_write(bandeira_opaca, path = "bandeira_brasil_opaca.png", format = "png")

# Passo 2: Leia a imagem já com opacidade
img <- readPNG("bandeira_brasil_opaca.png")
g <- rasterGrob(img, interpolate = TRUE)

# Passo 3: Baixe os dados
PASSENGERS_CARRIED <- WDI(country = 'all', indicator = 'IS.AIR.PSGR')

# Passo 4: Crie o gráfico moderno e destacado
grafpainel <- ggplot(PASSENGERS_CARRIED, aes(x = year, y = IS.AIR.PSGR)) +
  
  # Imagem de fundo com opacidade
  annotation_custom(g, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  
  # Primeiro, plota os outros países (base cinza)
  geom_point(data = subset(PASSENGERS_CARRIED, iso2c != "BR"),
             aes(x = year, y = IS.AIR.PSGR),
             color = "grey70",
             size = 1.5,
             alpha = 0.7) +
  
  # Depois, por cima de tudo, plota os dados do Brasil em verde escuro
  geom_point(data = subset(PASSENGERS_CARRIED, iso2c == "BR"),
             aes(x = year, y = IS.AIR.PSGR),
             color = "#006400",  # Verde escuro
             size = 4,
             alpha = 1) +  # Totalmente visível
  
  # Títulos e eixos
  labs(
    title = "Passageiros Transportados por Via Aérea",
    x = "Ano",
    y = "Passageiros Transportados por Via Aérea"
  ) +
  
  # Tema moderno
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    panel.grid.major = element_line(color = "grey85"),
    panel.grid.minor = element_blank()
  )

# Exibe o gráfico
print(grafpainel)


#GRAFICO_CORTE_TRANSVERSAL
#FORÇAS_ARMADAS_EUA

install.packages("gganimate")
# Carregar bibliotecas
library(WDI)
library(ggplot2)
library(dplyr)
library(gganimate)

# Baixar os dados das forças armadas para 2020
FORÇAS_ARMADAS <- WDI(country = 'all',
                      indicator = 'MS.MIL.TOTL.P1',
                      start = 2020, end = 2020)

# Limpar os dados (remover NAs)
FORÇAS_ARMADAS <- FORÇAS_ARMADAS %>%
  filter(!is.na(MS.MIL.TOTL.P1))

# Criar um grupo para destacar os EUA
FORÇAS_ARMADAS <- FORÇAS_ARMADAS %>%
  mutate(pais_destacado = ifelse(country == "United States", "Estados Unidos", "Outros"))

# Gráfico moderno e animado
grafcorte <- ggplot(FORÇAS_ARMADAS, aes(x = year, y = MS.MIL.TOTL.P1)) +
  
  # Primeiro, plota todos os outros países (fundo)
  geom_point(data = filter(FORÇAS_ARMADAS, pais_destacado == "Outros"),
             aes(color = pais_destacado),
             alpha = 0.5,
             size = 2) +
  
  # Depois, plota os EUA por cima, sobreposto
  geom_point(data = filter(FORÇAS_ARMADAS, pais_destacado == "Estados Unidos"),
             color = "blue",
             size = 5) +
  
  # Títulos e labels dos eixos
  labs(
    title = "Efetivo das Forças Armadas em 2020",
    subtitle = "Destaque para os Estados Unidos",
    x = "Ano",
    y = "Forças Armadas (Total de Pessoal)"
  ) +
  
  # Cores modernas para os grupos
  scale_color_manual(values = c("Outros" = "gray70", "Estados Unidos" = "blue")) +
  
  # Estilo clean
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    legend.position = "bottom"
  ) +
  
  # Animação de entrada dos pontos
  transition_states(pais_destacado,
                    transition_length = 2,
                    state_length = 1) +
  enter_fade() +
  exit_fade()

# Rodar a animação
animate(grafcorte, width = 800, height = 500, fps = 20, duration = 4, renderer = gifski_renderer())

# Salvar se quiser
anim_save("forcas_armadas_eua.gif")


#GRAFICO_SERIE_TEMPORAL
#PRODUÇÃO-DE-CEREAL_CHINA


# Carregar bibliotecas
library(WDI)
library(ggplot2)
library(gganimate)
library(dplyr)

# Baixar dados da produção de cereal da China
producao_cereal <- WDI(country = 'CHN',
                       indicator = 'AG.PRD.CREL.MT')

# Limpar os dados (remover NAs)
producao_cereal <- producao_cereal %>%
  filter(!is.na(AG.PRD.CREL.MT))

# Gráfico mais colorido e moderno
grafserie <- ggplot(producao_cereal, aes(x = year, y = AG.PRD.CREL.MT)) +
  
  # Linha da China em vermelho vibrante
  geom_line(color = "#FF4500", size = 2) +
  
  # Pontos em gradiente para destacar valores
  geom_point(aes(color = AG.PRD.CREL.MT), size = 3) +
  
  # Escala de cor vibrante (azul para vermelho intenso)
  scale_color_gradient(low = "#00FFFF", high = "#FF4500") +
  
  # Títulos e eixos personalizados
  labs(
    title = "🚀 Produção de Cereal na China (Série Temporal)",
    subtitle = "Evolução ao longo dos anos com destaque moderno",
    x = "Ano",
    y = "Produção de Cereal (Toneladas)",
    color = "Produção"
  ) +
  
  # Tema moderno com fundo escuro
  theme_minimal(base_size = 14) +
  theme(
    plot.background = element_rect(fill = "#121212", color = NA),
    panel.background = element_rect(fill = "#121212", color = NA),
    panel.grid.major = element_line(color = "#444444"),
    panel.grid.minor = element_line(color = "#444444"),
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5, color = "white"),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "white"),
    axis.title = element_text(color = "white"),
    axis.text = element_text(color = "white"),
    legend.title = element_text(color = "white"),
    legend.text = element_text(color = "white")
  ) +
  
  # Animação fluida revelando a linha
  transition_reveal(year)

# Rodar a animação
animate(grafserie, width = 800, height = 500, fps = 20, duration = 5, renderer = gifski_renderer())

# Salvar se quiser
anim_save("producao_cereal_china_moderno.gif")






