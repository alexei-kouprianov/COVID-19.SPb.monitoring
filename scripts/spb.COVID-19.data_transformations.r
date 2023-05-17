################################################################
# COVID-19.SPb.monitoring data transformations script;
# nested under : spb.COVID-19.r
# requires : source("spb.COVID-19.loader.r")

# Preparing tickmarks;
years.tickmarks <- strptime(
		c("2005-12-31",
		"2006-12-31",
		"2007-12-31",
		"2008-12-31",
		"2009-12-31",
		"2010-12-31",
		"2011-12-31",
		"2012-12-31",
		"2013-12-31",
		"2014-12-31",
		"2015-12-31",
		"2016-12-31",
		"2017-12-31",
		"2018-12-31",
		"2019-12-31",
		"2020-12-31",
		"2021-12-31",
		"2022-12-31"),
	"%Y-%m-%d")

timeline.tickmarks <- strptime(
	c("2019-09-30", 
		"2019-10-31", 
		"2019-11-30", 
		"2019-12-31", 
		"2020-01-31", 
		"2020-02-29", 
		"2020-03-31", 
		"2020-04-30", 
		"2020-05-31", 
		"2020-06-30", 
		"2020-07-31", 
		"2020-08-31", 
		"2020-09-30", 
		"2020-10-31", 
		"2020-11-30", 
		"2020-12-31", 
		"2021-01-31", 
		"2021-02-28", 
		"2021-03-31", 
		"2021-04-30", 
		"2021-05-31", 
		"2021-06-30", 
		"2021-07-31", 
		"2021-08-31", 
		"2021-09-30", 
		"2021-10-31", 
		"2021-11-30", 
		"2021-12-31", 
		"2022-01-31", 
		"2022-02-28", 
		"2022-03-31", 
		"2022-04-30", 
		"2022-05-31", 
		"2022-06-30", 
		"2022-07-31", 
		"2022-08-31", 
		"2022-09-30", 
		"2022-10-31", 
		"2022-11-30", 
		"2022-12-31",
		"2023-01-31", 
		"2023-02-28", 
		"2023-03-31", 
		"2023-04-30", 
		"2023-05-31"), 
	"%Y-%m-%d")

################################################################
# Merging spb.gov and spb.gov.ext;

spb.gov.ext.contracted <- spb.gov.ext[, c("A.DATE", "B01.CONFIRMED", "B02.RECOVERED", "C11.AMB", "C04.HOSPITALIZED", "C05.HOSPITALIZED.today", "Z03.PCR.tests", "V02.V1.CS", "V03.V1.today", "V04.V2.CS", "V05.V2.today", "V06.V.rem", "C02.BEDS", "C08.VENT")]
spb.gov.ext.contracted$B01.CONFIRMED <- NA
spb.gov.ext.contracted$B02.RECOVERED <- NA
spb.gov.ext.contracted$C11.AMB <- spb.gov.ext.contracted$C11.AMB + spb.gov.ext.contracted$C04.HOSPITALIZED

# colnames(spb.gov.ext.contracted) <- colnames(spb.gov[c(1:12, 17, 25)])
colnames(spb.gov.ext.contracted) <- colnames(spb.gov)[c(1:4, 19, 6:12, 17, 25)]

spb.gov <- merge(spb.gov, spb.gov.ext.contracted, all = TRUE)

# spb.gov <- rbind.data.frame(spb.gov, spb.gov.ext.contracted)

################################################################
# Merging to spb.united data frame;

spb.united.add_rows.list <- 652:nrow(spb.gov.A00.DATE)
spb.united.add_rows.num <- length(spb.united.add_rows.list)

spb.gov.A00.DATETIME <- spb.gov.A00.DATE$V1[spb.united.add_rows.list]
spb.gov.A00.DATETIME <- gsub("$", " 13:01:13", spb.gov.A00.DATETIME, perl = TRUE)

