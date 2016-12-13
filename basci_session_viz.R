if(!require(googleAnalyticsR)) install.packages("googleAnalyticsR")
if (!require(knitr)) install.packages("knitr")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(reshape2)) install.packages("reshape2")

library(googleAnalyticsR)
library(knitr)
ga_auth()

## replace with your own Google Analytics View Id
view_id <- 77890617

## get data, use pivot to get columns of medium sessions
trend_data <- google_analytics_4(view_id,
                                 date_range = c(Sys.Date() - 400, Sys.Date()),
                                 dimensions = c("date"),
                                 metrics = "sessions",
                                 pivots = pivot_ga4("medium","sessions"),
                                 max = -1)

## Note the medium columns created by the pivot
head(trend_data)

## format the names
names(trend_data)

names(trend_data) <- c("Date","Total","Referral","Direct","Social")

## check the data R classes
## This time all look good - Date objects for date and numeric for the metrics
str(trend_data)

# make a time-series object
trend_ts <- ts(trend_data[-1], frequency = 7)
plot(Total ~ Date, data = trend_data, type = "l")
axis(1, trend_data$Date, format(trend_data$Date, "%b"))

library(ggplot2)
library(reshape2)

## change data into 'long' format
trend_long <- melt(trend_data, id = "Date")
head(trend_long)

## build up the plot
gg <- ggplot(trend_long, aes(x = Date, y = value, group = variable)) + theme_minimal()
gg <- gg + geom_line(aes(colour = variable))
gg