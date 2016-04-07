daily.weather <- data.frame(
  Zipcode=character(),
  time=as.POSIXlt(character()),
  summary=character(),
  icon=character(),
  sunriseTime=as.POSIXlt(character()),
  sunsetTime=as.POSIXlt(character()),
  moonPhase=numeric(),
  precipIntensity=numeric(),
  precipProbability=numeric(),
  temperatureMin=numeric(),
  temperatureMinTime=as.POSIXlt(character()),
  temperatureMax=numeric(),
  temperatureMaxTime=as.POSIXlt(character()),
  apparentTemperatureMin=numeric(),
  apparentTemperatureMinTime=as.POSIXlt(character()),
  apparentTemperatureMax=numeric(),
  apparentTemperatureMaxTime=as.POSIXlt(character()),
  dewPoint=numeric(),
  windSpeed=numeric(),
  windBearing=numeric(),
  humidity=numeric(),
  pressure=numeric(),
  visibility=numeric(),
  cloudCover=numeric(),
  precipIntensityMax=numeric(),
  precipIntensityMaxTime=as.POSIXlt(character()),
  precipType=character(),
  precipAccumulation=numeric(),
  ozone=numeric()
)

hourly.weather <- data.frame(
  Zipcode=character(),
  time=as.POSIXlt(character()),
  summary=character(),
  icon=character(),
  precipIntensity=numeric(),
  precipProbability=numeric(),
  precipType=character(),
  temperature=numeric(),
  apparentTemperature=numeric(),
  dewPoint=numeric(),
  windSpeed=numeric(),
  windBearing=numeric(),
  cloudCover=numeric(),
  humidity=numeric(),
  pressure=numeric(),
  visibility=numeric()
)

# create a timespan we are interested in
timespan <- seq(ISOdate(2014, 12, 6), ISOdate(2014, 12, 31), by = "day")
directory <- "~/src/WAND-Challenge/persistant-data/results"

for (i in 1:length(timespan)) {

  timespan.daily <- daily.weather
  timespan.hourly <- hourly.weather
  timespan.name = format(timespan[i], "%Y-%m-%dT%H:%M:%S")
  timespan.daily.file.name = paste(timespan.name, ".daily.csv", sep = "")
  timespan.hourly.file.name = paste(timespan.name, ".hourly.csv", sep = "")
  
  for (rowNum in 1:nrow(filteredZips)) {
  # for (rowNum in 1:2) {

    Zipcode <- filteredZips[rowNum,]$Zipcode
    Lat <- filteredZips[rowNum,]$Lat
    Long <- filteredZips[rowNum,]$Long

    print(paste("Getting forcast for", Zipcode, "for date", timespan.name, sep = " "))

    fio.list <- get_forecast_for(Lat, Long, timespan.name)

    timespan.daily <- merge(timespan.daily, cbind(Zipcode, fio.list$daily), all = T)
    timespan.hourly <- merge(timespan.hourly, cbind(Zipcode, fio.list$hourly), all=T)
    rm(fio.list)

  }

  write.csv(timespan.hourly, file.path(directory, timespan.hourly.file.name), row.names = FALSE)
  write.csv(timespan.daily, file.path(directory, timespan.daily.file.name), row.names = FALSE)
  rm(timespan.hourly, timespan.daily)

}
