# Load up the RGA package. This is the package that has the smarts to actually
# connect to and pull data from the Google Analytics API
library(RGA)

# Authorize the Google Analytics account
ga_token <- authorize(client.id = "YOUR_GA_CLIENTID", 
                      client.secret = "YOUR_GA_SECRETID")

# Perform a simple query and assign the results to a "data frame" called gaData.
# 'gaData' is just an arbitrary name, while get_ga is a function inside the RGA package.
gaData <- get_ga(profileId = "YOUR_GA_VIEWID", start.date = "7daysAgo",
                 end.date = "yesterday", metrics = c("ga:users", "ga:sessions"," ga:pageviews"), 
                 dimensions = "ga:date", sort = NULL, filters = NULL,
                 segment = NULL, samplingLevel = NULL, start.index = NULL,
                 max.results = NULL, include.empty.rows = NULL, fetch.by = NULL, ga_token)

# Create a simple line chart.
# This is putting the "date" values from gaData as the x "values," the number of sessions
# (the "sessions" value) as the y values, and is then specifying that it should be plotted
# as a line chart (type="l"). The "ylim" forces a 0-base y-axis by specifying a "vector"
# that goes from 0 to the maximum value for sessions in the gaData data frame.
plot(gaData$date,gaData$sessions,type="l",ylim=c(0,max(gaData$sessions)))