spb.united.DATETIME <- c(as.character(spb.sk$TIME[32:nrow(spb.sk)]), spb.gov.A00.DATETIME)
spb.united.CONFIRMED <- c(spb.sk$CONFIRMED[32:nrow(spb.sk)], spb.gov.B01.CONFIRMED$V1[spb.united.add_rows.list]) 
spb.united.RECOVERED <- c(spb.sk$RECOVERED[32:nrow(spb.sk)], spb.gov.B02.RECOVERED$V1[spb.united.add_rows.list]) 
spb.united.DEATHS <- c(spb.sk$DEATHS[32:nrow(spb.sk)], spb.gov.B03.DEATHS$V1[spb.united.add_rows.list]) 
spb.united.ACTIVE <- c(spb.sk$ACTIVE[32:nrow(spb.sk)], rep(NA, spb.united.add_rows.num))

spb.united <- cbind.data.frame(
	spb.united.DATETIME,
	spb.united.CONFIRMED,
	spb.united.RECOVERED,
	spb.united.DEATHS,
	spb.united.ACTIVE
	)

colnames(spb.united) <- colnames(spb.sk)

colnames.spb.united <- c(paste(colnames(spb.sk), ".sk", sep=""), 
	"DATE.spb",
	"CONFIRMED.spb",
	"RECOVERED.spb",
	"ACTIVE.spb",
	"IN_HOSPITALS.spb",
	"HOSPITALIZED_TODAY.spb",
	"PCR_TESTS",
	"V1.CS",
	"V1.TODAY",
	"V2.CS",
	"V2.TODAY",
	"V.REMAINING",
	"DESIGNATED_BEDS",
	"VENT",
	"VR1.CS",
	"VR1.TODAY",
	"VR2.CS",
	"VR2.TODAY",
	"FREE_BEDS",
	"OCCUPIED_BEDS_CALCULATED",
	"WEEKLY.REPORTS.BEDS_OCCUPIED.hard",
	"WEEKLY.REPORTS.BEDS_OCCUPIED.mid",
	"WEEKLY.REPORTS.BEDS_OCCUPIED.lite",
	"WEEKLY.REPORTS.BEDS_FREE",
	"WEEKDAY.num", "WEEKDAY.ru", "WEEKDAY.en")

spb.united <- cbind.data.frame(
	spb.united,
# 	c(rep(NA, 27), as.character(spb.PCR$TIMECODE.PCR[1:3]), rep(NA, 6), as.character(spb.PCR$TIMECODE.PCR[4:361]), NA, as.character(spb.PCR$TIMECODE.PCR[362:nrow(spb.PCR)]), rep(NA, (nrow(spb.united) - nrow(spb.PCR)- 27 - 6 - 1))),
# 	c(rep(NA, 27), spb.PCR$PCR_TESTS[1:3], rep(NA, 6), spb.PCR$PCR_TESTS[4:361], NA, spb.PCR$PCR_TESTS[362:nrow(spb.PCR)], rep(NA, (nrow(spb.united) - nrow(spb.PCR) - 27 - 6 - 1))),
	c(as.character(spb.gov$DATE.spb), rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$CONFIRMED.spb, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$RECOVERED.spb, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$ACTIVE.spb, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$IN_HOSPITALS.spb, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$HOSPITALIZED_TODAY.spb, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$PCR_TESTS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$V1.CS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$V1.TODAY, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$V2.CS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$V2.TODAY, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$V.REMAINING, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$DESIGNATED_BEDS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$VENT, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$VR1.CS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$VR1.TODAY, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$VR2.CS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$VR2.TODAY, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$FREE_BEDS, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$OCCUPIED_BEDS_CALCULATED, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.hard, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.mid, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.lite, rep(NA, (nrow(spb.united) - nrow(spb.gov)))),
	c(spb.gov$WEEKLY.REPORTS.BEDS_FREE, rep(NA, (nrow(spb.united) - nrow(spb.gov))))
)

spb.gov$WEEKLY.REPORTS.DESIGNATED_BEDS <- (spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.hard +
	spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.mid +
	spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.lite +
	spb.gov$WEEKLY.REPORTS.BEDS_FREE)

spb.gov$WEEKLY.REPORTS.OCCUPIED_BEDS.total <- (spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.hard +
	spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.mid +
	spb.gov$WEEKLY.REPORTS.BEDS_OCCUPIED.lite)

