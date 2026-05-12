library(manipulate)


# We use a seed so the "randomness" is consistent while you learn
set.seed(123)

manipulate(
    {
        # 1. Generate synthetic Diastolic Blood Pressure data
        # Mean is set to 80, Standard Deviation to 12
        bp_data <- rnorm(n, mean = 80, sd = 12)
        
        # 2. Draw the Histogram
        # 'prob = TRUE' is required to overlay a density curve correctly
        hist(bp_data, 
             breaks = 20, 
             prob = TRUE, 
             col = "lightblue", 
             border = "white",
             main = paste("Distribution of diastolic BP (n = ", n, ")"),
             xlab = "Diastolic Blood Pressure (mmHg)",
             xlim = c(40, 120),
             ylim = c(0, 0.05))
        
        # 3. Add the Empirical Density Curve (The "Shape" of the data)
        lines(density(bp_data), col = "red", lwd = 2)
        
        # 4. Add a theoretical Normal Curve for comparison
        # This helps show how "Bell-shaped" the data is becoming
        x_range <- seq(40, 120, length.out = 100)
        y_theory <- dnorm(x_range, mean = 80, sd = 12)
        lines(x_range, y_theory, col = "darkblue", lwd = 2, lty = 2)
        
        legend("topright", legend = c("Empirical Density", "Theoretical Bell"),
               col = c("red", "darkblue"), lty = c(1, 2), lwd = 2)
    },
    # 5. Slider to increase the population size
    n = slider(5, 5000, initial = 10, step = 5, label = "Population Size (n)")
)



manipulate(
    {
        # 1. Define the range for the x-axis (the "stage" where the curve lives)
        x_values <- seq(40, 120, length.out = 100)
        
        # 2. Calculate the y-values (the bell curve height)
        y_values <- dnorm(x_values, mean = mu, sd = sd)
        
        # 3. Create the plot
        plot(x_values, y_values, 
             type = "l",             # "l" means a line plot
             lwd = 2,                # Line width
             col = "slateblue",           # Color of the curve
             main = paste("Normal Distribution of Diastolic BP: mu =", mu, ", sd =", sd),
             xlab = "Diastolic BP", 
             ylab = "Density",
             ylim = c(0, 0.1))      # Keep Y-axis fixed to see the height change clearly
        
        abline(v = mu, col = "firebrick", lty = 2)
    },
    # 4. Define the interactive sliders
    mu = slider(60, 90, initial = 85, step = 5, label = "Mean (Center)"),
    sd = slider(5, 20, initial = 10, step = 5, label = "Standard Deviation (Spread)")
)
