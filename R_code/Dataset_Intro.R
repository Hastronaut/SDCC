# Step 1: Importing necessary libraries
library(readxl) 
library(VIM) 
library(ggplot2) 

# Step 2: Reading the Excel file and data manipulation
file_path <- './Bigdata/data_new.xlsx' 
df <- read_excel(file_path)

# Dropping specific columns
df <- df[ , !(names(df) %in% c('Unnamed: 0', 'PATIENT_ID'))]

# Identifying binary and numeric columns
binary_cols <- names(df)[sapply(df, function(x) length(unique(x)) == 2)]
numeric_cols <- names(df)[sapply(df, function(x) length(unique(x)) != 2)]
# KNN Imputation (assuming k=5)
df_complete_knn <- kNN(df, k = 5)


file_path <- './Bigdata/figure/balance.pdf'
if (!dir.exists(dirname(file_path))) {
  dir.create(dirname(file_path), recursive = TRUE)
}

# 柱状图和饼图
res_columns <- c('癌', '癌前病变', '良性疾病', '健康或非结肠疾病')
df_count <- df[res_columns]
names(df_count) <- c("cancer", "precancerous", "benign disease", "healthy")

counts <- colSums(df_count)
par(mfrow = c(1, 2))
barplot(counts, main = "Bar Plot")
pie(counts, main = "Pie Chart")
