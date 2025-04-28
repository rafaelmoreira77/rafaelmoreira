
# GRÁFICOS EM BARRAS

# Instalar pacotes se necessário
# install.packages("WDI")
# install.packages("ggplot2")
# install.packages("dplyr")

# Carregar bibliotecas
library(WDI)
library(ggplot2)
library(dplyr)

# ----------- Gráfico 1: Consumo de Energia Elétrica per Capita (BARRAS) -----------

# Baixar dados
energia_per_capita <- WDI(country = 'BR', indicator = 'EG.USE.ELEC.KH.PC')

# Limpar dados
energia_per_capita <- energia_per_capita %>% filter(!is.na(EG.USE.ELEC.KH.PC))

# Criar gráfico
grafico_energia <- ggplot(energia_per_capita, aes(x = factor(year), y = EG.USE.ELEC.KH.PC)) +
  geom_col(fill = "darkblue") +
  labs(
    title = "Consumo de Energia Elétrica per Capita no Brasil",
    x = "Ano",
    y = "kWh por Pessoa"
  ) +
  theme_classic(base_size = 14) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

# Exibir gráfico
print(grafico_energia)

# ----------- Gráfico 2: PIB per Capita em 2022 (BARRAS) -----------

# Baixar dados
pib_per_capita <- WDI(country = 'all', indicator = 'NY.GDP.PCAP.CD', start = 2022, end = 2022)

# Limpar dados
pib_per_capita <- pib_per_capita %>% filter(!is.na(NY.GDP.PCAP.CD))

# Selecionar os 20 maiores PIBs
pib_per_capita_top20 <- pib_per_capita %>% arrange(desc(NY.GDP.PCAP.CD)) %>% slice(1:20)

# Criar gráfico
grafico_pib <- ggplot(pib_per_capita_top20, aes(x = reorder(country, NY.GDP.PCAP.CD), y = NY.GDP.PCAP.CD)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Top 20 Países - PIB per Capita (US$) - 2022",
    x = "País",
    y = "PIB per Capita (US$)"
  ) +
  theme_classic(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Exibir gráfico
print(grafico_pib)

# ----------- Gráfico 3: Expectativa de Vida no Brasil (BARRAS) -----------

# Baixar dados
expectativa_vida <- WDI(country = 'BR', indicator = 'SP.DYN.LE00.IN')

# Limpar dados
expectativa_vida <- expectativa_vida %>% filter(!is.na(SP.DYN.LE00.IN))

# Criar gráfico
grafico_vida <- ggplot(expectativa_vida, aes(x = factor(year), y = SP.DYN.LE00.IN)) +
  geom_col(fill = "darkred") +
  labs(
    title = "Expectativa de Vida no Brasil",
    x = "Ano",
    y = "Anos"
  ) +
  theme_classic(base_size = 14) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

# Exibir gráfico
print(grafico_vida)
