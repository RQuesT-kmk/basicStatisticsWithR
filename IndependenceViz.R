# 1. Define independent probabilities
p_a <- 0.7  # Probability of Event A
p_b <- 0.4  # Probability of Event B
p_intersection <- p_a * p_b # Multiplication rule for independent events

# 2. Initialize a blank plot representing the total sample space (Area = 1)
plot(c(0, 1), c(0, 1), type = "n", 
     main = expression(paste("Independence: P(A \u2229 B) =", P(A) %*% P(B))),
     xlab = "P(A)", ylab = "P(B)", 
     asp = 1) # asp=1 ensures the plot is a perfect square

# 3. Draw Event A as a vertical strip (Blue)
rect(0, 0, p_a, 1, col = rgb(0, 0, 1, 0.2), border = "blue", lwd = 2)

# 4. Draw Event B as a horizontal strip (Yellow)
rect(0, 0, 1, p_b, col = rgb(1, 1, 0, 0.2), border = "orange", lwd = 2)

# 5. Draw the Intersection (Green - where blue and yellow overlap)
rect(0, 0, p_a, p_b, col = rgb(0, 1, 0, 0.5), border = "darkgreen", lwd = 3)

# 6. Add labels to the plot
text(p_a/2, 0.9, "Event A", col = "blue", font = 2)
text(0.85, p_b/2, "Event B", col = "orange", font = 2)
text(p_a/2, p_b/2, "P(A \u2229 B)", col = "darkgreen", font = 2)

# 7. Mathematical Annotation
legend("topright", bty = "n",
       legend = c(paste("P(A) =", p_a),
                  paste("P(B) =", p_b),
                  paste("Area =", p_intersection)))
