library(manipulate)


# Addition rule -----------------------------------------------------------


manipulate(
    {
        # Enforce logical consistency: intersection cannot be larger than P(A) or P(B)
        p_intersect <- min(p_overlap, p_a, p_b)
        p_union <- p_a + p_b - p_intersect
        
        # Initialize a blank canvas (Sample Space = 1)
        plot(c(0, 1), c(0, 1), type = "n", xaxt = 'n', yaxt = 'n',
             main = "Addition Rule: P(A \u222a B) = P(A) + P(B) - P(A \u2229 B)",
             xlab = paste("Total Union Area P(A \u222a B) =", round(p_union, 2)), ylab = "")
        
        # Draw Event A (Left anchored rectangle)
        rect(0, 0.4, p_a, 0.8, col = rgb(0.2, 0.4, 0.8, 0.4), border = "blue", lwd = 2)
        text(p_a / 2, 0.6, "Event A", col = "blue", font = 2)
        
        # Draw Event B (Right side rectangle shifted left based on overlap)
        b_start <- p_a - p_intersect
        b_end <- b_start + p_b
        rect(b_start, 0.2, b_end, 0.6, col = rgb(0.9, 0.2, 0.2, 0.4), border = "red", lwd = 2)
        text(b_start + (p_b / 2), 0.4, "Event B", col = "red", font = 2)
        
        # Highlight Intersection
        if (p_intersect > 0) {
            rect(b_start, 0.4, p_a, 0.6, col = rgb(0.5, 0.1, 0.5, 0.6), border = "purple", lwd = 2)
            text((b_start + p_a) / 2, 0.5, expression(A %intersect% B), col = "purple4", font = 2)
        }
    },
    p_a = slider(0.1, 0.6, initial = 0.4, step = 0.05, label = "P(A) Area"),
    p_b = slider(0.1, 0.6, initial = 0.4, step = 0.05, label = "P(B) Area"),
    p_overlap = slider(0, 0.4, initial = 0.1, step = 0.05, label = "Intersection Area")
)



# Multiplication rule -----------------------------------------------------

library(manipulate)

manipulate(
    {
        # Calculate the joint probability area
        p_intersection <- p_b * p_a_given_b
        
        plot(c(0, 1), c(0, 1), type = "n", xaxt = 'n', yaxt = 'n',
             main = "Multiplication Rule: P(A \u2229 B) = P(B) \u00D7 P(A|B)",
             xlab = paste("Calculated Joint Probability P(A \u2229 B) =", round(p_intersection, 3)), ylab = "")
        
        # Draw total population baseline space of Event B
        rect(0, 0, p_b, 1, col = rgb(0.2, 0.6, 0.8, 0.2), border = "darkblue", lwd = 2)
        text(p_b / 2, 0.9, "Event B (Given Base)", col = "darkblue", font = 2)
        
        # Draw the conditional portion of A that cuts into B
        rect(0, 0, p_b, p_a_given_b, col = rgb(0.9, 0.4, 0.1, 0.5), border = "darkorange", lwd = 3)
        text(p_b / 2, p_a_given_b / 2, expression(P(A %intersect% B)), col = "darkorange4", font = 2)
    },
    p_b = slider(0.2, 0.9, initial = 0.6, step = 0.05, label = "Base Probability P(B)"),
    p_a_given_b = slider(0.1, 1.0, initial = 0.5, step = 0.05, label = "Conditional Probability P(A|B)")
)


# Conditional probability -------------------------------------------------

library(manipulate)

manipulate(
    {
        # 1. Calculate the dependent joint probabilities
        p_a_and_b    <- p_b * p_a_given_b          # P(A intersect B)
        p_not_a_and_b <- p_b * (1 - p_a_given_b)    # P(not A intersect B)
        
        # For demonstration, we'll keep Event A independent of Not B to isolate the visual change
        p_a_given_not_b <- 0.4
        p_a_and_not_b    <- (1 - p_b) * p_a_given_not_b
        p_not_a_and_not_b <- (1 - p_b) * (1 - p_a_given_not_b)
        
        # 2. Structure the data into a 2x2 matrix for the mosaic plot
        prob_matrix <- matrix(
            c(p_a_and_b, p_not_a_and_b, p_a_and_not_b, p_not_a_and_not_b),
            nrow = 2,
            byrow = FALSE
        )
        
        # Name the dimensions for clear plot labels
        rownames(prob_matrix) <- c("A", "not A")
        colnames(prob_matrix) <- c("B", "not B")
        
        # 3. Clear and draw the interactive Mosaic Plot
        mosaicplot(t(prob_matrix), # Transposed to split by the conditional baseline (B) first
                   col = c("steelblue", "lightgray"),
                   main = "Conditional Probability via Mosaic Plot",
                   xlab = "Marginal Probability: P(B)",
                   ylab = "Conditional Probability: P(A | B)",
                   cex.axis = 1.2)
        
        # 4. Add dynamic math documentation directly onto the plot canvas
        mtext(paste("Joint P(A \u2229 B) =", round(p_a_and_b, 2), 
                    " | Marginal P(B) =", round(p_b, 2), 
                    " | Conditional P(A|B) =", round(p_a_given_b, 2)), 
              side = 3, line = 0.5, col = "darkblue", font = 2)
    },
    # Slider controls restricted between logical probability bounds (0 to 1)
    p_b = slider(0.1, 0.9, initial = 0.6, step = 0.05, label = "Marginal Width: P(B)"),
    p_a_given_b = slider(0.05, 0.95, initial = 0.5, step = 0.05, label = "Conditional Height: P(A | B)")
)


# Independent event -------------------------------------------------------

library(manipulate)

manipulate(
    {
        p_intersection <- p_a * p_b
        
        plot(c(0, 1), c(0, 1), type = "n", asp = 1, xlab = "P(A) Width", ylab = "P(B) Height",
             main = expression(paste("Independent Events: ", P(A %intersect% B) == P(A) %*% P(B))))
        
        # Vertical block for Event A
        rect(0, 0, p_a, 1, col = rgb(0, 0, 1, 0.15), border = "blue", lty = 2)
        
        # Horizontal block for Event B
        rect(0, 0, 1, p_b, col = rgb(1, 0.8, 0, 0.2), border = "orange", lty = 2)
        
        # Intersection block (Perfect mathematical product rectangle)
        rect(0, 0, p_a, p_b, col = rgb(0, 0.7, 0.3, 0.5), border = "darkgreen", lwd = 3)
        text(p_a / 2, p_b / 2, paste("Area =\n", round(p_intersection, 3)), col = "darkgreen", font = 2)
    },
    p_a = slider(0.1, 0.9, initial = 0.5, step = 0.05, label = "Width P(A)"),
    p_b = slider(0.1, 0.9, initial = 0.5, step = 0.05, label = "Height P(B)")
)




