# 📈 Supervised & Unsupervised Machine Learning in Retail


This project aims to provide deep insights into sales trends and customer behavior to support strategic decisions. The model will forecast annual revenue for a UK-base online retail store specializing in selling unique gifts. This project utilizes time series analysis, helping the retailer plan for the future and customer segmentation to enable personalized marketing, enhancing engagement and driving revenue growth.

Using this real [data](https://archive.ics.uci.edu/dataset/352/online+retail) sourced from the University of California at Irvine's (UCI) Machine Learning Repository.

## 🧹 Data Wrangling: 

• Removed records with missing "Description" or "Customer ID" fields and ~34k duplicate records.

• Filtered out canceled transactions (marked by "InvoiceNo" starting with "C").

• Converted "Customer ID" to a string for proper categorization.

• Added a new "Revenue" column by multiplying "Price" and "Quantity" for transaction-level sales analysis, aka **feature engineering**.

## Take a look at the image below to see how my data was cleaned:

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


