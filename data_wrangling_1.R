rawData <- read.table('refine_original.csv', header = TRUE, sep = ",")
rawData_df <- tbl_df(rawData)

## Part 1: Standardize company names
rawData_df$company[grepl("ph", rawData_df$company)] <- "phillips"
rawData_df$company[grepl("f", rawData_df$company)] <- "phillips"
rawData_df$company[grepl("z", rawData_df$company)] <- "akzo"
rawData_df$company[grepl("ou", rawData_df$company)] <- "van Houten"
rawData_df$company[grepl("ver", rawData_df$company)] <- "unilever"
rawData_df$company[grepl("Z", rawData_df$company)] <- "akzo"

## Part 2: Add product categories
library(tidyr)
refine <- rawData_df %>% 
  separate(Product.code...number, c("product_code", "product_number"), sep = "-")
View(refine)
refine <- mutate(refine, product_category = product_code)
refine$product_category[grepl("p", refine$product_code)] <- "Smartphone"
refine$product_category[grepl("v", refine$product_code)] <- "TV"
refine$product_category[grepl("x", refine$product_code)] <- "Laptop"
refine$product_category[grepl("q", refine$product_code)] <- "Tablet"

##Part 3: Add geocoding
refine <- refine %>% unite(full_address, address, city, country, sep = ',')

##Part 4: Create dummy variables for company and product category
refine <- transform(refine, company_phillips = ifelse(refine$company=="phillips",1,0))
refine <- transform(refine, company_akzo = ifelse(refine$company=="akzo",1,0))
refine <- transform(refine, company_van_houten = ifelse(refine$company=="van houten",1,0))
refine <- transform(refine, company_unilever = ifelse(refine$company=="unilever",1,0))
refine <- transform(refine, product_smartphone = ifelse(refine$product_category=="Smartphone",1,0))
refine <- transform(refine, product_tv = ifelse(refine$product_category=="TV",1,0))
refine <- transform(refine, product_laptop = ifelse(refine$product_category=="Laptop",1,0))
refine <- transform(refine, product_tablet = ifelse(refine$product_category=="Tablet",1,0))




