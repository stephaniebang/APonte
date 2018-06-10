ddd <- readRDS(paste0(dirname(rstudioapi::getActiveDocumentContext()$path), '/data.RDS'))

l <- list()

for (i in 1:30){
  l[[i]] <- ddd[i,]
}
