library("ropenaq")
library("dplyr")
india_locs <- aq_locations(limit = 1000, page = 1,
                           country = "IN",
                           parameter = "pm25")$results
india_locs <- filter(india_locs, latitude > 21)

# meas <- NULL
# 
# for(loc in india_locs$locationURL){
#   print(loc)
#   no_measures <- aq_measurements(location = loc, 
#                                  page = 1,
#                                  limit= 1,
#                                  parameter = "pm25")$meta$found
#   no_pages <- ceiling(no_measures/1000)
#   for(page in 1:no_pages){
#     print(page)
#     meas <- rbind(meas,
#                   aq_measurements(location = loc,
#                                   page = page,
#                                   limit = 1000,
#                                   parameter = "pm25")$results)
#   }
# }
# meas25 <- meas
# save(meas25, file = "data/pm25.RData")
load("data/pm25.RData")
library("ggplot2")
filter(meas, value < 2000, value > 0) %>%
  ggplot() +
  geom_point(aes(dateLocal, value,
                 col = location)) +
  facet_grid(location ~., scales = "free")