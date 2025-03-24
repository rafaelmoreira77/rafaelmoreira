# API (FORMA DE ACESSO)
# DADOS DO BANCO MUNDIAL (WORLD BANK)
# WORLD DEVELOPMENT INDICATORS (BASE DE DADOS)

# NA AULA PASSADA, ACESSAMOS OS DADOS DO PIB
# PRODUTO INTERNO BRUTO

library(WDI) # CARREGAR A BIBLIOTECA/PACOTE

options(scipen = 999) # AJUSTAR A NOT. CIENT.

dadospib <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD')

dadospib2023 <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD',
                start = 2023, end = 2023)

dadospibbr <- WDI(country = 'BR',
                indicator = 'NY.GDP.MKTP.CD')
