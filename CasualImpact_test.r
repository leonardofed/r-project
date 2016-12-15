install.packages("devtools")
library(devtools)
devtools::install_github("HenrikBengtsson/devtools@hotfix/parse_deps")
devtools::install_github("google/CausalImpact", "HenrikBengtsson/devtools@hotfix/parse_deps")


library(CausalImpact)

set.seed(1)
x1 <- 100 + arima.sim(model = list(ar = 0.999), n = 100)
y <- 1.2 * x1 + rnorm(100)
y[71:100] <- y[71:100] + 10
data <- cbind(y, x1)

dim(data)

head(data)

matplot(data, type = "l")

pre.period <- c(1, 70)
post.period <- c(71, 100)

library(CausalImpact)
impact <- CausalImpact(data, pre.period, post.period)

plot(impact)
summary(impact) # Get a summary of your graph
summary(impact, "report") # Get a detailed report of your graph