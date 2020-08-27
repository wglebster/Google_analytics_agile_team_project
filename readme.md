# R Shiny app group project.

Authors: Gleb Vulf, David Wright and Conor Power.
​
A group project involving the planning, coding and presentation of a R Shiny dashboard style app.
​
The project took place over a week's period and all authors worked together on it remotely.
​
### Brief
​
The client wanted to better understand how their website users were navigating their site.
​
They wished for a focus on driving visitors to sign up for particular events and information sessions.
​
Only a small number of the total visitors who use the website actually book an event.
​
Key areas the client wanted to be considered:
​
* The journey users take
* How they arrive on the site
* Where they drop off.
* Any issues with the journey and any ways they may support event bookings
​
Can we increase event booking to 200 per month? If so, what changes would be recommended and how could these be monitored?
​
### Tools
​
We coded in R and used Google Analytics.
​
The data was extracted from 1/3/20 to 18/8/20 to a csv file from Google Analytics in an API call using the google_analytics library in R. The team agreed on the relevant dimensions and metrics which should be pulled.
​
The following libraries were used in creating the app:
​
library(shiny)
library(tidyverse)
library(lubridate)
library(forcats)
library(janitor)
library(data.table)
library(google_analytics)
​
#### Synthesising the data
​
After presenting to the client, the data from Google Analytics was synthesised using the "synthpop" library in R. This was to protect the client and so that the app could be publically.
