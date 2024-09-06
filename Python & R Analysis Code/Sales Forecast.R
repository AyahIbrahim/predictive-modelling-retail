library(ggplot2)
library(dplyr)
library(TTR)
library(forecast)

##### TOTAL SALES FORECASTING #####
# Read in data
df <- read.csv("Online Retail Store Monthly Sales.csv", header=TRUE)

# get overview of data
glimpse(df) 

# Convert to a time series
monthly_sales <- ts(df$Revenue, frequency=12, start=c(2009,12))

# Plot the transformed time series
plot(monthly_sales, xlab="Year", ylab="Revenue") # without log 

plot(log(monthly_sales), xlab="Order Year", ylab="Revenue") # with log --> this yields better accuracy metrics, will proceed with it
## no clear trend seen, seems stable
## uniform seasonality, not so strong


# Decompose the transformed time series
plot(decompose(log(monthly_sales)))
# there is clear seasonality
# stable trend, except for an increase in the beginning
# residuals appear random with no pattern indicating that model captutred most components of the data

# Fit a Holt-Winters model to the transformed time series
smooth_add <- HoltWinters((log(monthly_sales)), alpha=0.3, beta=0.1, gamma=1)
# alpha=0.3 moderate weighting is given to the most recent observation for the level component
# beta=0.3 moderate influence of the most recent trend changes on the model's trend component.
# gamma=0.7 strong emphasis on the seasonal component, reflecting the latest seasonal patterns significantly.

# Check the model diagnostics - residuals from the Holt-Winters model
checkresiduals(smooth_add)
# p < .05: residuals show patterns that were not captured by the model

# Plot the fitted model and forecast
plot(smooth_add)

# Forecast future values
hw_forecast <- forecast(smooth_add, h=12) # 12 for 1 year ahead
autoplot(hw_forecast) 
# model expects future values to continue in a similar pattern as seen at the end of the observed data period.

# accuracy metrics to evaluate model
accuracy(hw_forecast)
# Mean Error (ME): close to zero but very slightly underpredicting the actual values
# Root Mean Square Error (RMSE): a relatively low value, suggesting that the model's predictions are fairly accurate
# Mean Absolute Error (MAE): low value, good accuracy
# Mean Percentage Error (MPE): model's forecasts are slightly below the actual values (as it's negative), but the percentage error is quite small
# Mean Absolute Percentage Error (MAPE): the model's predictions are off by about 1.21%, but since it's below 10% it's good
# Mean Absolute Scaled Error (MASE): the model is about 33.53% worse than the naive baseline model on average, my forecasting model performs better than a naive model.
# Autocorrelation of Errors at Lag 1 (ACF1): low degree of autocorrelation in the model residuals. Values close to zero are ideal

# Historical data - ensure column names and data are correct
historical_data <- data.frame(
  Time = time(log(monthly_sales)),
  Rev = exp(log(monthly_sales))  
)

# Fitted data - make sure this matches the historical data's structure and transformations
fitted_data <- data.frame(
  Time = time(smooth_add$fitted),
  Fitted = exp(smooth_add$fitted[, "xhat"])  
)

# Forecast data - ensure all intervals and forecasts are correctly calculated
forecast_data <- data.frame(
  Time = time(hw_forecast$mean),
  Forecast = exp(hw_forecast$mean),  
  Lower_95_CI = exp(hw_forecast$lower[, "95%"]),  
  Upper_95_CI = exp(hw_forecast$upper[, "95%"]) 
)

# Ensure all plot commands reference the correct data frames and columns
ggplot() +
  geom_line(data = historical_data, aes(x = Time, y = Rev, color = "Historical Data"), size = 1) +
  geom_line(data = fitted_data, aes(x = Time, y = Fitted, color = "Fitted Model"), size = 1) +
  geom_line(data = forecast_data, aes(x = Time, y = Forecast, color = "Forecast"), size = 1) +
  geom_ribbon(data = forecast_data, aes(x = Time, ymin = Lower_95_CI, ymax = Upper_95_CI, fill = "95% CI"), alpha = 0.5) +
  scale_color_manual(values = c("Historical Data" = "black", "Fitted Model" = "red", "Forecast" = "blue")) +
  scale_fill_manual(values = c("95% Confidence Interval" = "lightblue")) +
  labs(title = "Historical Data, Fitted Model, and Forecast with 95% Confidence Interval",
       y = "Sales",
       x = "Time",
       color = "Legend",
       fill = "Interval") +
  theme_minimal() 

ggplot(forecast_data, aes(x = Time)) +
  geom_line(aes(y = Forecast), color = "blue") +
  geom_ribbon(aes(ymin = Lower_95_CI, ymax = Upper_95_CI), fill = "lightblue", alpha = 0.5) +
  labs(title = "Forecast with 95% Confidence Intervals", y = "Forecasted Sales", x = "Year")

# Conclusion based on results:

# model appears to fit the historical data reasonably well.
# The forecasted sales show a continuation of the recent pattern into the future, with a generally stable trend but with fluctuations that reflect the seasonal pattern observed in the historical data.
# the range of expected sales expands over time, reflecting increasing uncertainty. However, despite this uncertainty, the model gives a clear indication of expected seasonal peaks and troughs.







