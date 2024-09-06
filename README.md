# 📈 Supervised & Unsupervised Machine Learning in Retail


This project aims to provide deep insights into sales trends and customer behavior to support strategic decisions. The model will forecast annual revenue for a UK-base online retail store specializing in selling unique gifts. This project utilizes time series analysis, helping the retailer plan for the future and customer segmentation to enable personalized marketing, enhancing engagement and driving revenue growth.

Using this real [data](https://archive.ics.uci.edu/dataset/352/online+retail) sourced from the University of California at Irvine's (UCI) Machine Learning Repository.

This document is meant to summarize key findings. Check out my complete [PPT Presentation](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/0e2abf9f979290aa140b7b758d73ba4f8c381f90/Project%20Presentation.pdf) for more detailed explanation of my analysis.

## 🧹 Data Wrangling: 

• Removed records with missing "Description" or "Customer ID" fields and ~34k duplicate records.

• Filtered out canceled transactions (marked by "InvoiceNo" starting with "C").

• Converted "Customer ID" to a string for proper categorization.

• Added a new "Revenue" column by multiplying "Price" and "Quantity" for transaction-level sales analysis, aka **feature engineering**.

### Take a look at the image below to see how my data was cleaned:

![cleaning](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/b6965d84d509b5c910ac40039cb24c27fbc24ba6/Project%20Steps%20%26%20Visuals/Data%20Wrangling.png)

## Descriptive Statistics:

Both Quantity and Price distributions were highly right-skewed with outliers as indicated by their high standard deviations suggesting high-quantity/high-price transactions. 

To address this, the **Box-Cox** transformation was applied, reducing skewness and making the data more normally distributed, though some outliers remained but were less extreme.

### Pre-Transformation Boxplot: 

![pre](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/b6965d84d509b5c910ac40039cb24c27fbc24ba6/Project%20Steps%20%26%20Visuals/Boxplot%20Pre-transformation%20for%20Quanitity%20%26%20Price.png).

### Post-Transformation Boxplot: 

The λ parameters below indicate that the data required a moderate transformation to approach a normal distribution.

![post](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/b6965d84d509b5c910ac40039cb24c27fbc24ba6/Project%20Steps%20%26%20Visuals/Boxplot%20Post-transformation%20for%20Quanitity%20%26%20Price.png).

# 📊 Visulazations of Some Key Metrics: 

![img1](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/fb7d74135267e8c2e45386d49942e5ff19996ad7/Project%20Steps%20%26%20Visuals/Most%20Revenue%20%26%20Profit%20Generating%20Products.png).

![img2](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/fb7d74135267e8c2e45386d49942e5ff19996ad7/Project%20Steps%20%26%20Visuals/Revenue%20by%20Country.png).

![img3](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/fb7d74135267e8c2e45386d49942e5ff19996ad7/Project%20Steps%20%26%20Visuals/Avg%20Order%20Total%20by%20Country.png).

### The fact that many other countries have higher average order totals despite contributing less to total revenue indicates that while these countries may have fewer sales transactions compared to the UK, the transactions they do have are generally larger.
### This could mean that customers in these countries are purchasing more expensive items or buying in larger quantities per transaction.

## Predictive Modelling using Supervised Machine Learning - Time Series Forecasting: 

### With the info we have so far, I will first address the question: Is there hope that revenue will increase in the next year? 

• According to the model prediction below, it will most likely continue a similar pattern as the previous years. 

There is a 95% probability that the predicted revenue values for the next year will lie within the interval (light blue shaded area).
A wider interval (like 95% CI) sacrifices some precision for increased certainty (only a 5% chance of being incorrect). Therefore, it provides a high level of confidence.

Given that the Mean Absolute Error (MAE) is quite low (0.07901568), the model has a good average performance which indicates that the model’s predictions on average are generally close to the actual revenue values, making it reliable.

![forecast](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/2775bc24c752843372ebb2285b7c24a99812291b/Project%20Steps%20%26%20Visuals/Time%20Series%20Forecast.png).

## 👩‍👦 Customer Segmentation: 

The retail store is facing an issue in that: 

• United Kingdom: drives all sales and contributes to most of the revenue but has a very low average transaction size.

• All other countries: contribute much less to total revenue but have very high average transaction totals. 

## 🔢 Application of RFM Analysis:

Therefore, we will be splitting our customers into two groups:

• those who are only from the UK.
• those who are from any of the 40 other countries. 

After that, we will be proposing a marketing tool for each group known as the **RFM (Recency, Frequency, Monetary)** in hopes of resolving the issue.

![RFM](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/2d5703c16436d76f8ac107da10ca32bfc1a1c095/Project%20Steps%20%26%20Visuals/RFM%20Explanation.png).

## Why is RFM Useful in this case? 

![RFMM](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/f0e573105e81510f1fccf71545793470418195a6/Project%20Steps%20%26%20Visuals/RFM%20Purpose.png).

## 📱 RFM Calculation Process: 

1- **RFM Values:**

For recency, each customer is first assigned a label from 1 to 5, with 5 being the most recent and 1 being the least recent. For frequency & monetary, customers with the lowest values get a label of 1, and those with the highest get a label of 5. 

2- **Segment Mapping:**

Each customer is then assigned to a segment based on their RFM Composite Score. This segmentation allows us to tailor marketing strategies appropriate to each group's behaviors and preferences.

![map](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/af0bc7bebcd89a0338b25f2280089ffde4e7374e/Project%20Steps%20%26%20Visuals/RFM%20Segment%20Mapping.png).

3- **Segment Descriptions:**

![descrip](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/f0e573105e81510f1fccf71545793470418195a6/Project%20Steps%20%26%20Visuals/RFM%20Segment%20Descriptions.png).

## K-means Clustering - Unsupervised Machine Learning

Now that I have both groups’ RFM Tables, I applied a model known as K-means which functions as a way to organize our big, mixed group of data points (customers) into smaller, more similar groups based on common features that the algorithm detects.

![kmeans](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/1d707f87ef3a7926996de91a85b9d5e4a678364f/Project%20Steps%20%26%20Visuals/K-means%20Clustering.png). 

### UK-based Customer Groups: 

![UK](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/1d707f87ef3a7926996de91a85b9d5e4a678364f/Project%20Steps%20%26%20Visuals/UK%20Customer%20Groups.png).

### All Other Countries Customer Groups: 

![int](https://github.com/AyahIbrahim/predictive-modelling-retail/blob/1d707f87ef3a7926996de91a85b9d5e4a678364f/Project%20Steps%20%26%20Visuals/All%20other%20Customer%20Groups.png). 

## 📈 Key Results

• Time series forecasting indicates a strong seasonal pattern. The model predicts a similar pattern to continue into the future year with high confidence.

• The RFM analysis has revealed key customer groups, each with distinct behaviors. The UK market, while high in transactions, shows smaller average spending. The international segments contribute less in volume but more in transaction size.

• The RFM table provides clear, actionable tips for each segment, and we will leverage these to deliver tailored marketing efforts and communication strategies, ensuring our retail store thrives in the competitive market.
