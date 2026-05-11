# Load library
library(ggplot2)

# 1. Define data in a data frame
n <- 10
p <- 0.8
df <- data.frame(
    x = 0:n,
    y = dbinom(0:n, size = n, prob = p)
)

# 2. Build the plot
ggplot(df, aes(x = x, y = y)) +
    geom_bar(stat = "identity", fill = "steelblue", color = "white") +
    labs(title = paste("Binomial Distribution Curve (n =", n, ", p =", p, ")"),
         x = "Number of Successes",
         y = "Probability") +
    scale_x_continuous(labels = 0:n, breaks = 0:n)+
    theme_minimal()


# Step 1: Load the necessary library
# If you haven't installed it yet, run: install.packages("ggplot2")
library(ggplot2)

# Step 2: Define the parameters of our binomial experiment
n_flips <- 100       # Total number of coin flips
p_heads <- 0.5       # Probability of heads (fair coin)

# Step 3: Create the dataset
# We create a data frame with two columns: 'Heads' and 'Probability'
binom_data <- data.frame(
    Heads = 0:n_flips,
    Probability = dbinom(0:n_flips, size = n_flips, prob = p_heads)
)

# Step 4: Generate the ggplot2 bar plot
ggplot(binom_data, aes(x = Heads, y = Probability)) +
    # geom_col creates bars where the height represents the value in the data
    geom_col(fill = "steelblue", color = "white", linewidth = 0.1) +
    geom_line(color = "darkblue", size = 1) +
    # Add labels and a title for clarity
    labs(
        title = "Binomial Distribution: 100 Fair Coin Flips",
        subtitle = "Probability of getting exactly 'x' heads",
        x = "Number of Heads",
        y = "Probability"
    ) +
    # Use a clean theme
    theme_minimal() +
    # Focus the x-axis on the area where probabilities are non-zero (approx 30 to 70)
    coord_cartesian(xlim = c(30, 70))

library(ggplot2)

# 1. Parameters
n <- 100
p <- 0.5

# 2. Statistical Calculations
variance <- n * p * (1 - p)
std_dev <- sqrt(variance)  # Sigma is the square root of variance
mu <- n * p                # Mean

# 3. Data Preparation
df <- data.frame(
    x = 0:n,
    y = dbinom(0:n, size = n, prob = p)
)

# 4. Visualization
ggplot(df, aes(x = x, y = y)) +
    geom_col(fill = "steelblue", alpha = 0.7) +
    # Add a line for the Mean
    geom_vline(xintercept = mu, color = "red", linetype = "dashed", size = 1) +
    # Add lines for 1 Standard Deviation away from the mean
    geom_vline(xintercept = c(mu - std_dev, mu + std_dev), 
               color = "darkgreen", linetype = "dotted", size = 1) +
    labs(
        title = "Binomial Distribution with Variance Visualization",
        subtitle = paste("Mean (Red):", mu, "| Std Dev (Green):", std_dev),
        x = "Number of Successes",
        y = "Probability"
    ) +
    coord_cartesian(xlim = c(30, 70)) +
    theme_minimal()
