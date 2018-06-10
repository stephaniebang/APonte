library(plotly)

path    <- dirname(rstudioapi::getActiveDocumentContext()$path)
source(paste0(path, '/openrds.R'))
source(paste0(path, "/", "open_csv_2.R"), local = T)
salvar1 <- c("inter", "perio")


find_id <- function(i, p) {
  j <- 1
  
  if (i=="Matemática") {
    ii <- '(matemática)'
  }
  
  else {
    ii <- '(administração)'
  }
  
  if (p=='Noturno') {
    pp <- '(noturno)'
  }
  
  else if (p=='Diurno') {
    pp <- '(diurno)'
  }
  
  else {
    pp <- '(vespertino)'
  }
  
  while (j < 30) {
    if (stringr::str_detect(l[[j]]$objetivos, ii) & stringr::str_detect(l[[j]]$perido_disciplina, pp))
      return(j)
    
    j <- j+5
  }
  
  return(j)
}

recommend <- function(i, p) {
  j <- find_id(i, p)
  
  if (i=="Matemática") {
    ii <- 'grupo USPCodeLab'
    
    j <- 11
  }
  
  else {
    ii <- 'grupo NEU'
  }
  
  if (j > 30)
    return(paste0('1. ', ii))
  
  k <- 1
  
  s <- paste0('1. ', l[[j]]$nome_disciplina)
  
  while (k < 5) {
    s <- paste0(s, '<br>',toString(k+1),'. ', l[[j+k]]$nome_disciplina)
    k <- k+1
  }
  
  return(paste0(s,  '<br>',toString(k+1),'. ', ii))
}

saveData <- function(data1) {
  intere <- gsub("^(.*?),.*", "\\1", data1)
  period <- sub("^[^ ]*", "", data1)
  showModal(modalDialog(
    title = "Recomendações",
    HTML(recommend(intere, period)),
    easyClose = TRUE
  ))
}

server <- function(input, output, session) {
  # Enable the Submit button when all mandatory fields are filled out
  # observe({
  #   mandatoryFilled <- vapply(fieldsMandatory,
  #                             function(x) {
  #                               !is.null(input[[x]]) && input[[x]] != ""
  #                               },
  #                             logical(1))
  #   mandatoryFilled <- all(mandatoryFilled)
  #   
  #   shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  # })
  
  observeEvent(input$enter, {
    updateTabsetPanel(session, "tabset",
                      selected = "form_panel"
    )
  })
  
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  output$plot1 <- renderPlotly({
    dados %>% count(interesse) %>%  
      mutate(porcentagem = n/sum(n)) %>% 
      ggplot(aes(x = interesse, porcentagem))+geom_col(fill = "#D45440")+
      scale_y_continuous(labels = scales::percent)+
      labs(title = "Qual o percentual de interesse por tecnologia na USP?", y = "Porcentagem")+theme(axis.text=element_text(size=10),
                                                                                                     axis.title=element_text(size=8))
  })
  
  output$plot2 <- renderPlotly({
    dados %>% filter(interesse == "Tecnologia") %>% 
      ggplot(aes(cred_aula, ..count..)) + geom_bar(position = "dodge", fill = "#D45440")+
      labs(title = "Como os interessados em Tecnologia escolheram os créditos pela avaliação", x = "crédito aula", "quantidade")+theme(legend.position = "bottom")+facet_grid(.~avaliacao)+theme(axis.title.y = element_text(margin = margin(t = 10, r = 30, b = 10, l = 0)))
  }) 
  
  
  # Gather all the form inputs (and add timestamp)
  formData <- reactive({
    data1 <- sapply(salvar1, function(x) input[[x]])
    data1 <- toString(data1)
    data1
  })
}