library(haven)


##--------------Download zip file and import data----------------------------#

# zipfile <- tempfile()
# url <- "https://www.pbs.gov.pk/sites/default/files//pslm/publications/pslm_microdata_hies_2018_19_provincial/data_in_spss.zip"
# download.file(url = url, destfile = zipfile,method = "curl", extra="-k -L")
# fileList <- unzip(zipfile, list = TRUE)
# plist <- read_sav(unz(zipfile, "data_in_spss/plist.sav"))
# unlink(zipfile)

##--------------------End Download/unzip files----------------------------#

##-------------------import/load data--------------------------------------##

setwd("/home/pbs/training")
weight <- read_sav("data_in_spss/weight.sav")

##-------------------------------------------------------------------------#

library(tidyr)
library(dplyr)
stratum <- weight %>%
  mutate(new_psu = psu) %>%
  separate(col = new_psu, into = c("strata"), sep = 3)

stratum_group <- stratum %>%
  group_by(strata)

stratum_summary <- stratum_group %>% 
  summarise(n=n(), sum = sum(weight), pop = sum*n)

write.csv2(stratum_summary, "summary.csv")
stratum_summary
attr(stratum_summary)
