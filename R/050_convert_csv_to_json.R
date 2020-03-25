#read in full data set
df <- file.info(list.files(pattern = "final", "./data_tidy", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
df.00 <- read.csv(file = file, header = T, colClasses = "character")
#format columns
df.00[ , 3:7] <- sapply(df.00[, 3:7], as.numeric)
#convert to json
require("leafletR")
#convert geojson
name <- c("final_corona_virus_data")
toGeoJSON(data = df.00, name = name, dest = "./data_tidy/", lat.lon =c(3, 4))
