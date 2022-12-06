source('cases-deaths-by-state.r')
# devtools::install_github("munichrocker/DatawRappr",ref="master")

library(DatawRappr)

print("Starting chart updater")

#updateDateFormat <- gsub(
#  pattern = " 0",
#  replacement = ' ',
#  x = format(
#    x = max(rb$end_date),
#    format = "%B %d, %Y"
#  )
#)

updateDateFormat <- format(
  x = max(rb$end_date),
  format = "%B %d, %Y"
)


chartIDs <- c(
  'q5syP', # total cases
  'wGPJ0' # new cases
  # 'B18iA' # total deaths
  # 'ULrmv' # new deaths
)

apikey <- Sys.getenv("DATAWRAPPER_API")
print(updateDateFormat)
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
