getwd()
setwd("C:/Users/rober/Documents")
getwd()


refine <- read.csv(file.choose())
refine




library(tidyr)
library(dplyr)


#1.  Clean up brand names
#    Standardizing the  spelling of company names as ???philips???, ???akzo???, ???van houten??? and ???unilever"


refine$company <- gsub(pattern = "Phillips|phillips|phllips|phillps|phillipS|fillips|phlips", replacement = "philips", x = refine$company)
refine$company <- gsub(pattern = "Van Houten", replacement = "van houten", x = refine$company)
refine$company <- gsub(pattern = "Unilever|unilver|unilever", replacement = "unilever", x = refine$company)

refine$company[refine$company=="Akzo"] <- "akzo"
refine$company[refine$company=="akz0"] <- "akzo"
refine$company[refine$company=="ak zo"] <- "akzo"
refine$company[refine$company=="AKZO"] <- "akzo"

refine


#2.  Separate product code and number
#    Split Product.code???number into product_code and product_number, respectively; add product_code and product_number to the dataframe

refine <- separate(refine, Product.code...number, c("product_code", "product_number"), sep = "-")

refine

#3.  Add product categories
#   Create the variables ???Smartphone???, ???TV???, ???Laptop??? and ???Tablet??? as equivalent to ???p???, ???v???, ???x??? and ???q??? in the product_code column

codes <- c("p" = "Smartphone", "v" = "TV", "x" = "Laptop", "q" = "Tablet")
refine$product_category <- codes[refine$product_code]

refine

#4.  Add full address for geocoding
#    Concatenate full_address with variables ???address???, ???city??? and ???country??? separated by commas then add full_address to the dataframe


refine <- unite(refine, "full_address", address, city, country, sep = ", ")

refine


#5.  Create dummy variables for company and product category

#   Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.


refine <- mutate(refine, company_philips = ifelse(company == "philips", 1, 0))
refine <- mutate(refine, company_akzo = ifelse(company == "akzo", 1, 0))
refine <- mutate(refine, company_van_houten = ifelse(company == "van houten", 1, 0))
refine <- mutate(refine, company_unilever = ifelse(company == "unilever", 1, 0))


refine

#   Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

refine <- mutate(refine, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
refine <- mutate(refine, product_tv = ifelse(product_category == "TV", 1, 0))
refine <- mutate(refine, product_laptop = ifelse(product_category == "Laptop", 1, 0))
refine <- mutate(refine, product_tablet = ifelse(product_category == "Tablet", 1, 0))


refine