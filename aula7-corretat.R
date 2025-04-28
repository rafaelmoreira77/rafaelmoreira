# AULA 7 - CÓPIA
# MELHORANDO OS GRÁFICOS COM OUTROS DADOS

# GRAFICO_DADOS_EM_PAINEL
# CONSUMO DE ENERGIA ELÉTRICA PER CAPITA

#instalar pacotes se necessário
install.packages("ggplot2")
install.packages("WDI")
install.packages("dplyr")
install.packages("png")
install.packages("magick")

# Carregar bibliotecas
library(WDI)
library(ggplot2)
library(dplyr)
library(png)
library(grid)
library(magick)

# Imagem de fundo
bandeira <- image_read("bandeira_brasil.png")
bandeira_opaca <- image_colorize(bandeira, opacity = 80, color = "white")
image_write(bandeira_opaca, path = "bandeira_brasil_opaca.png", format = "png")
img <- readPNG("bandeira_brasil_opaca.png")
g <- rasterGrob(img, interpolate = TRUE)

# Baixar dados
ENERGIA_PER_CAPITA <- WDI(country = 'all', indicator = 'EG.USE.ELEC.KH.PC')

# Criar gráfico
grafpainel <- ggplot(ENERGIA_PER_CAPITA, aes(x = year, y = EG.USE.ELEC.KH.PC)) +
  annotation_custom(g, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  geom_point(data = subset(ENERGIA_PER_CAPITA, iso2c != "BR"),
             aes(x = year, y = EG.USE.ELEC.KH.PC),
             color = "grey70", size = 1.5, alpha = 0.7) +
  geom_point(data = subset(ENERGIA_PER_CAPITA, iso2c == "BR"),
             aes(x = year, y = EG.USE.ELEC.KH.PC),
             color = "#006400", size = 4, alpha = 1) +
  labs(
    title = "Consumo de Energia Elétrica per capita",
    x = "Ano",
    y = "Consumo (kWh por Pessoa)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    panel.grid.major = element_line(color = "grey85"),
    panel.grid.minor = element_blank()
  )



# GRAFICO_CORTE_TRANSVERSAL
# PIB PER CAPITA EM 2022

library(gganimate)

# Baixar dados
PIB_PER_CAPITA <- WDI(country = 'all', indicator = 'NY.GDP.PCAP.CD', start = 2022, end = 2022)

# Limpar dados
PIB_PER_CAPITA <- PIB_PER_CAPITA %>%
  filter(!is.na(NY.GDP.PCAP.CD)) %>%
  mutate(pais_destacado = ifelse(country == "United States", "Estados Unidos", "Outros"))

# Criar gráfico
grafcorte <- ggplot(PIB_PER_CAPITA, aes(x = year, y = NY.GDP.PCAP.CD)) +
  geom_point(data = filter(PIB_PER_CAPITA, pais_destacado == "Outros"),
             aes(color = pais_destacado), alpha = 0.5, size = 2) +
  geom_point(data = filter(PIB_PER_CAPITA, pais_destacado == "Estados Unidos"),
             color = "blue", size = 5) +
  labs(
    title = "PIB per Capita em 2022",
    subtitle = "Destaque para os Estados Unidos",
    x = "Ano",
    y = "PIB per Capita (US$)"
  ) +
  scale_color_manual(values = c("Outros" = "gray70", "Estados Unidos" = "blue")) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    legend.position = "bottom"
  ) +
  transition_states(pais_destacado,
                    transition_length = 2,
                    state_length = 1) +
  enter_fade() +
  exit_fade()

animate(grafcorte, width = 800, height = 500, fps = 20, duration = 4, renderer = gifski_renderer())
anim_save("pib_per_capita_2022.gif")

# GRAFICO_SERIE_TEMPORAL
# EXPECTATIVA DE VIDA NO BRASIL

# Baixar dados
expectativa_vida <- WDI(country = 'BR', indicator = 'SP.DYN.LE00.IN')

# Limpar dados
expectativa_vida <- expectativa_vida %>%
  filter(!is.na(SP.DYN.LE00.IN))

# Criar gráfico
grafserie <- ggplot(expectativa_vida, aes(x = year, y = SP.DYN.LE00.IN)) +
  geom_line(color = "#FF4500", size = 2) +
  geom_point(aes(color = SP.DYN.LE00.IN), size = 3) +
  scale_color_gradient(low = "#00FFFF", high = "#FF4500") +
  labs(
    title = "🎉 Expectativa de Vida no Brasil",
    subtitle = "Evolução ao longo dos anos",
    x = "Ano",
    y = "Expectativa de Vida (anos)",
    color = "Expectativa"
  ) +
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
  transition_reveal(year)

animate(grafserie, width = 800, height = 500, fps = 20, duration = 5, renderer = gifski_renderer())
anim_save("expectativa_vida_brasil.gif")
