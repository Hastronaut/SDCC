library(tidyverse)
library(kknn)


library(readxl)
file_path <- "./Bigdata/unscaled_data.xlsx"
df <- read_excel(file_path)

df <- df %>% select(-c('Unnamed: 0', 'PATIENT_ID'))

binary_cols <- names(df)[sapply(df, function(x) length(unique(x)) == 2)]
numeric_cols <- setdiff(names(df), binary_cols)
df_complete_knn <- kknn::impute.kknn(formula = ~., data = df, k = 5)
df <- as.data.frame(df_complete_knn)
for (col in binary_cols) {
  df[[col]] <- ifelse(df[[col]] > 0.3, 1, ifelse(df[[col]] < 0.3, 0, df[[col]]))
}

df$y <- ifelse(df$癌 == 1 | df$癌前病变 == 1, 1, 0)
df <- df %>% select(-c('癌', '癌前病变', '良性疾病', '健康或非结肠疾病'))
