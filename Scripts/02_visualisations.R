library(tidyverse)

energy_analysis <- read_csv(
  "Data/energy_analysis.csv"
)

#  renewable energy trend

renewable_plot <- ggplot(
  energy_analysis,
  aes(
    x = year,
    y = renewable_energy_share_in_the_total_final_energy_consumption_percent,
    color = entity
  )
) +
  geom_line(size = 1.2) +
  labs(
    title = "Renewable Energy Adoption Trends in Selected Economies (2000–2020)",
    x = "Year",
    y = "Renewable Energy Share (%)",
    color = "Country"
  ) +
  theme_minimal()

renewable_plot

# save plot
ggsave(
  "figures/renewable_trend.png",
  plot = renewable_plot,
  width = 8,
  height = 5
)

# co2 emission trend

co2_plot <- ggplot(
  energy_analysis,
  aes(
    x = year,
    y = value_co2_emissions_kt_by_country,
    color = entity
  )
) +
  geom_line(size = 1.2) +
  labs(
    title = "CO₂ Emissions Trends in Selected Economies (2000–2020)",
    x = "Year",
    y = "CO₂ Emissions (kt)",
    color = "Country"
  ) +
  theme_minimal()

ggsave(
  "Figures/co2_trend.png",
  width = 8,
  height = 5
)