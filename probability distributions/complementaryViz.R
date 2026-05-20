# 1. Define the probability of Event A
p_a <- 0.3
p_not_a <- 1 - p_a

# 2. Setup the plot area (Sample Space S)
plot(c(0, 1), c(0, 1), type = "n", 
     main = expression(paste("Complementary Rule: ", P(bar(A)) == 1 - P(A))),
     xlab = "Total Probability Area = 1", ylab = "", 
     xaxt = 'n', yaxt = 'n', asp = 1)

# 3. Draw Event A (The left region)
rect(0, 0, p_a, 1, col = "steelblue", border = "black", lwd = 2)
text(p_a/2, 0.5, "A", col = "white", cex = 2, font = 2)

# 4. Draw Not A (The right region)
rect(p_a, 0, 1, 1, col = "lightgray", border = "black", lwd = 2)
text(p_a + (1 - p_a)/2, 0.5, expression(bar(A)), col = "black", cex = 2, font = 2)

# 5. Add a Legend for the mathematical values
legend("bottom", inset = -0.15, xpd = TRUE, horiz = TRUE, bty = "n",
       legend = c(paste("P(A) =", p_a), 
                  paste("P(not A) =", p_not_a)))
