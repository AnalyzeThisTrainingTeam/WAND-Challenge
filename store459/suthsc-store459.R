
path <- "/home/suthsc/src/WAND-Challenge/"
filename <- "store-459.csv"
store459 <- read.csv(paste(path,filename, sep = ""),  na = "*")

d <- store459[,4:26]
attach(d)

model1 <- lm(NetSales ~ ., data = d)
summary(model1)

anova(model1)

detach(d)