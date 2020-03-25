#get confirmed data raw
df <- file.info(list.files(pattern = "confirmed", "./data_raw", full.names = T))
file <- rownames(df)[which.max(df$mtime)]
#read in confirmed
df.00 <- read.csv(file = file, header = T, colClasses = "character")
#filter to us
df.01 <- dplyr::filter(df.00, Country.Region == "US")
#filter to state level
states <- row.names(USArrests)
df.02 <- dplyr::filter(df.01, Province.State %in% states)
#convert from wide to long
omit_cols <- c("Province.State", "Country.Region", "Lat", "Long")
df.03 <- tidyr::gather(df.02, key = "date", value = "confirm", -omit_cols)
#format date column
df.03$date <- gsub("X", "0", df.03$date)
df.03$date <- as.Date(df.03$date, "%m.%d.%y")
#reorder by state and then date
df.04 <- dplyr::arrange(df.03, Country.Region, Province.State, date)
#omit 0
df.05 <- dplyr::filter(df.04, confirm != "0")
#add day 1
library(dplyr)
library(magrittr)
df.06 <-
        df.05 %>% 
        group_by(Country.Region, Province.State) %>% 
        mutate(day = row_number())

my_states <- c("Kentucky", "Tennessee", "Indiana", "Ohio")
df.07 <- dplyr::filter(df.06, Province.State %in% my_states)

#plotly
library(plotly)
library(magrittr)
library(RColorBrewer)
df.07$confirm <- as.integer(df.07$confirm)
df.07$Province.State <- as.factor(df.07$Province.State)
df.07$update <- Sys.Date()
p <- plot_ly(df.07, 
             x = ~day, 
             y = ~confirm, 
             type = 'scatter', 
             color = ~Province.State,
             colors = brewer.pal(length(unique(df.07$Province.State)), "Set1"),
             text = ~update,
             mode = 'lines+markers',
             hovertemplate = 
                     paste("Covid-19 Confirmed<br>",
                           "<b>update:</b> %{text}<br>",
                           "<b>days:</b> %{x}<br>",
                           "<b>pos:</b> %{y}"
                           )
             )

p <- p %>% layout(title = 'Covid-19 Confirmations by Day',
                       xaxis = list(title = 'days'),
                       yaxis = list (title = 'confirmed'))
p

#don't put api keys into public repository
Sys.setenv(Sys.getenv("plotly_username"))
Sys.setenv(Sys.getenv("plotly_api_key"))
api_create(p)

#chart y-axis is log scale
library(ggplot2)
library(ggthemes)
library(cowplot)
df.06$confirm <- as.integer(df.06$confirm)
p <- ggplot(df.06, aes(day, confirm,  group = Province.State),
            colour = "grey",
            alpha = .2)
df.ky <- dplyr::filter(df.06, Province.State == "Kentucky")
p <- p + scale_y_continuous(trans='log2')
p <- p + geom_line(colour = "grey")
p <- p + geom_line(data = df.ky, aes(day, confirm), colour = "blue")
p <- p + ggtitle("Covid-19 Confirmed Cases by State")
p <- p + theme_fivethirtyeight()
p