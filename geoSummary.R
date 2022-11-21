library(dplyr)
library(tidyr)
library(stringr)
library(openxlsx)

geoSummary <- FSD_PART_II%>%
  select(STATUS,TEHSIL,`BLOCK CODE TEXT`)%>%
  rename("block" = "BLOCK CODE TEXT")%>%
  separate(block, into = c("charge"),sep =  5, remove = FALSE)%>%
  separate(block, into = c("circle"), sep = 7, remove = FALSE)
data<-geoSummary%>%
  group_by(TEHSIL,STATUS)%>%
  summarise(block_total = n(),
            charge_total = n_distinct(charge),
            circle_total = n_distinct(circle))
data %>% write.xlsx("summary.xlsx")
         