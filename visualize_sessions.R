library(highcharter)
library(googleAnalyticsR)
library(reshape2)
library(forecast)

view_id <- your_GA_viewID
ga_auth()

gadata <- google_analytics_4(view_id, 
                             date_range = c(Sys.Date() - 400, Sys.Date()),
                             metrics = "sessions", 
                             dimensions = c("date","hour"),
                             max = -1)

gadata$weekday <- ordered(weekdays(gadata$date, FALSE), 
                          levels = c("Monday","Tuesday","Wednesday",
                                     "Thursday","Friday","Saturday","Sunday")) 


heatmap_data <- gadata[, c("weekday","hour","sessions")]

heatmap_recast <- dcast(heatmap_data, weekday ~ hour, sum)

heatmap_matrix <- as.matrix(heatmap_recast[-1])

row.names(heatmap_matrix) <- c("Monday","Tuesday","Wednesday",
                               "Thursday","Friday","Saturday","Sunday")

## heatmap of weekdays per hour
hchart(heatmap_matrix, type = "heatmap")