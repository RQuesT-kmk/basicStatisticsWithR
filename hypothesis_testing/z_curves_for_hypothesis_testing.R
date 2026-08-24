
z_curves <- function(alpha = 0.05, two_sided = c("less","equal","greater")) {
  require(ggplot2)
  alphaZ <- alpha
  if(length(two_sided) > 1) {
    two_sided <- "equal"
  } else two_sided <- two_sided
  x_vals <- seq(-4, 4, length.out = 1000)
  normal_df <- data.frame(x = x_vals, y = dnorm(x_vals))
  if(two_sided == "equal") {
    critical <- qnorm(1 - alphaZ/2)
    
    ggplot(data = normal_df, aes(x = x, y = y))+
      geom_area(data = subset(normal_df, x <= -critical), fill = "lightgreen", alpha = 0.5)+
      geom_area(data = subset(normal_df, x >= critical), fill = "lightgreen", alpha = 0.5)+
      geom_area(data = subset(normal_df, x >= -critical & x <= critical), fill = "lightcoral",alpha = 0.5)+
      geom_line(linewidth =1, color = "black")+
      geom_vline(xintercept = c(-critical, critical), linetype = "dashed", color = "firebrick", linewidth = 0.9)+
      scale_x_continuous(breaks = c(-4,-3,-2,-1,0,1,2,3,4), name = "Z score")+
      labs(title = "Standard normal (Z) distribution curve",
           subtitle = paste0("Two-sided test at alpha = ", alphaZ, "(Critical value: ±",round(critical,2), ")"),
           y = "Density")+
      theme_minimal()+
      theme(axis.text.y = element_blank(),
            axis.ticks = element_blank())
    
  } else if(two_sided == "less") {
    critical <- qnorm(1- alphaZ)
    
    ggplot(data = normal_df, aes(x = x, y = y))+
      geom_area(data = subset(normal_df, x <= -critical), fill = "lightgreen", alpha = 0.5)+
      geom_area(data = subset(normal_df, x >= -critical), fill = "lightcoral",alpha = 0.5)+
      geom_line(linewidth =1, color = "black")+
      geom_vline(xintercept = c(-critical), linetype = "dashed", color = "firebrick", linewidth = 0.9)+
      scale_x_continuous(breaks = c(-4,-3,-2,-1,0,1,2,3,4), name = "Z score")+
      labs(title = "Standard normal (Z) distribution curve",
           subtitle = paste0("One-sided test at alpha = ", alphaZ, "(Critical value: -",round(critical,2), ")"),
           y = "Density")+
      theme_minimal()+
      theme(axis.text.y = element_blank(),
            axis.ticks = element_blank())
  } else if(two_sided == "greater") {
    critical <- qnorm(1- alphaZ)
    
    ggplot(data = normal_df, aes(x = x, y = y))+
      geom_area(data = subset(normal_df, x >= critical), fill = "lightgreen", alpha = 0.5)+
      geom_area(data = subset(normal_df,  x <= critical), fill = "lightcoral",alpha = 0.5)+
      geom_line(linewidth =1, color = "black")+
      geom_vline(xintercept = c(critical), linetype = "dashed", color = "firebrick", linewidth = 0.9)+
      scale_x_continuous(breaks = c(-4,-3,-2,-1,0,1,2,3,4), name = "Z scores")+
      labs(title = "Standard normal (Z) distribution curve",
           subtitle = paste0("One-sided test at alpha = ", alphaZ, "(Critical value: ",round(critical,2), ")"),
           y = "Density")+
      theme_minimal()+
      theme(axis.text.y = element_blank(),
            axis.ticks = element_blank())
  } else print("Try again with correct arguments")
  
}
