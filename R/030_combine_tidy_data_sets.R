#get confirmed
df <- file.info(list.files(pattern = "confirmed", "./data_tidy", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in confirmed
df.c <- read.csv(file = file, header = T, colClasses = "character")
#get deaths
df <- file.info(list.files(pattern = "deaths", "./data_tidy", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in deaths
df.d <- read.csv(file = file, header = T, colClasses = "character")
#get recoverd
df <- file.info(list.files(pattern = "recovered", "./data_tidy", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in recovered
df.r <- read.csv(file = file, header = T, colClasses = "character")
#merge all 
df.00 <- merge(df.c, df.d)
df.00 <- merge(df.00, df.r)
#set column format
df.00[, 3:ncol(df.00)] <- sapply(df.00[, 3:ncol(df.00)], as.numeric)
#save file as csv
file <- paste0("./data_tidy/", 
               Sys.Date(), 
               "_", 
               "complete_corona_data.csv")
write.csv(df.00, file = file, row.names = F)

