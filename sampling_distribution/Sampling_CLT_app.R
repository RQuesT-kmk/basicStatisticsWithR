library(shiny)
library(tidyverse)
library(patchwork)

# ==========================================
# 1. STATIC POPULATION GENERATION (GLOBAL)
# ==========================================
set.seed(42) # For reproducibility
target_mean <- 130
shape_param <- 20
scale_param <- target_mean / shape_param

# Create our baseline population of 1000 women
population_data <- tibble(
    sbp = rgamma(n = 1000, shape = shape_param, scale = scale_param)
)
pop_mean <- mean(population_data$sbp)


# ==========================================
# 2. USER INTERFACE (UI)
# ==========================================
ui <- fluidPage(
    titlePanel("Sampling Distribution Simulator: Blood Pressure"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "n", label = "Sample Size (n):", 
                        min = 2, max = 200, value = 5, step = 1),
            
            sliderInput(inputId = "sims", label = "Number of Simulations:", 
                        min = 100, max = 5000, value = 1000, step = 100),
            
            actionButton(inputId = "resample", label = "Draw Fresh Samples", 
                         icon = icon("refresh")),
            hr(),
            helpText("Watch how the bottom distribution normalizes and narrows as you increase 'n', while its center stays perfectly anchored to the red population line.")
        ),
        
        mainPanel(
            # Increased height to 750px so all three stacked plots are clearly legible
            plotOutput(outputId = "clt_plots", height = "750px")
        )
    )
)


# ==========================================
# 3. SERVER LOGIC
# ==========================================
server <- function(input, output, session) {
    
    # Reactive Engine: Runs whenever sliders change or button is clicked
    sampling_engine <- reactive({
        # Explicitly trigger whenever the resample button is clicked
        input$resample
        
        current_n <- input$n
        current_sims <- input$sims
        
        # Generate all simulations at once using a matrix for extreme speed
        # Rows = sample size (n), Columns = number of simulations
        sample_matrix <- matrix(
            sample(population_data$sbp, size = current_n * current_sims, replace = TRUE),
            nrow = current_n, 
            ncol = current_sims
        )
        
        # Extract the first sample (Column 1) for the middle plot
        first_sample_data <- tibble(sbp = sample_matrix[, 1])
        
        # Calculate the mean of every column (simulation) for the bottom plot
        all_sample_means <- tibble(means = colMeans(sample_matrix))
        
        # Return both data sets as a bundled list
        list(
            first_sample = first_sample_data,
            distribution = all_sample_means
        )
    })
    
    # Render the Patchwork Plot Matrix
    output$clt_plots <- renderPlot({
        # Fetch the processed datasets from our reactive engine
        data_bundle <- sampling_engine()
        
        # --- PLOT 1: POPULATION (STATIC) ---
        p1 <- ggplot(population_data, aes(x = sbp)) +
            geom_histogram(fill = "gray60", color = "white", bins = 40) +
            geom_vline(xintercept = pop_mean, color = "red", linetype = "dashed", linewidth = 1) +
            coord_cartesian(xlim = c(90, 190)) +
            labs(title = "1. True Population Distribution (N = 1000)", 
                 subtitle = paste("True Mean =", round(pop_mean, 2), "mmHg (Highly Right-Skewed)"),
                 x = NULL, y = "Count") +
            theme_minimal()
        
        # --- PLOT 2: SINGLE SAMPLE (DYNAMIC) ---
        sample_mean_dynamic <- mean(data_bundle$first_sample$sbp)
        
        p2 <- ggplot(data_bundle$first_sample, aes(x = sbp)) +
            geom_histogram(fill = "steelblue", color = "white", bins = round(max(5, input$n / 4))) +
            geom_vline(xintercept = pop_mean, color = "red", linetype = "dashed", linewidth = 1) +
            geom_vline(xintercept = sample_mean_dynamic, color = "blue", linetype = "solid", linewidth = 1) +
            coord_cartesian(xlim = c(90, 190)) +
            labs(title = paste("2. A Single Random Sample (n =", input$n, ")"),
                 subtitle = paste("Sample Mean (Blue Line) =", round(sample_mean_dynamic, 2), "mmHg"),
                 x = NULL, y = "Count") +
            theme_minimal()
        
        # --- PLOT 3: SAMPLING DISTRIBUTION (DYNAMIC) ---
        dist_mean <- mean(data_bundle$distribution$means)
        
        p3 <- ggplot(data_bundle$distribution, aes(x = means)) +
            geom_histogram(fill = "darkorange", color = "white", bins = 40) +
            geom_vline(xintercept = dist_mean, color = "red", linetype = "dashed", linewidth = 1.2) +
            coord_cartesian(xlim = c(90, 190)) +
            labs(title = paste("3. Sampling Distribution of the Mean (", input$sims, " Simulations)", sep=""),
                 subtitle = paste("Center of Means =", round(dist_mean, 2), "mmHg (Normalizes via CLT)"),
                 x = "Systolic Blood Pressure (mmHg)", y = "Count") +
            theme_minimal()
        
        # --- STITCH THEM TOGETHER WITH PATCHWORK ---
        # Stack vertically and ensure the layout formatting matches nicely
        p1 / p2 / p3
    })
}

# ==========================================
# 4. LAUNCH THE APP
# ==========================================
shinyApp(ui = ui, server = server)
