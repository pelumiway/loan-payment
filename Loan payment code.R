# Load required libraries
install.packages("fairness")
library(fairness)
library(caret)
library(ggplot2)
library(lattice)
# Load loan approval dataset
LoanData<-Loan.payments.data

# Split data into training and test sets
set.seed(123)
index <- createDataPartition(LoanData$loan_status, p = 0.7, list = FALSE)
train_data <- LoanData[index, ]
test_data <- LoanData[-index, ]

# Train a logistic regression model
model <- glm(loan_status ~ ., data = train_data, family = binomial())

# Calculate demographic parity for gender
dem_parity <- demographic_parity_difference(train_data$Loan_Status, predict(model, newdata = train_data), train_data$Gender)

# Print demographic parity
cat("Demographic parity for gender: ", dem_parity, "\n")
