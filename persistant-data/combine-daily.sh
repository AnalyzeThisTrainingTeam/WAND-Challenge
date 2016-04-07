#!/usr/bin/env bash

echo "Combining daily weather files by zipcode"
DAILY_HEADER='"Zipcode","time","summary","icon","sunriseTime","sunsetTime","moonPhase","precipIntensity","precipProbability","temperatureMin","temperatureMinTime","temperatureMax","temperatureMaxTime","apparentTemperatureMin","apparentTemperatureMinTime","apparentTemperatureMax","apparentTemperatureMaxTime","dewPoint","windSpeed","windBearing","humidity","pressure","visibility","cloudCover","precipIntensityMax","precipIntensityMaxTime","precipType","precipAccumulation","ozone"'
HOURLY_HEADER='"Zipcode","time","summary","icon","precipIntensity","precipProbability","temperature","apparentTemperature","dewPoint","windSpeed","windBearing","humidity","visibility","pressure","cloudCover","precipType"'

for zip in 8857 30004 30005 30019 30024 30041 30068 30071 30097 30115 30204 30214 30223 30269 30328 30341 30517 30518 31792 32055 32060 32605 32606 32615 36360 39819 40033 40069 42642 42718 42728 46227 67801 67846 70501 70503 70506 70508 70560 70570 70583 85086; do

  DAILY_FILENAME="results/daily.${zip}.csv"
  HOURLY_FILENAME="results/hourly.${zip}.csv"
  echo "Collecting daily weather for ${zip} into ${DAILY_FILENAME}"

  echo "${DAILY_HEADER}" > ${DAILY_FILENAME}
  cat results/*daily.csv | grep "${zip}" | sort >> ${DAILY_FILENAME}

  echo "Collecting hourly weather for ${zip} into ${HOURLY_FILENAME}"

  echo "${HOURLY_HEADER}" > ${HOURLY_FILENAME}
  cat results/*hourly.csv | grep "${zip}" | sort >> ${HOURLY_FILENAME}

done
unset zip
