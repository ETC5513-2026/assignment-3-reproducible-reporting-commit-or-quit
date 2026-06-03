# Load required libraries
library(tidyverse)
library(janitor)
library(skimr)

# Read dataset
energy <- read_csv("Data/global-data-on-sustainable-energy.csv")

# Clean column names
energy <- clean_names(energy)

# Filter selected countries
major_countries <- c(
  "United States",
  "China",
  "India",
  "Australia"
)


# Select variables for analysis
energy_major <- energy %>%
  filter(entity %in% major_countries)


energy_analysis <- energy_major %>%
  select(
    entity,
    year,
    renewable_energy_share_in_the_total_final_energy_consumption_percent,
    value_co2_emissions_kt_by_country
  )

# Check missing values
colSums(is.na(energy_analysis))


# Export cleaned dataset
write_csv(
  energy_analysis,
  "Data/energy_analysis.csv"
)