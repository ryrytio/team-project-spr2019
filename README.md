---
title: "README.md"
author: "Team Slackers"
date: "April 30, 2019"
output: html_document
---

# Domain of interest
1. We all love animals, and recall times when we were told X species would go extinct by Y time, so we were curious as to how animal endangerment has changed.
2.  * A tool created by Arizona State University that calculates costs and effects on different budget allocations for various conservation efforts.
    [https://shiny.sesync.org/apps/RecoveryExplorer/]
    * WildTrack, a division of SAS, is using AI to apply techniques used by indigenous trackers to at a larger scale and at a faster pace to assist with
    conservation efforts.
    [https://www.sas.com/en_us/explore/analytics-in-action/impact/wildtrack.html]
    * The Protection Assistant for Wildlife Security(PAWS) program that uses drones and AI that takes in crime data on poachers that allows for randomized
    patrol routes.
    [https://www.cais.usc.edu/projects/wildlife-security/]
3.  * How many species that were once considered endangered are no longer endangered?
    * How many species go extinct every year? 10 years?
    * Are there any species on a noticeable trend out of or further into endangerment?

# Finding Data 
### First Source: Organisation for Economic Co-Operation and Development 
1. I found the `Wild Life` dataset on the website https://stats.oecd.org/Index.aspx?DataSetCode=WILD_LIFE. The dataset is labeled as "WILD_LIFE.csv" in the data folder. 
2. The website did not specify how the data was collected, but we know that researchers working for the _Organisation for Economic Co-Operation and Development_ (OECD) gathered the data. The dataset holds metadata about endangered species around the world. The **metadata** includes information like where the species are located, what type of species they are, the number of threatened species, the number of endangered species, and other related details. 
3. There are **3,262** observations in the dataset. 
4. There are **15** features in the dataset. 
5. There are several questions that can be answered using the data from this dataset. The data helps us explore questions like which _country_ has the most endangered animals, are there more endangered species that are _mammals_ or _reptiles_, and does the _number_ of threatened species increase or decrease over time? 

### Second Source:
1. I found the 'U.S. FWS Threatened & Endangered Species Active Critical Habitat Report' 
dataset on the website https://ecos.fws.gov/ecp/report/table/critical-habitat.html?fbclid=IwAR34iloupBtcBAHfH7t8uU0WqRWJyGDKggJShn-J1mSbNVl_Zf_7qYP8kFI. The data is labeled as "us_endangered_species.csv".

2. How was the data collected or generated? Make sure to explain who collected the data (not necessarily      the same people that host the data), and who or what the data is about?
 The website does not specify how the data was collect, but the _U.S. Fish and Wildlife Service_ is the government agency that handles these types of datasets. The dataset is about endangered species within the U.S., their critical habit locations, and also other information.  
3. How many observations (rows) are in your data? **844** rows
4. How many features (columns) are in the data? **12** columns
5. What questions (from above) can be answered using the data in this dataset? We can ask questions such as **which region** of the U.S. have the **most endangered species**, list out **which animals** are **endangered** and what **types of species** they are. Other questions can be asked in combination of these attributes.

### Third Source: 
1. I found the 'Biodiversity by County - Distribution of Animals, Plants and Natural Communities' dataset on the website https://catalog.data.gov/dataset/biodiversity-by-county-distribution-of-animals-plants-and-natural-communities
2. The website does not specify how the data was collected. The NYS Department of Environmental Conservation (DEC) collected the data of lots of different species of plants and animals. It included information about the scientific names and categories they were in. It includes information from the New York Natural Heritage Program biodiversity database, NYS Breeding Bird Atlas Project database, and DEC’s NYS Reptile and Amphibian Database.
3. **20018** rows
4. **13** columns
5. We can answer questions like which **county**, **category**, **taxonomic groups**, **scientific name**, **the listing status**, **distribution status**, and **Year documented**.