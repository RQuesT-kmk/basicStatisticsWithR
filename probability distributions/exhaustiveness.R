# 1. Generate a sample of 1000 observations from a standard normal distribution
set.seed(42) # Ensuring the plot looks the same every time you run it
data <- rnorm(1000, mean = 0, sd = 1)

# 2. Create the Histogram
# 'prob = TRUE' or 'freq = FALSE' ensures the area of the bars sums to 1
hist(data, 
     prob = TRUE, 
     col = "lightgray", 
     border = "white",
     main = "",
     xlab = "Mutually exclusive values",
     xlim = c(-4, 4))

# 3. Add the theoretical Normal Curve
# We create a sequence of x values for a smooth line
x_seq <- seq(-4, 4, length.out = 100)
y_dist <- dnorm(x_seq, mean = 0, sd = 1)
lines(x_seq, y_dist, col = "royalblue", lwd = 3)

# 4. Add the Annotation
# text(x, y, label) allows us to place text anywhere on the grid
text(x = 2, y = 0.3, 
     labels = expression(paste("Total Area" == 1)), 
     col = "darkred", 
     font = 2)

# 5. Optional: Add an arrow pointing to the curve
arrows(x0 = 1.8, y0 = 0.28, x1 = 1, y1 = 0.24, 
       length = 0.1, col = "darkred", lwd = 2)
