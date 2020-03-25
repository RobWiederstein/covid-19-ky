url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
destfile <- paste("./data_raw/", paste0(Sys.Date(), "_"), basename(url), sep = "")
destfile <- tolower(destfile)
download.file(url = url, destfile = destfile, method = "curl")
