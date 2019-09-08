
#Loading packages
library(rvest)
library(stringr)
library(dplyr)
library(tidyr)

#Specifying the url for desired website to be scraped
url <- 'http://www.nhltradetracker.com/'

#Reading the HTML code from the website
webpage <- read_html(url)

#Using CSS selectors to scrape the entire div table
df0 <- data.frame(trades = html_text(html_nodes(webpage,'div table'))) %>%
  filter(str_detect(trades,"acquire"))

# Start splitting up strings
df1 <- df0 %>% 
  separate(trades, c("From", "To", "Extra"), 
           sep = "acquire", extra = "merge", fill = "right")

# How to split out 'Extra' field to include comma seperated assets by team
# i.e. first value would be 'Trevor Carrick for Kyle Wood
# second value would be Ryan Callahan, 2020 5th round pick for Mike Condon, 2020 6th round pick




# Now try just scraping the individual elements
# Teams
df2 <- data.frame(teams = html_text(html_nodes(webpage,'td strong'))) %>%
    filter(teams != 'Date')

# Players
df3 <- data.frame(assets = html_text(html_nodes(webpage,'span a')))

# This poses a separate problem, because not all trades have the same number of
# assets and the assets are stored in multiple div elements


# Possible to scrape the whole table and just grab what we need?
df4 <- data.frame(assets = html_text(html_nodes(webpage,'tr td')))


        
        
