library(googleAnalyticsR) # Load RGA library every time you start RStudio
ga_auth() # Authenticate
library(CausalImpact) # Load CausalImpact library every time you start RStudio
view_id <- your_View_ID 



gaDataIntervention <- google_analytics_4(view_id,
                                         date_range = c(Sys.Date() - 400, Sys.Date()),
                                         dimensions = c("date"),
                                         metrics = "sessions",
                                         pivots = pivot_ga4("medium","sessions"),
                                         max = -1)


gaDataNonIntervention <- google_analytics_4(view_id,
                                            date_range = c(Sys.Date() - 400, Sys.Date()),
                                            dimensions = c("date"),
                                            metrics = "sessions",
                                            pivots = pivot_ga4("medium","sessions"),
                                            max = -1)

head(gaDataIntervention) 
mode(gaDataIntervention) 
head(gaDataNonIntervention) 
mode(gaDataNonIntervention)

combinedData <- cbind(gaDataIntervention, gaDataNonIntervention)

head(combinedData) 
workingData <- combinedData[ -c(3) ]
head(workingData) 

pre.period <- c(as.Date("2014-01-01"), as.Date("2014-03-11")) 
post.period <- c(as.Date("2014-03-12"), as.Date("2014-04-10"))

# Run CausalImpact
impact <- CausalImpact(workingData, pre.period, post.period) 

plot(impact)