# Thompson Sampling in R

## Importing the dataset
dataset <- read.csv("Ads_CTR_Optimisation.csv")

## Importing the Random Selection
N <- 10000 # nolint
d <- 10
ads_selected <- integer(0)
nums_of_rewards_1 <- integer(d)
nums_of_rewards_0 <- integer(d)
total_reward <- 0

for (n in 1:N) {
    ad <- 0
    max_random <- 0
    for (i in 1:d) {
       random_beta <- rbeta(n = 1, shape1 = nums_of_rewards_1[i] + 1, shape2 = nums_of_rewards_0[i] + 1) # nolint
       if (random_beta > max_random) {
            max_random <- random_beta
            ad <- i
       }
    }
    ads_selected <- append(ads_selected, ad)
    reward <- dataset[n, ad]
    if (reward == 1) {
       nums_of_rewards_1[ad] <- nums_of_rewards_1[ad] + 1
    } else {
       nums_of_rewards_0[ad] <- nums_of_rewards_0[ad] + 1
    }
    total_reward <- total_reward + reward
}

## Visualising the results - Histogram
hist(ads_selected,
     col = "blue",
     main = "Histogram of Ads Selections",
     xlab = "Ads",
     ylab = "Number of times each ad was selected")