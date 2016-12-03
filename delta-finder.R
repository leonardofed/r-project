library(googleAnalyticsR)
ga_auth()

al <- google_analytics_account_list()

gaid <- YOUR_GAVIEW_ID

#' Start of the month
#' @param x A date
som <- function(x) {
  as.Date(format(x, "%Y-%m-01"))
}

#' End of the month
#' @param x A date
eom <- function(x) {
  som(som(x) + 35) - 1
}

#' Start and end of month
get_start_end_month <- function(x = Sys.Date()){
  c(som(som(x) - 1), som(x) - 1)
}

last_month <- get_start_end_month()
year_before <- get_start_end_month(Sys.Date() - 365)

## only organic traffic
seo_filter <- filter_clause_ga4(list(dim_filter("medium", 
                                                "EXACT", 
                                                "organic")
))

## met filters are on the first date
transaction0 <- filter_clause_ga4(list(met_filter("goal3Completions", 
                                                  "GREATER_THAN", 
                                                  0)))

## order by the delta change of year_before - last_month
delta_compl <- order_type("goal3Completions","DESCENDING", "DELTA")

gadata <- google_analytics_4(gaid,
                             date_range = c(year_before, last_month),
                             metrics = c("sessions","goal3Completions"),
                             dimensions = c("landingPagePath"),
                             dim_filters = seo_filter,
                             met_filters = transaction0,
                             order = delta_compl,
                             max = 20)

gadata$goal3Completions.delta <- gadata$goal3Completions.d2 - gadata$goal3Completions.d1