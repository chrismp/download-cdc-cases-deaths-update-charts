source('cases-deaths-by-state.r')
library(zoo)

mvavg <- function(x,n){stats::filter(x,rep(1/n,n), sides=1)}

fl <- filter(
  .data = rb,
  state == 'FL',
  submission_date_formatted >= '2020-03-01'
)

fl <- fl[order(submission_date_formatted)]

fl$new_case <- as.numeric(fl$new_case)
# fl$new_case_7day_avg <- rollmean(
#   x = fl$new_case,
#   k = 7,
#   fill = NA
# )

fl$new_case_7day_avg <- mvavg(
  x = fl$new_case,
  n = 7
)

fl$new_deaths_7day_avg <- mvavg(
  x = fl$new_death,
  n = 7
)


write.csv(
  x = fl,
  file = paste0(o,'/cases-and-deaths-for-Florida.csv'),
  na = '',
  row.names = F
)