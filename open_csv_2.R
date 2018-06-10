path <- dirname(rstudioapi::getActiveDocumentContext()$path)
dados <- read.csv(paste0(path,"/", "dados_simulados.csv"), encoding = "latin1", stringsAsFactors = F)
