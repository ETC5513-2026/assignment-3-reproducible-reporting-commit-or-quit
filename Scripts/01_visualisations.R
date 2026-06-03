library(tidyverse)
library(ggrepel)

#Plot 1
summary_2019 <- read_csv("data/summary_2019.csv")
p <- ggplot(summary_2019, aes(
  x = renewable_energy_share_in_the_total_final_energy_consumption_percent,
  y = value_co2_emissions_kt_by_country,
  colour = entity
)) +
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

#Save plot
ggsave(
  filename = "figures/scatter_2019.png",
  plot = p,
  width = 8,
  height = 5
)


#Plot2
summary_2019_long <- summary_2019 |>
  pivot_longer(
    cols = c(
      renewable_energy_share_in_the_total_final_energy_consumption_percent,
      value_co2_emissions_kt_by_country
    ),
    names_to = "metric",
    values_to = "value"
  ) |>
  mutate(metric = recode(metric,
    "renewable_energy_share_in_the_total_final_energy_consumption_percent" = "Renewable Energy Share (%)",
    "value_co2_emissions_kt_by_country" = "CO₂ Emissions (kt)"
  ))

p2 <- ggplot(summary_2019_long, aes(
  x = entity,
  y = value,
  fill = entity
)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ metric, scales = "free_y") +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Country", y = "") +
  theme_minimal()

ggsave(
  filename = "figures/facet_2019.png",
  plot = p2,
  width = 10,
  height = 5
)