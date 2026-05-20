# 1. Define our Probability Parameters
p_b <- 0.6          # Probability of Event B
p_a_given_b <- 0.5  # Probability of A occurring given B has occurred
p_a_and_b <- p_b * p_a_given_b # The Multiplication Rule

# 2. Set up a blank plot 'canvas' representing the Total Sample Space (1.0)
plot(c(0, 1), c(0, 1), type = "n", 
     main = "Visualizing the Multiplication Rule",
     xlab = "Sample Space (Total Area = 1)", ylab = "", 
     xaxt = 'n', yaxt = 'n')

# 3. Draw Event B (The "Given" space)
# This rectangle spans from x=0 to x=0.6
rect(0, 0, p_b, 1, col = rgb(0.2, 0.4, 0.6, 0.3), border = "blue", lwd = 2)
text(p_b/2, 0.9, "Event B", col = "blue", font = 2)

# 4. Draw Event A AND B (The intersection)
# This is a subset of B. Its area is p_b * p_a_given_b
rect(0, 0, p_b, p_a_given_b, col = rgb(1, 0, 0, 0.5), border = "red", lwd = 2)
text(p_b/2, p_a_given_b/2, "P(A \u2229 B)", col = "darkred", font = 2)

# 5. Add Annotation to explain the math
text(0.75, 0.5, adj = 0, labels = paste(
    "Rule:\nP(A \u2229 B) = P(B) \u00D7 P(A|B)\n\n",
    "Calculation:\n", p_b, " \u00D7 ", p_a_given_b, " = ", p_a_and_b
))
