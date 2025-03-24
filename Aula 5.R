# API (FORMA DE ACESSO)
# DADOS DO BANCO MUNDIAL (WORLD BANK)
# WORLD DEVELOPMENT INDICATORS (BASE DE DADOS)

# NA AULA PASSADA, ACESSAMOS OS DADOS DO PIB
# PRODUTO INTERNO BRUTO

library(WDI) # CARREGAR A BIBLIOTECA/PACOTE

options(scipen = 999) # AJUSTAR A NOT. CIENT.

# DADOS EM PAINEL
dadospib <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD')
# CORTE TRANSVERSAL
dadospib2023 <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD',
                start = 2023, end = 2023)
# SÉRIE TEMPORAL
dadospibbr <- WDI(country = 'BR',
                indicator = 'NY.GDP.MKTP.CD')
# DADOS EM PAINEL
netmigration <- WDI(country = 'all',
                    indicator = 'SM.POP.NETM')
# DADOS EM PAINEL
expecdevidamundi <- WDI(country = 'all',
                   indicator = 'SP.DYN.LE00.IN')
# SÉRIE TEMPORAL
expecdevidabr <- WDI(country = 'BR',
                   indicator = 'SP.DYN.LE00.IN')