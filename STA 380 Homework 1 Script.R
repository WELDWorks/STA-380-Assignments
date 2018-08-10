# Setup
setwd("Work Related/MSBA Summer 2018/Datasets")

# Read in Data
data_raw <- read.csv("greenbuildings.csv")
summary(data_raw)

# Clean Data
data <- data_raw # Not currently doing anything different to the dataset

# Define Constants
N <- dim(data)[1] # Number of rows of whole dataset
G <- dim(data[data$green_rating == 1,])[1] # Number of green buildings in dataset

# ----------------------------------------------------------------------

# TEST CLAIM:
# Only a handful of buildings had <10% occupancy rates, so it's safe to
# remove them on the theory that there's something irregular about them that
# will distort our analysis.
n <- length(leasing_rate)

# Quantify the amount of data discarded by ommiting 10% occupancy
for (i in c(75.0, 50.0, 35.0, 20.0, 10.0)){
  low_leasing_rate <- data[data$leasing_rate < i,]
  k <- dim(low_leasing_rate)[1]
  cat("Number of buildings with occupancy rate <=", i, ":", k, "of", n, "(", round(100.0*(k/n), 2), "%)\n")
}

# Are these low leasing buildings random?
par(mfrow=c(2,1))
# --Cluster?
plot(low_leasing_rate$cluster, low_leasing_rate$leasing_rate)
# --Green Rating?
plot(low_leasing_rate$green_rating, low_leasing_rate$leasing_rate)
summary(low_leasing_rate$leasing_rate)

# Get stats on green building to all building ratios in low occupancy vs. all occupancy
g <- dim(low_leasing_rate[low_leasing_rate$green_rating == 1,])[1]
n <- dim(low_leasing_rate)[1]
(g/n)*100 # Percent of buildings below 10% occupancy that are green

(G/N)*100 # Percent of buildings that are green

# CONCLUSION:
# It appears that there is no relationship between location and the low occupancy rates,
# but there may be a relationship in that there is only 1 green building out of
# 215 that have leasing values below 10%
# This represents 0.47% of the low leasing properties, while green buildings make
# up 8.68% of the whole dataset
# However, more than half of these 215 datapoints have no occupancy at all, suggesting
# that they aren't available for leasing at all. 
# Therefore, it is a good idea to remove them from consideration. 

# Reset
par(mfrow=c(1,1))

# ----------------------------------------------------------------------

# TEST CLAIM:
# A good approximation for the price per square foot for non-green buildings is
# $25.00 per square foot, while for green buildings it is $27.60 per square foot.
# These numbers were found using the median values for 

