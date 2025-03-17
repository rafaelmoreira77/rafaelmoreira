# WDI - world development indicators
# base de dados do banco mundial

#install.packages("WDI")
  library(WDI)
# sempre procurem as vignettes
# páginas com as orientações dos pacotes
  
# baixar os dados do pib (produto interno bruto)
# tudo que é produzido em um país/estado/mun.
# em um determinado período
  
# 	GDP (current US$)(NY.GDP.MKTP.CD)
# gross domestic product (GDP) em dólares norte-americanos
# código NY.GDP.MKTP.CD
  
  COD_GDP <- WDIsearch('gdp')
# é importante procurar pelo próprio
# site do banco mundial, é mais
# eficiente
  
#com o código, vamos baixar os dados

options(scipen = 999) # ajustar números (NOT. CIENT    
basepib <- WDI(country = 'all',
                 indicator = 'NY.GDP.MKTP.CD')

basepib2023 <- WDI(country = 'all',
                   indicator = 'NY.GDP.MKTP.CD',
                   start = 2023, end = 2023)
