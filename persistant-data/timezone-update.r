options(echo = TRUE)

args <- commandArgs(trailingOnly = TRUE)

as.tzone <- function(x, zone = "America/Chicago") {
  attributes(x)$tzone <- zone
  return(x)
}

df <- read.csv(args[1])

df[,"time"] <- as.POSIXct(df[,"time"])
df[,"time"] <- as.tzone(df[,"time"], args[2])

write.csv(df, file = args[1])