library(shiny)
library(shinythemes)
library(shinyjs)


# Variables ---------------------------------------------------------------
interesses <- c("Administração", "Matemática")
avaliacoes <- c("Prova", "Trabalho", "Prova e trabalho")
periodos <- c("Diurno",  "Vespertino", "Noturno")
duracoes <- c("Semestral", "Anual")
variaveis <- c("inter", "creda", "credt", "avali", "perio", "durat")


form <- list(selectInput(variaveis[1], "Selecione um campo de seu interesse:",
                         interesses),
             sliderInput(variaveis[2], "Quantos créditos aula você pretende cursar pelo menos?",
                         0, 6, 0, ticks = FALSE),
             sliderInput(variaveis[3], "Quantos créditos trabalho você pretende cursar pelo menos?",
                         0, 6, 0, ticks = FALSE),
             radioButtons(variaveis[4], "Qual o seu critério de avaliação preferido?",
                         avaliacoes),
             radioButtons(variaveis[5], "Em qual período você está disponível?",
                         periodos),
             radioButtons(variaveis[6], "Qual duração do curso você prefere?",
                          duracoes),
             actionButton("submit", "Submit", class = "btn-primary"))


# UI ----------------------------------------------------------------------
ui <- navbarPage(
  id="tabset",
  theme = shinytheme("united"),
  "APonte",
  tabPanel("",
           icon = icon("home", lib = "glyphicon"),
           h1("O que você vai estar fazendo amanhã?",
              style = "color: #17BEBB"),
           p("Precisa de uma ajuda para escolher os cursos do próximo semestre?",
             style = "color: #2E282A"),
           p("Interessado em fazer algo novo?",
             style = "color: #2E282A"),
           br(),
           div(textInput("user", "Usuário", "")),
           div(passwordInput("passw", "Senha", "")),
           actionButton("enter", "ENTRAR", class = "btn-primary")
          ),
  # tabPanel("",
  #          value = "form_panel",
  #          icon = icon("wpforms"),
  #          div(form),
  #          br()
  #          ),
  tabPanel("",
           value = "form_panel",
           icon = icon("wpforms"),
           sidebarLayout(sidebarPanel(width = 4,
                                      "Preencha o formulario ao lado com "),
                         mainPanel(div(form)))),
  tabPanel("",
           value = "result_panel",
           icon = icon("bar-chart-o"),
           h1("Sugestões"),
           p(),
           fluidPage(
             plotlyOutput("plot1"),
             plotlyOutput("plot2")
           )
  )
)
