
# SmartCart - Ecommerce Recommendation System using R 🛒💡

### A product recommendation system built with R and Shiny, leveraging user purchase and browsing history to suggest the best products.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies](#technologies)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Examples](#examples)
- [Contributors](#contributors)

## Introduction

**SmartCart** is an ecommerce product recommendation system designed to enhance the shopping experience by suggesting personalized products to users. It uses data such as user purchase history and browsing habits, combining it with product ratings and filters like price, category, and brand to offer tailored product recommendations. Built using R and the Shiny framework, it provides a simple yet powerful interface for users to get relevant product suggestions.

## Features

✨ **Personalized Recommendations**: Suggests products based on the user's purchase and browsing history.  
📊 **Dynamic Filtering**: Users can filter recommendations by price, rating, category, and brand.  
⚡ **Boosted Products**: Products the user has interacted with are given higher recommendation scores.  
💻 **Interactive UI**: Built with Shiny, the app offers an intuitive interface for users to interact with real-time recommendations.


## Technologies

The following libraries and technologies are used in this project:

- **R**: Main programming language.
- **Shiny**: Framework for building interactive web applications.
- **dplyr**: Data manipulation for filtering and sorting products.
- **readxl**: Reading product and user data from Excel files.


## Installation

To run the SmartCart system on your local machine, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Prash-is-alive/SmartCart.git
    ```

2. **Install required R packages**:
    You need to install the following R packages if you haven't already:
    ```r
    install.packages(c("shiny", "dplyr", "readxl"))
    ```

3. **Run the Shiny app**:
    Start the Shiny application using the following command:
    ```r
    shiny::runApp("path/to/your/app")
    ```


## Usage

1. **Upload Data**: Make sure you have your product data (`sample_products.xlsx`) and user data (`sample_users.xlsx`) in the working directory.

2. **Customize Recommendations**: Use the interactive sliders and dropdowns on the UI to:
    - Set the number of recommendations.
    - Define maximum price.
    - Set the minimum rating.
    - Filter by product category or brand.

3. **View Results**: The recommended products will be displayed dynamically based on the user’s preferences and history.


## Configuration

- **Product Data**: The product data is expected to have the following columns:
    - `product_id`: Unique identifier for each product.
    - `category`: Category the product belongs to.
    - `brand`: Brand of the product.
    - `price`: Price of the product.
    - `rating`: User ratings for the product.
    - `bought_count`: Number of purchases.
    - `view_count`: Number of times the product was viewed.

- **User Data**: The user data should include:
    - `purchase_history`: Comma-separated list of purchased product IDs.
    - `browsing_history`: Comma-separated list of browsed product IDs.


## Examples

### Example 1: Recommend Top 5 Products under $500

```r
recommend_products(top_n = 5, price_limit = 500)
```

### Example 2: Recommend Products with at least 4 stars in the 'Electronics' category

```r
recommend_products(top_n = 3, min_rating = 4, category_filter = "Electronics")
```


## Contributors

[Prashant Singh](https://github.com/Prash-is-alive)

