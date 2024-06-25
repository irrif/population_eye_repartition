# population_eye_repartition

## Overview
This agent-based modelling project aims to model the distribution of eye colors in a population over multiple generations using the NetLogo platform. By incorporating various parameters such as the initial proportion of each eye color and the average number of children per family, this simulation provides insights into how these factors influence the genetic inheritance and prevalence of different eye colors over time.

## Objectives
* Simulate Genetic Inheritance: To accurately replicate the process of genetic inheritance as it pertains to eye color, taking into account dominant and recessive alleles.
* Analyze Population Dynamics: To understand how initial conditions and generational changes affect the distribution of eye colors in a given population.
* Explore Parameters Influence: To investigate the impact of various parameters, including initial eye color proportions and the number of children per generation, on the long-term trends in eye color distribution.

## Key Features
* Initial Proportion Setup: Users can define the initial distribution of eye colors (e.g., blue, brown, green) within the population. This setup influences the starting point of the simulation.
* Generational Modeling: The simulation progresses through multiple generations, with each generation's eye color distribution calculated based on genetic inheritance rules.
* Reproductive Parameters: The model allows adjustment of the average number of children per family, affecting the rate at which the population evolves.
* Genetic Rules Implementation: Incorporates Mendelian inheritance principles to determine eye color in offspring, considering dominant and recessive traits.
* Data Visualization: Provides real-time visual representation of the population's eye color distribution, including charts and graphs to track changes over generations.
* User Interactivity: Users can modify parameters dynamically and observe the immediate effects on the population, enabling interactive experimentation and learning.

## Methodology
* Initialization: Define the initial population size and the proportion of each eye color.
* Simulation Loop: For each generation:
* Mating Process: Randomly pair individuals to simulate mating.
* Inheritance Calculation: Use genetic rules to determine the eye color of offspring.
* Population Update: Update the population with the new generation's individuals.
* Data Collection: Collect and store data on the eye color distribution for each generation.
* Visualization: Display the evolving distribution through graphs and charts.

## Future Enhancements
* Expanded Genetic Traits: Incorporate additional genetic traits beyond eye color.
* Environmental Factors: Include environmental influences on population dynamics.
* Complex Inheritance Patterns: Model more complex inheritance patterns, including polygenic traits and mutations.
