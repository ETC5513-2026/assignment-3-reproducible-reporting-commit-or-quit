library(tidyverse)

energy_analysis <- read_csv(
  "data/energy_analysis.csv"
)

summary_2019 <- energy_analysis %>%
  filter(year == 2019) %>%
  select(
    entity,
    renewable_energy_share_in_the_total_final_energy_consumption_percent,
    value_co2_emissions_kt_by_country
  )

write_csv(
  summary_2019,
  "Data/summary_2019.csv"
)