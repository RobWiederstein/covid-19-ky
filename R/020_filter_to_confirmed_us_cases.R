#get latest file
df <- file.info(list.files(pattern = "confirmed\\.csv", "./data_raw", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in file
df.00 <- read.csv(file = file, header = T, colClasses = "character")
df.01 <- dplyr::filter(df.00, Country.Region == "US")
#us states
states <- row.names(USArrests)
df.02 <- dplyr::filter(df.01, Province.State %in% states)
#set cols to numeric
df.02[3:ncol(df.02)] <- sapply(df.02[3:ncol(df.02)], as.numeric)
#select columns
df.03 <- dplyr::select(df.02, c(1:4, ncol(df.02)))
#rename columns
colnames(df.03) <- c("state", "country", "lat", "lng", "confirmed")
#name
file <- paste0("./data_tidy/", 
               Sys.Date(), 
               "_", 
               "covid_confirmed_by_state.csv")
write.csv(df.03, file = file, row.names = F)


