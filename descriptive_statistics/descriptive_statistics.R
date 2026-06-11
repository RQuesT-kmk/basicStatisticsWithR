
# About -------------------------------------------------------------------

# Title: Descriptive Statistics 
# Author : Kaung Myat Khant
# Data : diamonds from ggplot2
# Description : We will do descriptive summary of depth of diamonds



# Library -----------------------------------------------------------------

pacman::p_load(dplyr,
               ggplot2,
               patchwork)

# Data --------------------------------------------------------------------

df <- diamonds
glimpse(df)

# Order array -------------------------------------------------------------

array1 <- sort(df$depth) ; head(array1,30) # base 
# gives a vector

array2 <- df |> select(depth) |> arrange() ; slice_tail(array2,n = 30) |> pull() # dplyr 
# gives a column of a table (tibble)

# Frequency distribution --------------------------------------------------

## Sturges’s Rule

#### Number of observation
n <- length(df$depth) ; n

#### Number of class intervals
k <- 1 + 3.322*log10(n) ; k

#### Range
range(df$depth)

R <- max(df$depth) - min(df$depth)

#### Width of interval
w <- R/k; w

#### Interval by base R
breaks <- seq(from = 43, to = 79, by = 2); bre
df$depth_group1 <- cut(df$depth, 
                       breaks = breaks, 
                       right = FALSE,# upper limit(right value of seq) not included
                       include.lowest = TRUE,# values exactly equal break values included
                       ordered_result = TRUE) # ordinal scale
table(df$depth_group1)

#### Convenient limit -> we choose interval of 5
width <- 5

# Apply the transformation using dplyr
df <- df %>%
    mutate(
        # 1. Dynamically find the lower and upper limits
        lower_limit = floor(min(depth) / width) * width,
        upper_limit = ceiling(max(depth) / width) * width,
        
        # 2. Cut the depth variable using the dynamically generated sequence
        depth_group2 = cut(depth, 
                           # first() is to pull the first value which is repeated lower limit
                          breaks = seq(first(lower_limit), first(upper_limit), by = width), 
                          right = FALSE, 
                          include.lowest = TRUE)
    ) %>% 
    # 3. Optional: Remove the helper limit columns to keep the dataset clean
    select(-lower_limit, -upper_limit)

# Verify the results
df %>% 
    count(depth_group2)

## Using bin number instead of bin width

bin <- seq(from = 43, to =79, length.out = 6)

floor(bin) ; ceiling(bin)

df |> 
    mutate(
        depth_group3 = case_when(
            depth >= 43 & depth < 51 ~ "43-50",
            depth >= 51 & depth <58 ~ "51-57",
            depth >= 58 & depth < 65 ~ "58-64",
            depth >= 65 & depth < 72 ~"65-71",
            depth >= 72 & depth <= 79 ~ "72-79",
            .ptype = factor(levels = c("43-50","51-57","58-64","65-71","72-79"),
                            ordered = T)
        )
    ) |> 
    count(depth_group3)



# Histogram ---------------------------------------------------------------

Stu <- ggplot(df)+
    geom_histogram(aes(x = depth),
                   binwidth = 2, fill = "brown4")+
    labs(title = "Sturges's rule")+
    theme_bw()
Stu

CL <- ggplot(df)+
    geom_histogram(aes(x = depth),
                   binwidth = 5, fill = "maroon4")+
    labs(title = "Convenient limit")+
    theme_bw()
CL

binNum <- ggplot(df)+
    geom_histogram(aes(x = depth),
                   bins = 16, fill = "navy")+
    labs(title = "Bin number")+
    theme_bw()
binNum

Stu + CL + binNum + plot_layout(ncol = 3)


# Boxplot -----------------------------------------------------------------

ggplot(df) + geom_boxplot(aes(x = depth))

ggplot(df) + 
    geom_boxplot(aes(x = depth), outliers = F) +
    annotate(geom = "text", 
             x = median(df$depth), y = 0, 
             vjust = -1,
             label = "Median", angle = 90)+
    annotate(geom = "text", 
             x = quantile(df$depth,.25), y = 0.2, 
             vjust = -1,
             label = "Q1", angle = 90)+
    annotate(geom = "text", 
             x = quantile(df$depth,.75), y = 0.2, 
             vjust = 1,
             label = "Q3", angle = 90)


# Stem and leaf -----------------------------------------------------------

stem(df$depth)

# Measures of Central tendency --------------------------------------------

## Means  

#### Arithmetic means

mean(df$depth, na.rm = T) 


#### Median

median(df$depth, na.rm = T)

#### Geometric mean

mean(df$price, na.rm = T) # Arithmetic mean is sensitive to skewness and outlier
median(df$price, na.rm = T) # Robust location (centre)

u <- mean(log(df$price), na.rm = T)
exp(u) #Geometric mean is less sensitive to positive skewness


#### Weighted mean

weighted.mean(x = df$price, w = df$carat, na.rm = T) #Average price per carat
sum((df$price*df$carat)/sum(df$carat))


# Measures of spread ------------------------------------------------------

#### Variance

s2 <- var(df$depth) ; s2

# sum((mean(df$depth) - df$depth)^2)/(lenght(df$depth)-1)

#### Standard deviation
s <- sd(df$depth) ; s
# sqrt(s2)

#### Inter quartile range
iqr <- IQR(df$depth) ; iqr

IQR_hinge <- quantile(df$depth,c(0.25,0.75)); IQR_hinge

IDR_hinge <- quantile(df$depth, c(0.1,0.9)); IDR_hinge #(Inter decile range)

#### Range
range(df$depth) ; min(df$depth); max(df$depth)

#### Coefficient of variation (CV)

cv_depth <- round(100*sd(df$depth)/mean(df$depth),2)
cv_carat <- round(100*sd(df$carat)/mean(df$carat),2)
cv_depth ; cv_carat

# Five number summary -----------------------------------------------------

summary(df$depth)


# Outlier -----------------------------------------------------------------

#Rule is beyond 1.5*IQR above or below the hinge

q1 <- quantile(df$depth, 0.25)
q3 <- quantile(df$depth, 0.75)
iqr_value <- IQR(df$depth)

lower_bound <- q1 - (1.5 * iqr_value)
upper_bound <- q3 + (1.5 * iqr_value)

summary(df$depth)
lower_bound
upper_bound
stem(df$depth)


#### Trimmed means

trim <- df[df$depth < quantile(df$depth,0.8) & df$depth > quantile(df$depth,0.2),"depth"]
mean(trim$depth)
stem(trim$depth)


# dplyr pipeline ----------------------------------------------------------

df |> 
    summarise(Mean = mean(depth),
             SD = sd(depth),
              Median = median(depth),
              Q1 = quantile(depth,0.25),
              Q3 = quantile(depth,0.75),
              IQR = IQR(depth),
              Min = min(depth),
              Max = max(depth),
              D1 = quantile(depth,0.1),
              D9 = quantile(depth,0.9)) |> 
    tidyr::pivot_longer(cols = everything(),
                        names_to  = "Measures",
                        values_to = "Depth")

df |> count(cut)
