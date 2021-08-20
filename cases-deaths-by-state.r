library(jsonlite)
library(data.table)
library(dplyr)

limit <- 10000
offset <- 0
i <- 1
l <- list()

while(T){
  url <- paste0('https://data.cdc.gov/resource/9mfq-cb36.json?$limit=',limit,'&$offset=',offset)
  print(url)
  d <- fromJSON(url)
  
  d$submission_date_formatted <- as.Date(d$submission_date)
  
  l[[i]] <- d
  if(nrow(d)<limit) break
  offset <- offset + limit
  i <- i + 1
}

rb <- rbindlist(
  l = l,
  fill = T
)

o <- 'output'
dir.create(o)

write.csv(
  x = rb,
  file = paste0(o,'/cases-and-deaths-by-state.csv'),
  na = '',
  row.names = F
)

write.csv(
  x = filter(
    .data = rb,
    state %in% c('CA','TX','FL','NY','IL')
  ),
  file = paste0(o,'/cases-and-deaths-for-five-biggest-states.csv'),
  na = '',
  row.names = F
)
