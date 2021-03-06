library(dplyr)

resourceID <- '9mfq-cb36'
source('download-cdc-api-data/download.r')

rb$submission_date_formatted <- as.Date(rb$submission_date)

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