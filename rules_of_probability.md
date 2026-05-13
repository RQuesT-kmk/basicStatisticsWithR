---
title: "Fundamental rules of Probability"
author: "Kaung Myat Khant"
output: 
    powerpoint_presentation:
        keep_md: TRUE
---

## Probability distributions follow the rules of probability

1.  Non-negativity

2.  Exhaustiveness

3.  Addition Rule

4.  Multiplication Rule

5.  Complementary Events

## Non-negativity

-   The probability of any event $E_i$ is assigned a non-negative number

$$P(E_i) \geq 0$$

## Exhaustiveness

-   The sum of the probabilities of all mutually exclusive outcomes is equal to 1

$$P(E_1)+ P(E_2)+ ... + P(E_n) = 1$$

## Addition Rule

-   for mutually exclusive events

    -   The probability of the occurrence of either of two mutually exclusive events is equal to the sum of their individual probabilities.

$$P(E_i + E_j) = P(E_i) + P(E_j)$$


## Addition Rule  

-   for non mutually exclusive events

    -   The probability that event A, or event B, or both occur is the sum of their probabilities minus the probability of their joint occurrence.

$$P(A \cup B) = P(A) + P(B) - P(A \cap B)$$

## Multiplication Rule  

-   Conditional Probability  

    -   The probability of A given B is the probability of the intersection of A and B divided by the probability of B  
    
$$P(A | B) = \frac{P(A \cap B)}{P(B)}$$


## Multiplication Rule 

-   Joint probability

    -   A joint probability is the product of a marginal probability and an appropriate conditional probability.  
    
$$P(A \cap B) = P(B) \cdot P(A | B)$$


## Multiplication Rule 

-   Independence  

    -   The probability that event A, or event B, or both occur is the sum of their probabilities minus the probability of their joint occurrence. 
    
$$P(A \cap B) = P(A) \cdot P(B)$$

## Complementary Events  

-   The probability of an event is 1 minus the probability of its complement.  

$$P(\bar{A}) = 1 - P(A)$$
