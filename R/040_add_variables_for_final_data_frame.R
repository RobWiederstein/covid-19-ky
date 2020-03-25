#read in full data set
df <- file.info(list.files(pattern = "complete", "./data_tidy", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in confirmed
df.00 <- read.csv(file = file, header = T, colClasses = "character")
#set column format
df.00[, 3:ncol(df.00)] <- sapply(df.00[, 3:ncol(df.00)], as.numeric)
#add column for intervals. Label Icon1 ... Icon5
my_labels <- c("icon1", "icon2", "icon3", "icon4", "icon5")
df.00$icon <- ggplot2::cut_interval(df.00$confirmed, n = 5, labels = my_labels)
df.00$icon
#add date
df.00$date <- Sys.Date()
#write out .csv
file <- paste0("./data_tidy/", 
               "final_corona_virus_data.csv")
write.csv(df.00, file = file, row.names = F)

