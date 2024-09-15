library(shiny)
library(dplyr)
library(readxl)  

# Load products and user data from external Excel files
products <- read_excel("sample_products.xlsx")  
user_data <- read_excel("sample_users.xlsx")   

# Extracting user information
user <- list(
  purchase_history = as.numeric(unlist(strsplit(as.character(user_data$purchase_history[1]), ","))),
  browsing_history = as.numeric(unlist(strsplit(as.character(user_data$browsing_history[1]), ",")))
)

# Function to recommend products (including user history and rating filtering)
recommend_products <- function(top_n = 3, price_limit = 1000, min_rating = 0, category_filter = NULL, brand_filter = NULL) {
  recommended <- products %>%
    filter(price <= price_limit & rating >= min_rating) %>%  # Price and rating filtering
    { if (!is.null(category_filter) && category_filter != "All") filter(., category == category_filter) else . } %>%  # Category filtering
    { if (!is.null(brand_filter) && brand_filter != "All") filter(., brand == brand_filter) else . } %>%  # Brand filtering
    
    # Boost products based on purchase history
    mutate(purchase_boost = ifelse(product_id %in% user$purchase_history, 10, 0)) %>%
    
    # Boost products based on browsing history
    mutate(view_boost = ifelse(product_id %in% user$browsing_history, 5, 0)) %>%
    
    # Calculate popularity score with user-specific boosts
    mutate(popularity_score = bought_count + view_count + purchase_boost + view_boost) %>%
    arrange(desc(popularity_score), desc(rating)) %>%
    head(top_n)
  
  return(recommended)
}

# Shiny UI with factors for user recommendations
ui <- fluidPage(
  tags$head(
    tags$title("E-commerce Product Recommendation System")  # Add browser title here
  ),
  
  titlePanel(h2("E-commerce Product Recommendation System", 
                style = "font-weight: bold; text-align: center; margin-bottom: 20px;")),
  
  div(style = "display: flex; flex-wrap:wrap; align-items: center;", 
      
      # Sidebar Panel
      sidebarPanel(
        sliderInput("top_n", "Select Number of Recommendations:", min = 1, max = 8, value = 3),
        sliderInput("price_limit", "Set Maximum Price:", min = 0, max = 1500, value = 1000),
        sliderInput("min_rating", "Filter by Minimum Rating:", min = 0, max = 5, value = 0, step = 0.1),
        selectInput("category_filter", "Filter by Category:", choices = c("All", unique(products$category)), selected = "All"),
        selectInput("brand_filter", "Filter by Brand:", choices = c("All", unique(products$brand)), selected = "All"),
        h3("Your Recommended Products", style = "margin-top: 20px;"),
        tableOutput("recommendation_table"),
        style = "background-color: #f9f9f9; padding: 15px; border-radius: 10px; width: 90vw; margin-bottom: 20px;"
      ),
      
      # Main Panel
      mainPanel(
        h3("Available Products", style = "margin-top: 20px;"),
        tableOutput("product_table"),
        style = "padding: 15px; background-color: #f4f4f4; border-radius: 10px; width: 90vw;"
      )
  ),
  

)

# Shiny Server
server <- function(input, output) {
  
  # Display available products with selected columns
  output$product_table <- renderTable({
    products
  })
  
  # Display recommended products with selected columns
  output$recommendation_table <- renderTable({
   recommend_products(input$top_n, input$price_limit, input$min_rating, input$category_filter, input$brand_filter)
  })
  
}

# Run the Shiny App
shinyApp(ui = ui, server = server)
