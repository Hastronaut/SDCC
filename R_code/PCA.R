# Step 1: Importing necessary libraries
library(readxl)
library(factoextra) 
library(factominer) 

# Step 2: Reading the Excel file
file_path <- './Bigdata/data_new.xlsx' 
df <- read_excel(file_path)

# Step 3: Selecting specific columns as independent variables
indf <- df[, -c(55:59)]

# Step 4: Performing PCA with 50 principal components
pca_result <- PCA(indf, ncp = 50, scale.unit = TRUE) 

# Step 5: Calculating and printing the variance ratio of each principal component
explained_var_ratio <- pca_result$eig[, 2] / sum(pca_result$eig[, 2])

# Print the explained variance ratio
print("Explained variance ratio of each principal component:")
print(explained_var_ratio)

# Step 6: Plotting the cumulative explained variance
cumulative_var_ratio <- cumsum(explained_var_ratio)

# Plot
plot(cumulative_var_ratio, xlab = "Number of Principal Components", ylab = "Cumulative Explained Variance",
     type = "b", pch = 19, col = "blue")