spb.united$WEEKDAY.num <- rep(1:7, length.out = nrow(spb.united))
spb.united$WEEKDAY.ru <- factor(rep(c("пн", "вт", "ср", "чт", "пт", "сб", "вс"), length.out = nrow(spb.united)), levels = c("пн", "вт", "ср", "чт", "пт", "сб", "вс"))
spb.united$WEEKDAY.en <- factor(rep(c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"), length.out = nrow(spb.united)), levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

rownames(spb.united) <- 1:nrow(spb.united)
colnames(spb.united) <- colnames.spb.united

# Saving spb.united as a CSV file;
write.table(spb.united, file = "../data/SPb.COVID-19.united.csv", sep = ",", row.names = FALSE)

# Preparing reported variables;
.report.timestamp <- tail(spb.gov.ext$A.DATE, 1)
.report.SPb.confirmed.cum <- sum(spb.united$CONFIRMED.sk)
.report.SPb.confirmed.today <- tail(spb.united$CONFIRMED.sk, 1)
.report.SPb.deaths.today <- tail(spb.united$DEATHS.sk, 1)
.report.SPb.deaths.cum <- sum(spb.united$DEATHS.sk)
.report.SPb.deaths.0107 <- sum(tail(spb.united$DEATHS.sk, 7))
.report.SPb.deaths.0814 <- sum(tail(spb.united$DEATHS.sk, 14)[1:7])
.report.SPb.confirmed.0107 <- sum(tail(spb.united$CONFIRMED.sk, 7))
.report.SPb.confirmed.0814 <- sum(tail(spb.united$CONFIRMED.sk, 14)[1:7])
.report.SPb.hospitalized.today.0107 <- sum(tail(spb.gov.ext$C05.HOSPITALIZED.today, 7), na.rm = TRUE)
.report.SPb.hospitalized.today.0814 <- sum(tail(spb.gov.ext$C05.HOSPITALIZED.today, 14)[1:7], na.rm = TRUE)
.report.SPb.dates.14080701 <- tail(spb.gov.ext$A.DATE, 14)[c(1, 7, 8, 14)]

# Assessment block;

if(.report.SPb.confirmed.0107 == .report.SPb.confirmed.0814 & 
	.report.SPb.hospitalized.today.0107 == .report.SPb.hospitalized.today.0814 &
	.report.SPb.deaths.0107 == .report.SPb.deaths.0814){
		.report.SPb.phase <- "По имеющимся данным, ситуация стабилизировалась."
	} else if(.report.SPb.confirmed.0107 <= .report.SPb.confirmed.0814 & 
	.report.SPb.hospitalized.today.0107 <= .report.SPb.hospitalized.today.0814 &
	.report.SPb.deaths.0107 <= .report.SPb.deaths.0814){
		.report.SPb.phase <- "Волна идет на спад."
	} else if(.report.SPb.confirmed.0107 >= .report.SPb.confirmed.0814 & 
	.report.SPb.hospitalized.today.0107 >= .report.SPb.hospitalized.today.0814 &
	.report.SPb.deaths.0107 >= .report.SPb.deaths.0814){
		.report.SPb.phase <- "Волна идет на подъем."
	} else{
		.report.SPb.phase <- "Ситуация неопределенная."
	}

.critical.diff <- abs(
	sum(
		(.report.SPb.confirmed.0107 / .report.SPb.confirmed.0814 - 1),
		(.report.SPb.hospitalized.today.0107 / .report.SPb.hospitalized.today.0814 - 1),
		(.report.SPb.deaths.0107 / .report.SPb.deaths.0814 - 1)
	)
)

if((.report.SPb.confirmed.0107 <= .report.SPb.confirmed.0814 & 
	.report.SPb.hospitalized.today.0107 <= .report.SPb.hospitalized.today.0814 &
	.report.SPb.deaths.0107 <= .report.SPb.deaths.0814) |
	(.report.SPb.confirmed.0107 >= .report.SPb.confirmed.0814 & 
	.report.SPb.hospitalized.today.0107 >= .report.SPb.hospitalized.today.0814 &
	.report.SPb.deaths.0107 >= .report.SPb.deaths.0814)
	){
	if(.critical.diff <= .06){
			.report.SPb.phase.modifier <- "Скорость изменений критически мала, возможно, вскоре направление тренда сменится на противоположное."
	} else {
 			.report.SPb.phase.modifier <- "Скорость изменений достаточна для сохранения тренда в ближайшее время."
	}
# 	if((.report.SPb.confirmed.0107 / .report.SPb.confirmed.0814 < 1.02 &
# 			.report.SPb.confirmed.0107 / .report.SPb.confirmed.0814 > .98) |
# 		(.report.SPb.hospitalized.today.0107 / .report.SPb.hospitalized.today.0814 < 1.02 &
# 			.report.SPb.hospitalized.today.0107 / .report.SPb.hospitalized.today.0814 > .98) |
# 		(.report.SPb.deaths.0107 / .report.SPb.deaths.0814 < 1.02 &
# 			.report.SPb.deaths.0107 / .report.SPb.deaths.0814 > .98)
# 		){
# 			.report.SPb.phase.modifier <- "Скорость изменений критически мала, возможно, вскоре направление тренда сменится на противоположное."
# 		} else{
# 			.report.SPb.phase.modifier <- "Скорость изменений достаточна для сохранения тренда в ближайшее время."
# 		}
	} else {
		.report.SPb.phase.modifier <- "Тренды основных показателей динамики не согласованы друг с другом."
	}

################################################################
# Transforming time variables;
spb.united$TIME.sk <- strptime(spb.united$TIME.sk, "%Y-%m-%d %H:%M:%S")
spb.united$DATE.spb <- strptime(spb.united$DATE.spb, "%Y-%m-%d")
# spb.united$TIMECODE.PCR <- strptime(spb.united$TIMECODE.PCR, "%d.%m.%Y %H:%M:%S")
spb.ynd$START.DATE <- strptime(spb.ynd$START.DATE, "%d.%m.%Y")
spb.ynd$END.DATE <- strptime(spb.ynd$END.DATE, "%d.%m.%Y")

################################################################
# Calculating rolling means;
spb.united$CONFIRMED.sk.RA7 <- filter(spb.united$CONFIRMED.sk, rep(1,7), sides = 2)/7
spb.united$RECOVERED.sk.RA7 <- filter(spb.united$RECOVERED.sk, rep(1,7), sides = 2)/7
spb.united$DEATHS.sk.RA7 <- filter(spb.united$DEATHS.sk, rep(1,7), sides = 2)/7
spb.united$PCR_TESTS.RA7 <- filter(spb.united$PCR_TESTS, rep(1,7), sides = 2)/7
spb.united$CONFIRMED.spb.RA7 <- filter(spb.united$CONFIRMED.spb, rep(1,7), sides = 2)/7
spb.united$HOSPITALIZED_TODAY.spb.RA7 <- filter(spb.united$HOSPITALIZED_TODAY, rep(1,7), sides = 2)/7

################################################################
# Calculating week subtotals;

WEEK.Sun <- spb.united$TIME.sk[7]
CONFIRMED.sk.w <- sum(spb.united$CONFIRMED.sk[1:7], na.rm = TRUE)
RECOVERED.sk.w <- sum(spb.united$RECOVERED.sk[1:7], na.rm = TRUE)
DEATHS.sk.w <- sum(spb.united$DEATHS.sk[1:7], na.rm = TRUE)
PCR_TESTS.w <- sum(spb.united$PCR_TESTS[1:7], na.rm = TRUE)
CONFIRMED.spb.w <- sum(spb.united$CONFIRMED.spb[1:7], na.rm = TRUE)

for(i in 1:((nrow(spb.united)-1)%/%7)){
	WEEK.Sun <- c(WEEK.Sun, spb.united$TIME.sk[(7+i*7)])
	CONFIRMED.sk.w <- c(CONFIRMED.sk.w, sum(spb.united$CONFIRMED.sk[(1+i*7):(7+i*7)], na.rm = TRUE))
	RECOVERED.sk.w <- c(RECOVERED.sk.w, sum(spb.united$RECOVERED.sk[(1+i*7):(7+i*7)], na.rm = TRUE))
	DEATHS.sk.w <- c(DEATHS.sk.w, sum(spb.united$DEATHS.sk[(1+i*7):(7+i*7)], na.rm = TRUE))
	PCR_TESTS.w <- c(PCR_TESTS.w, sum(spb.united$PCR_TESTS[(1+i*7):(7+i*7)], na.rm = TRUE))
	CONFIRMED.spb.w <- c(CONFIRMED.spb.w, sum(spb.united$CONFIRMED.spb[(1+i*7):(7+i*7)], na.rm = TRUE))
	}

spb.united.weekly <- cbind.data.frame(
	as.Date(WEEK.Sun),
	CONFIRMED.sk.w,
	RECOVERED.sk.w,
	DEATHS.sk.w,
	PCR_TESTS.w,
	CONFIRMED.spb.w
	)

colnames(spb.united.weekly)[1] <- "WEEK.Sun"

################################################################
# Building Yandex stats vs week sums data.frame;

spb.united.ynd <- cbind.data.frame(
	c(spb.ynd$REGION, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$START.DATE, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$END.DATE, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(as.character(spb.ynd$OLFACTION_LOSS), rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$COUNT.OLFACTION_LOSS, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$SHARE.OLFACTION_LOSS, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(as.character(spb.ynd$SATURATION), rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$COUNT.SATURATION, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(spb.ynd$SHARE.SATURATION, rep(NA, (nrow(spb.united.weekly) + 21 - nrow(spb.ynd)))),
	c(rep(NA, 21), spb.united.weekly$WEEK.Sun),
	c(rep(NA, 21), spb.united.weekly$CONFIRMED.sk.w),
	c(rep(NA, 21), spb.united.weekly$RECOVERED.sk.w),
	c(rep(NA, 21), spb.united.weekly$DEATHS.sk.w),
	c(rep(NA, 21), spb.united.weekly$PCR_TESTS.w),
	c(rep(NA, 21), spb.united.weekly$CONFIRMED.spb.w)
	)

colnames(spb.united.ynd) <- c(colnames(spb.ynd), colnames(spb.united.weekly))

################################################################
# Building adjacent regions table : Beginning

spb.adj <- cbind.data.frame(pop.adj[, 1:4],
	c(spb.adj.c[, 2], spb.adj.r[, 2])
	)

colnames(spb.adj) <- c(colnames(pop.adj[1:4]), colnames(spb.adj.c[2]))

spb.adj$DENSITY <- spb.adj$POPULATION / spb.adj$AREA.km2

################################################################
# Digression: calculating excessive deaths 
# (to 2019 and to mean 2015-2019)

spb.adj.deaths$MONTH.END <- strptime(spb.adj.deaths$MONTH.END, "%Y-%m-%d")
spb.adj.deaths$MONTH <- factor(
	as.character(spb.adj.deaths$MONTH),
	levels = c(
		"январь",
		"февраль",
		"март",
		"апрель",
		"май",
		"июнь",
		"июль",
		"август",
		"сентябрь",
		"октябрь",
		"ноябрь",
		"декабрь"
		)
	)

spb.adj.deaths.ls <- as.list(NULL)

for(i in 1:length(unique(spb.adj.deaths$YEAR))){
	spb.adj.deaths.ls[[i]] <- subset(spb.adj.deaths, spb.adj.deaths$YEAR == unique(spb.adj.deaths$YEAR)[i])
}

spb.adj.deaths.ls.tail <- as.data.frame(matrix(rep(NA, times = (ncol(spb.adj.deaths.ls[[i]]) * (12 - nrow(spb.adj.deaths.ls[[i]])))), (12 - nrow(spb.adj.deaths.ls[[i]])), ncol(spb.adj.deaths.ls[[i]])))
colnames(spb.adj.deaths.ls.tail) <- colnames(spb.adj.deaths.ls[[i]])

spb.adj.deaths.ls[[i]] <- rbind.data.frame(spb.adj.deaths.ls[[i]], spb.adj.deaths.ls.tail)

spb.adj$DEATHS.exc_to_2019 <- c(
	rep(NA, 2),

	c(5000, 11000, 24000), # Kobak's extrapolations for Estonia, Latvia, Lithuania (updated manually on the monthly basis), see https://github.com/dkobak/excess-mortality for the want of a better estimate;

	sum(spb.adj.deaths.ls[[15]]$Russia[3:12] - spb.adj.deaths.ls[[14]]$Russia[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Russia - spb.adj.deaths.ls[[14]]$Russia, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Russia - spb.adj.deaths.ls[[14]]$Russia, na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$St._Petersburg[3:12] - spb.adj.deaths.ls[[14]]$St._Petersburg[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$St._Petersburg - spb.adj.deaths.ls[[14]]$St._Petersburg, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$St._Petersburg - spb.adj.deaths.ls[[14]]$St._Petersburg, na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$Leningrad_reg.[3:12] - spb.adj.deaths.ls[[14]]$Leningrad_reg.[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Leningrad_reg. - spb.adj.deaths.ls[[14]]$Leningrad_reg., na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Leningrad_reg. - spb.adj.deaths.ls[[14]]$Leningrad_reg., na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$Karelia[3:12] - spb.adj.deaths.ls[[14]]$Karelia[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Karelia - spb.adj.deaths.ls[[14]]$Karelia, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Karelia - spb.adj.deaths.ls[[14]]$Karelia, na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$Vologda[3:12] - spb.adj.deaths.ls[[14]]$Vologda[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Vologda - spb.adj.deaths.ls[[14]]$Vologda, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Vologda - spb.adj.deaths.ls[[14]]$Vologda, na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$Novgorod[3:12] - spb.adj.deaths.ls[[14]]$Novgorod[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Novgorod - spb.adj.deaths.ls[[14]]$Novgorod, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Novgorod - spb.adj.deaths.ls[[14]]$Novgorod, na.rm = TRUE),

	sum(spb.adj.deaths.ls[[15]]$Pskov[3:12] - spb.adj.deaths.ls[[14]]$Pskov[3:12], na.rm = TRUE) +
	sum(spb.adj.deaths.ls[[16]]$Pskov - spb.adj.deaths.ls[[14]]$Pskov, na.rm = TRUE)+
	sum(spb.adj.deaths.ls[[17]]$Pskov - spb.adj.deaths.ls[[14]]$Pskov, na.rm = TRUE)
)

spb.adj.deaths.M.ls <- as.list(NULL)

for(i in 1:length(levels(spb.adj.deaths$MONTH))){
	spb.adj.deaths.M.ls[[i]] <- subset(spb.adj.deaths, spb.adj.deaths$MONTH == levels(spb.adj.deaths$MONTH)[i])
	spb.adj.deaths.M.ls.tail <- as.data.frame(
		matrix(
			rep(NA, times = (ncol(spb.adj.deaths.M.ls[[i]]) * (length(spb.adj.deaths.ls) - nrow(spb.adj.deaths.M.ls[[i]])))), 
			(length(spb.adj.deaths.ls) - nrow(spb.adj.deaths.M.ls[[i]])), 
			ncol(spb.adj.deaths.M.ls[[i]]))
		)
	colnames(spb.adj.deaths.M.ls.tail) <- colnames(spb.adj.deaths.M.ls[[i]])
	spb.adj.deaths.M.ls[[i]] <- rbind.data.frame(spb.adj.deaths.M.ls[[i]], spb.adj.deaths.M.ls.tail)
}

spb.adj.deaths.M.means.Russia <- NULL
spb.adj.deaths.M.means.St._Petersburg <- NULL
spb.adj.deaths.M.means.Leningrad_reg. <- NULL
spb.adj.deaths.M.means.Karelia <- NULL
spb.adj.deaths.M.means.Vologda <- NULL
spb.adj.deaths.M.means.Novgorod <- NULL
spb.adj.deaths.M.means.Pskov <- NULL

for(i in 1:length(spb.adj.deaths.M.ls)){
	spb.adj.deaths.M.means.Russia <- c(spb.adj.deaths.M.means.Russia, mean(spb.adj.deaths.M.ls[[i]]$Russia[10:14]))
	spb.adj.deaths.M.means.St._Petersburg <- c(spb.adj.deaths.M.means.St._Petersburg, mean(spb.adj.deaths.M.ls[[i]]$St._Petersburg[10:14]))
	spb.adj.deaths.M.means.Leningrad_reg. <- c(spb.adj.deaths.M.means.Leningrad_reg., mean(spb.adj.deaths.M.ls[[i]]$Leningrad_reg.[10:14]))
	spb.adj.deaths.M.means.Karelia <- c(spb.adj.deaths.M.means.Karelia, mean(spb.adj.deaths.M.ls[[i]]$Karelia[10:14]))
	spb.adj.deaths.M.means.Vologda <- c(spb.adj.deaths.M.means.Vologda, mean(spb.adj.deaths.M.ls[[i]]$Vologda[10:14]))
	spb.adj.deaths.M.means.Novgorod <- c(spb.adj.deaths.M.means.Novgorod, mean(spb.adj.deaths.M.ls[[i]]$Novgorod[10:14]))
	spb.adj.deaths.M.means.Pskov <- c(spb.adj.deaths.M.means.Pskov, mean(spb.adj.deaths.M.ls[[i]]$Pskov[10:14]))
}

spb.adj$DEATHS.exc_to_2014_2019 <- c(
	rep(NA, 5),
	sum(
		(spb.adj.deaths.ls[[15]]$Russia[3:12] - spb.adj.deaths.M.means.Russia[3:12]),
		(spb.adj.deaths.ls[[16]]$Russia - spb.adj.deaths.M.means.Russia),
		(spb.adj.deaths.ls[[17]]$Russia - spb.adj.deaths.M.means.Russia),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$St._Petersburg[3:12] - spb.adj.deaths.M.means.St._Petersburg[3:12]),
		(spb.adj.deaths.ls[[16]]$St._Petersburg - spb.adj.deaths.M.means.St._Petersburg),
		(spb.adj.deaths.ls[[17]]$St._Petersburg - spb.adj.deaths.M.means.St._Petersburg),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$Leningrad_reg.[3:12] - spb.adj.deaths.M.means.Leningrad_reg.[3:12]),
		(spb.adj.deaths.ls[[16]]$Leningrad_reg. - spb.adj.deaths.M.means.Leningrad_reg.),
		(spb.adj.deaths.ls[[17]]$Leningrad_reg. - spb.adj.deaths.M.means.Leningrad_reg.),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$Karelia[3:12] - spb.adj.deaths.M.means.Karelia[3:12]),
		(spb.adj.deaths.ls[[16]]$Karelia - spb.adj.deaths.M.means.Karelia),
		(spb.adj.deaths.ls[[17]]$Karelia - spb.adj.deaths.M.means.Karelia),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$Vologda[3:12] - spb.adj.deaths.M.means.Vologda[3:12]),
		(spb.adj.deaths.ls[[16]]$Vologda - spb.adj.deaths.M.means.Vologda),
		(spb.adj.deaths.ls[[17]]$Vologda - spb.adj.deaths.M.means.Vologda),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$Novgorod[3:12] - spb.adj.deaths.M.means.Novgorod[3:12]),
		(spb.adj.deaths.ls[[16]]$Novgorod - spb.adj.deaths.M.means.Novgorod),
		(spb.adj.deaths.ls[[17]]$Novgorod - spb.adj.deaths.M.means.Novgorod),
		na.rm = TRUE
	),
	sum(
		(spb.adj.deaths.ls[[15]]$Pskov[3:12] - spb.adj.deaths.M.means.Pskov[3:12]),
		(spb.adj.deaths.ls[[16]]$Pskov - spb.adj.deaths.M.means.Pskov),
		(spb.adj.deaths.ls[[17]]$Pskov - spb.adj.deaths.M.means.Pskov),
		na.rm = TRUE
	)
)

spb.excessive_deaths.2014_2019 <- c((spb.adj.deaths.ls[[15]]$St._Petersburg[3:12] - spb.adj.deaths.M.means.St._Petersburg[3:12]),
	(spb.adj.deaths.ls[[16]]$St._Petersburg - spb.adj.deaths.M.means.St._Petersburg),
	(spb.adj.deaths.ls[[17]]$St._Petersburg - spb.adj.deaths.M.means.St._Petersburg)
	)

spb.excessive_deaths.2019 <- c((spb.adj.deaths.ls[[15]]$St._Petersburg[3:12] - spb.adj.deaths.ls[[14]]$St._Petersburg[3:12]),
	(spb.adj.deaths.ls[[16]]$St._Petersburg - spb.adj.deaths.ls[[14]]$St._Petersburg),
	(spb.adj.deaths.ls[[17]]$St._Petersburg - spb.adj.deaths.ls[[14]]$St._Petersburg)
	)

spb.excessive_deaths.2019.tck <- timeline.tickmarks[7:length(timeline.tickmarks)]

spb.excessive_deaths.sk <- c(sum(spb.united$DEATHS.sk[1:30]), # 30  2020-03-31
	sum(spb.united$DEATHS.sk[31:60]), # 60  2020-04-30
	sum(spb.united$DEATHS.sk[61:91]), # 91  2020-05-31
	sum(spb.united$DEATHS.sk[92:121]), # 121 2020-06-30
	sum(spb.united$DEATHS.sk[122:152]), # 152 2020-07-31
	sum(spb.united$DEATHS.sk[153:183]), # 183 2020-08-31
	sum(spb.united$DEATHS.sk[184:213]), # 213 2020-09-30
	sum(spb.united$DEATHS.sk[214:244]), # 244 2020-10-31
	sum(spb.united$DEATHS.sk[245:274]), # 274 2020-11-30
	sum(spb.united$DEATHS.sk[275:305]), # 305 2020-12-31
	sum(spb.united$DEATHS.sk[306:336]), # 336 2021-01-31
	sum(spb.united$DEATHS.sk[337:364]), # 364 2021-02-28
	sum(spb.united$DEATHS.sk[365:395]), # 395 2021-03-31
	sum(spb.united$DEATHS.sk[396:425]), # 425 2021-04-30
	sum(spb.united$DEATHS.sk[426:456]), # 456 2021-05-31
	sum(spb.united$DEATHS.sk[457:486]), # 486 2021-06-30
	sum(spb.united$DEATHS.sk[487:517]), # 517 2021-07-31
	sum(spb.united$DEATHS.sk[518:548]), # 548 2021-08-31
	sum(spb.united$DEATHS.sk[549:578]), # 578 2021-09-30
	sum(spb.united$DEATHS.sk[579:609]), # 609 2021-10-31
	sum(spb.united$DEATHS.sk[610:639]), # 639 2021-11-30
	sum(spb.united$DEATHS.sk[640:670]), # 670 2021-12-31
	sum(spb.united$DEATHS.sk[671:701]), # 701 2022-01-31
	sum(spb.united$DEATHS.sk[702:729]), # 729 2022-02-28
	sum(spb.united$DEATHS.sk[730:760]), # 760 2022-03-31
	sum(spb.united$DEATHS.sk[761:790]), # 790 2022-04-30
	sum(spb.united$DEATHS.sk[791:821]) # 821 2022-05-31
	)

spb.excessive_deaths.sk.tck <- timeline.tickmarks[7:33]

################################################################
# Building adjacent regions table : End

spb.adj$DEATHS.100K <- spb.adj$DEATHS.official / (spb.adj$POPULATION / 1e+05)
spb.adj$DEATHS.exc_to_2019.100K <- spb.adj$DEATHS.exc_to_2019 / (spb.adj$POPULATION / 1e+05)
spb.adj$DEATHS.exc_to_2014_2019.100K <- spb.adj$DEATHS.exc_to_2014_2019 / (spb.adj$POPULATION / 1e+05)

.spb.adj.report <- spb.adj[, c(2, 3, 6, 5, 7, 9, 10)]

.spb.adj.report$POPULATION <- round(.spb.adj.report$POPULATION / 1e+6, 3)
.spb.adj.report$DENSITY <- round(.spb.adj.report$DENSITY, 2)
.spb.adj.report$DEATHS.100K <- round(.spb.adj.report$DEATHS.100K, 2)
.spb.adj.report$DEATHS.exc_to_2019.100K <- round(.spb.adj.report$DEATHS.exc_to_2019.100K, 2)

.spb.adj.report.ru <- .spb.adj.report

colnames(.spb.adj.report.ru) <- c("Страна / регион", 
	"Население, млн. чел.", 
	"Плотность, чел./км2", 
	"Умершие от COVID (оперативные данные)", 
	paste("Избыточные смерти к 2019 (на ", tail(spb.adj.deaths$MONTH, 1), " ", tail(spb.adj.deaths$YEAR, 1), ")", sep = ""), 
	"Умерших на 100 тыс. (оперативные данные)", 
	paste("Избыточные смерти к 2019 на 100 тыс. (для России — на ", tail(spb.adj.deaths$MONTH, 1), " ", tail(spb.adj.deaths$YEAR, 1), ")", sep = ""))
