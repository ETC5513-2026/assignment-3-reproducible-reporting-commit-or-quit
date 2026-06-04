library(tidyverse)
library(ggrepel)

# Load Data

energy_analysis <- read_csv(
  "Data/energy_analysis.csv"
)

summary_2019 <- read_csv(
  "Data/summary_2019.csv"
)

# Renewable Energy Trend Plot

renewable_plot <- ggplot(
  energy_analysis,
  aes(
    x = year,
    y = renewable_energy_share_in_the_total_final_energy_consumption_percent,
    color = entity
  )
) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "Renewable Energy Adoption Trends in Selected Economies (2000–2020)",
    x = "Year",
    y = "Renewable Energy Share (%)",
    color = "Country"
  ) +
  theme_minimal()

ggsave(
  filename = "Figures/renewable_trend.png",
  plot = renewable_plot,
  width = 8,
  height = 5
)

# CO2 Emissions Trend Plot

co2_plot <- ggplot(
  energy_analysis,
  aes(
    x = year,
    y = value_co2_emissions_kt_by_country,
    color = entity
  )
) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "CO₂ Emissions Trends in Selected Economies (2000–2020)",
    x = "Year",
    y = "CO₂ Emissions (kt)",
    color = "Country"
  ) +
  theme_minimal()

ggsave(
  filename = "Figures/co2_trend.png",
  plot = co2_plot,
  width = 8,
  height = 5
)

# Renewable Energy vs CO2 Scatter Plot

scatter_plot <- ggplot(
  summary_2019,
  aes(
    x = renewable_energy_share_in_the_total_final_energy_consumption_percent,
    y = value_co2_emissions_kt_by_country,
    colour = entity
  )
) +
  geom_point(size = 4) +
  geom_text_repel(
    aes(label = entity),
    size = 3.5,
    show.legend = FALSE,
    box.padding = 0.5
  ) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Renewable Energy Share (%)",
    y = "CO₂ Emissions (kt)",
    colour = "Country"
  ) +
  theme_minimal()

ggsave(
  filename = "Figures/scatter_2019.png",
  plot = scatter_plot,
  width = 8,
  height = 5
)

# 2019 Country Comparison Plot

summary_2019_long <- summary_2019 %>%
  pivot_longer(
    cols = c(
      renewable_energy_share_in_the_total_final_energy_consumption_percent,
      value_co2_emissions_kt_by_country
    ),
    names_to = "metric",
    values_to = "value"
  ) %>%
  mutate(
    metric = recode(
      metric,
      "renewable_energy_share_in_the_total_final_energy_consumption_percent" =
        "Renewable Energy Share (%)",
      "value_co2_emissions_kt_by_country" =
        "CO₂ Emissions (kt)"
    )
  )

facet_plot <- ggplot(
  summary_2019_long,
  aes(
    x = entity,
    y = value,
    fill = entity
  )
) +
  geom_col(show.legend = FALSE) +
  facet_wrap(
    ~ metric,
    scales = "free_y"
  ) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Country",
    y = NULL
  ) +
  theme_minimal()

ggsave(
  filename = "Figures/facet_2019.png",
  plot = facet_plot,
  width = 10,
  height = 5
)