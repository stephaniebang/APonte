O aplicativo foi desenvolvido em Shiny, e para que seja possível executá-lo, é
preciso do RStudio (infelizmente, a biblioteca do plotly da erros e não é possível
visualizar os plots apenas com o ambiente R). Você pode instalá-lo através deste 
link: https://www.rstudio.com/products/rstudio/download-server/

Após abrí-lo, execute os comandos a seguir para instalar os pacotes necessários:

install.packages("shiny")
install.packages("shinythemes")
install.packages("shinyjs")
install.packages("tidyverse")
install.packages("plotly")
install.packages("ggthemes")
install.packages("devtools")
library(shiny)
library(shinythemes)
library(shinyjs)
library(tidyverse)
library(plotly)
library(ggthemes)
library(devtools)
devtools::install_github('shiny-incubator', 'rstudio')
library(shiny_incubator)

Agora, abra o arquivo ui.R ou server.R e aperte as teclas Ctrl+Alt+Enter. Isso fará com que o aplicativo seja executado.