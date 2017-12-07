library(TriMatch)
library(ggplot2)
library(party)

data("tutoring")

str(tutoring)
nrow(tutoring)

tutoring$treat2 <- tutoring$treat != 'Control'

lr.out <- glm(treat2 ~ Gender + Ethnicity + Military + ESL + EdMother + EdFather + Age + Income + GPA +
			           Gender * Age,
			  data = tutoring,
			  family = binomial(link = 'logit'))

summary(lr.out)

ctree.out <- ctree(treat2 ~ Gender + Ethnicity + Military + ESL + EdMother + EdFather + Age + Income + GPA,
			  data = tutoring)
plot(ctree.out)

tutoring$predicted.values <- fitted(lr.out)

hist(tutoring$predicted.values)

ggplot(tutoring, aes(x = Age, y = predicted.values)) + geom_point()

median(tutoring$predicted.values)

tutoring$predict.treat <- tutoring$predicted.values > median(tutoring$predicted.values)

table(tutoring$treat2, tutoring$predict.treat)
prop.table(table(tutoring$treat2, tutoring$predict.treat))
