library(openintro)
library(ggplot2)

data(heartTr)
table(heartTr$survived)
table(heartTr$transplant)
table(heartTr$survived, heartTr$transplant)
prop.table(table(heartTr$survived, heartTr$transplant))


# We write alive on **28** cards representing patients who were alive at the end of the study, and 
# dead on **75** cards representing patients who were not. Then, we shuffle these cards and split 
# them into two groups: one group of size **69** representing treatment, and another group of size
# **34** representing control. We calculate the difference between the proportion of dead cards in 
# the treatment and control groups (treatment - control) and record this value. We repeat this 
# 100 times to build a  distribution centered at **0**. Lastly, we calculate the fraction of 
# simulations where the simulated differences in proportions are **.23 or higher**. If this fraction
# is low, we conclude that it is unlikely to have observed such an outcome by chance and that the 
# null hypothesis should be rejected in favor of the alternative.

n.alive <- 28
n.dead <- 75
n.treat <- 69
n.control <- 34
n.samples <- 100

# Verify these are the same
n.alive + n.dead
n.treat + n.control

cards <- c(rep('alive', n.alive), rep('dead', n.dead))
cards
length(cards)

set.seed(2112) # To reproduce exact results

simulation <- data.frame()
for(i in seq_len(n.samples)) {
	test <- data.frame(survived = cards, transplant = 'control', stringsAsFactors = FALSE)
	test[sample(nrow(test), n.treat),]$transplant <- 'treat'
	# prop.table(table(test$survived, test$transplant))
	simulation <- rbind(simulation, data.frame(
		iter = i,
		TreatAndAlive = sum(test$survived == 'alive' & test$transplant == 'treat') / nrow(test),
		stringsAsFactors = FALSE
	))
}

ggplot(simulation, aes(x = TreatAndAlive, fill = (TreatAndAlive > 0.23))) + geom_histogram()

# Proportion of the samples where treatment and alive was greater than 0.23
sum(simulation$TreatAndAlive >= 0.23) / nrow(simulation)

