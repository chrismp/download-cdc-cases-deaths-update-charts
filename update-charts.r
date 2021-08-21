source('fl-cases-deaths-7-day-avg.r')
# devtools::install_github("munichrocker/DatawRappr",ref="master")

library(DatawRappr)

print("Starting chart updater")

updateDateFormat <- gsub(
  pattern = " 0",
  replacement = ' ',
  x = format(
    x = max(fl$submission_date_formatted),
    format = "%B %d, %Y"
  )
)

chartIDs <- c(
  'gOqmg', # total cases
  'IO4D3', # new cases
  'B18iA', # total deaths
  'ULrmv' # new deaths
)

apikey <- Sys.getenv("DATAWRAPPER_API")

for (id in chartIDs) {
  dw_edit_chart(
    chart_id = id,
    api_key = apikey,
    annotate = paste0("Updated ",updateDateFormat,'.')
  )
  print("Publishing chart")  
  dw_publish_chart(
    chart_id = id,
    api_key = apikey,
    return_urls = TRUE
  )  
}



