################################################################
# COVID-19.SPb.monitoring control plots script;
# nested under : spb.COVID-19.r
# requires : source("spb.COVID-19.loader.r")
# requires : source("spb.COVID-19.data_transformations.r")

dir.create("../plots/instagram/", recursive = TRUE)

png("../plots/instagram/01.SPb.COVID-19.PCR_tests.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)
plot(spb.united$DATE.spb, spb.united$PCR_TESTS, type = "n",
	xlim = c(as.numeric(min(spb.united$TIME.sk)), 
		as.numeric(max(spb.united$TIME.sk))),
	ylim = c(0, max(spb.united$PCR_TESTS, na.rm = TRUE)),
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество проведенных тестов",
	axes = FALSE)
lines(spb.united$DATE.spb, spb.united$PCR_TESTS, type = "h", col = "slateblue", lwd = 1.75, lend = 2)
lines(spb.united$DATE.spb, spb.united$PCR_TESTS.RA7, col = "white", lwd = 4)
lines(spb.united$DATE.spb, spb.united$PCR_TESTS.RA7, col = rgb(0, .02, .1, 1), lwd = 2)
abline(h = 1:20*1e+4, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	col = c("slateblue", rgb(0, .01, .1, 1)),
	lty = 1,
	lwd = 3,
	legend = c("количество тестов в день", "семидневное скользящее среднее"))
axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2, at = 0:10*1e+04, labels = FALSE, tcl = -.25)
axis(2, at = seq(0, 100, 20)*1e+03, labels = c(0, paste(seq(20, 100, 20), "тыс.")))
dev.off()

png("../plots/instagram/02.SPb.COVID-19.confirmed.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)
plot(spb.united$TIME.sk, spb.united$CONFIRMED.sk, type = "n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество выявленных случаев по версии «Стопкоронавирус.рф»",
	axes = FALSE)
lines(spb.united$TIME.sk, spb.united$CONFIRMED.sk, type = "h", col = "orangered", lwd = 1.75, lend = 2)
lines(spb.united$TIME.sk, spb.united$CONFIRMED.sk.RA7, col = "white", lwd = 4)
lines(spb.united$TIME.sk, spb.united$CONFIRMED.sk.RA7, col = rgb(.3, .02, 0, 1), lwd = 2)
abline(h = (0:50*1e+3)/2, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)
legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	col = c("orangered", rgb(.3, .02, 0, 1)),
	lty = 1,
	lwd = 3,
	legend = c("количество выявленных случаев в день", "семидневное скользящее среднее"))
axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)
dev.off()

png("../plots/instagram/03.SPb.COVID-19.hospitalized_today.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)
plot(spb.united$TIME.sk, spb.united$HOSPITALIZED_TODAY.spb, type = "n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество госпитализаций в день",
	axes = FALSE)
lines(spb.united$TIME.sk, spb.united$HOSPITALIZED_TODAY.spb, type = "h", col = "palegreen4", lwd = 1.75, lend = 2)
lines(spb.united$TIME.sk, spb.united$HOSPITALIZED_TODAY.spb.RA7, col = "white", lwd = 4)
lines(spb.united$TIME.sk, spb.united$HOSPITALIZED_TODAY.spb.RA7, col = rgb(0, .1, .05, 1), lwd = 2)
abline(h = 0:20*1e+2, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)
legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	col = c("palegreen4", rgb(0, .1, .05, 1)),
	lty = 1,
	lwd = 3,
	legend = c("количество госпитализированных в день", "семидневное скользящее среднее"))
axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)
dev.off()

png("../plots/instagram/04.SPb.COVID-19.deaths.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)
plot(spb.united$TIME.sk, spb.united$DEATHS.sk, type = "n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество смертей в оперативном учете",
	axes = FALSE)
lines(spb.united$TIME.sk, spb.united$DEATHS.sk, type = "h", col = rgb(.2, .02, 0, 1), lwd = 1.75, lend = 2)
lines(spb.united$TIME.sk, spb.united$DEATHS.sk.RA7, col = "white", lwd = 4)
lines(spb.united$TIME.sk, spb.united$DEATHS.sk.RA7, col = rgb(1, .1, 0, 1), lwd = 2)
abline(h = 0:20*1e+1, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)
legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	col = c(rgb(.2, .02, 0, 1), rgb(1, .1, 0, 1)),
	lty = 1,
	lwd = 3,
	legend = c("количество смертей в день", "семидневное скользящее среднее"))
axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)
dev.off()

png("../plots/instagram/06.SPb.COVID-19.Yandex_vs_deaths.png", height=600, width=600, res=120, pointsize=9)
# par(mar=c(6,5,4,5)+.1)
par(mar=c(6,4,2,5)+.1)

plot(spb.united.ynd$END.DATE, spb.united.ynd$COUNT.OLFACTION_LOSS, type="n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab="Запросов к Яндексу в неделю", 
	ylim=c(0, ceiling(max(spb.united.ynd$COUNT.SATURATION, na.rm=TRUE))),
	axes=FALSE)

abline(h = seq(0, 30000, 1000), 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

points(spb.united.ynd$END.DATE, spb.united.ynd$DEATHS.sk.w * 20, type="h", lwd=3, lend=3, col=rgb(0,0,0,.6))

points(spb.united.ynd$END.DATE, spb.united.ynd$COUNT.OLFACTION_LOSS, type="o", pch=20, cex=.8, lwd=5, col="white")
points(spb.united.ynd$END.DATE, spb.united.ynd$COUNT.OLFACTION_LOSS, type="o", pch=20, cex=.8, lwd=2.5, col="red")

points(spb.united.ynd$END.DATE, spb.united.ynd$COUNT.SATURATION, type="o", pch=20, cex=.8, lwd=5, col="white")
points(spb.united.ynd$END.DATE, spb.united.ynd$COUNT.SATURATION, type="o", pch=20, cex=.8, lwd=2.5, col="midnightblue")

legend("topleft",
	lty=1, lwd=3, col=c("red", "midnightblue", rgb(0,0,0,.6)), 
	legend=c(paste("Запрос «", levels(spb.united.ynd$OLFACTION_LOSS), "» (левая ось)", sep=""), 
		paste("Запрос «", levels(spb.united.ynd$SATURATION), "» (левая ось)", sep=""), 
		"Смерти (правая ось)"), 
		bty="n")

par(col.axis = 2)
axis(2, col=2)
par(col.axis = 1)
axis(4, at = seq(0, 15000, 1000), labels = seq(0, 15000, 1000)/20, col=1)

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)

mtext("Смертей в неделю", side = 4, line = 3)

dev.off()

png("../plots/instagram/SPb.COVID-19.sk_vs_spb.Confirmed.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$TIME.sk, spb.united$CONFIRMED.sk, type = "n", 
	ylim = c(0, max(spb.united$CONFIRMED.spb, na.rm = TRUE)),
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество подтвержденных случаев в день",
	axes = FALSE)

lines(spb.united$TIME.sk, spb.united$CONFIRMED.sk, type = "h", col = rgb(0, 0, 0, .5), lwd = 1.75, lend = 2)
lines(spb.united$TIME.sk, spb.united$CONFIRMED.spb, type = "h", col = rgb(.5, 0, 0, .5), lwd = 1.75, lend = 2)

abline(h = seq(0, 30000, 1000), 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

lines(spb.united$TIME.sk, spb.united$CONFIRMED.spb.RA7, col = "white", lwd = 3)
lines(spb.united$TIME.sk, spb.united$CONFIRMED.spb.RA7, col = "red", lwd = 1)

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = c(rgb(0, 0, 0, .5), rgb(.5, 0, 0, 1), "red"),
	legend = c("(1) По версии «Стопкоронавирус.рф»", "(2) По версии Межвед. городского совета", "Семидневное скользящее среднее для (2)"))

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

png("../plots/instagram/07.SPb.COVID-19.sk_vs_spb.Active.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$TIME.sk, spb.united$ACTIVE.sk, 
	type="n", 
	ylim = c(0, max(spb.united$ACTIVE.sk, na.rm = TRUE)),
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество активных случаев",
	axes = FALSE)

rect(xleft = as.numeric(strptime("2020-03-05", "%Y-%m-%d")),
	xright = as.numeric(strptime("2020-12-08", "%Y-%m-%d")),
	ybottom = 0,
	ytop = max(spb.united$ACTIVE.sk, na.rm = TRUE) * 1.5,
	col = rgb(0, 0, 0, .1),
	border = rgb(0, 0, 0, .05))

rect(xleft = as.numeric(strptime("2021-06-03", "%Y-%m-%d")),
	xright = as.numeric(strptime("2021-08-02", "%Y-%m-%d")),
	ybottom = 0,
	ytop = max(spb.united$ACTIVE.sk, na.rm = TRUE) * 1.5,
	col = rgb(0, 0, 0, .1),
	border = rgb(0, 0, 0, .05))

abline(h = (0:25)*1e+4, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

lines(spb.united$TIME.sk, spb.united$ACTIVE.sk, col = 1, lwd = 1.5)

lines(spb.united$DATE.spb, spb.united$ACTIVE.spb, col = "white", lwd = 3)
lines(spb.united$DATE.spb, spb.united$ACTIVE.spb, col = 2, lwd = 1.5)

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = c(1, 2, 8),
	legend = c("По версии «Стопкоронавирус.рф»", "По версии Межвед. городского совета", "Данные Межвед. городского совета скрыты"))

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2, at = (0:15)*2*1e+4, tcl = -.25, labels = c(0, paste(seq(20, 300, 20), "тыс.")))

dev.off()


png("../plots/instagram/05.SPb.COVID-19.Hospitalized_vs_Hospitalized_today_vs_Occupied_beds.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$DATE.spb, spb.united$OCCUPIED_BEDS_CALCULATED, 
	type = "o", 
	ylim = c(0, max(spb.united$OCCUPIED_BEDS_CALCULATED, na.rm = TRUE)),
	col = "darkred",
	pch = 20,
	lwd = 1.5, 
	cex = .7,
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Госпитализированные",
	axes = FALSE)

lines(spb.united$DATE.spb, spb.united$IN_HOSPITALS.spb, 
	type = "o", 
	col = "darkgreen",
	pch = 20,
	lwd = 1.5, 
	cex = .7)

lines(spb.united$DATE.spb, spb.gov$WEEKLY.REPORTS.OCCUPIED_BEDS.total,
	type = "o", 
	col = "orange",
	pch = 3,
	lwd = 1.5, 
	cex = .7)

points(spb.united$DATE.spb, spb.united$HOSPITALIZED_TODAY.spb, type = "h", col = "darkgreen")

abline(h = (0:20)*1e+3, 
	v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

shadowtext(x = as.numeric(strptime(c("2020-05-20", "2020-06-15", "2021-04-30", "2020-11-10"), "%Y-%m-%d")),
	y = c(8000, 10000, 2500, 1000),
	labels = c("Занято коек", "Занято коек,\nнедельн. отчеты", "В стационарах с подтвержд.\nлабор. методом COVID-19", "Госпитализировано за день"),
	col = c("darkred", "orange", "darkgreen", "darkgreen"),
	bg = "white",
	pos = c(4, 4, 4, 3))

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

png("../plots/instagram/SPb.COVID-19.Overall_Deaths.2006_.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.adj.deaths$MONTH.END, spb.adj.deaths$St._Petersburg,
	ylim = c(0, max(spb.adj.deaths$St._Petersburg)),
	type = "o",
	lwd = 1.5,
	cex = .7,
	pch = 20,
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество смертей от всех причин (ЕМИСС Гос. статистка)",
	axes = FALSE)

abline(h = 0:10*1e+3, 
	v = as.numeric(years.tickmarks), 
	lty = 3, lwd = .5, col = 8)

points(spb.adj.deaths$MONTH.END, spb.adj.deaths$Leningrad_reg., type = "o", pch = 20, lwd = 1.5, cex = .7, col = 8)
points(spb.adj.deaths$MONTH.END, spb.adj.deaths$Karelia, type = "o", pch = 20, lwd = 1.5, cex = .7, col = "navy")
points(spb.adj.deaths$MONTH.END, spb.adj.deaths$Vologda, type = "o", pch = 20, lwd = 1.5, cex = .7, col = "darkgreen")
points(spb.adj.deaths$MONTH.END, spb.adj.deaths$Pskov, type = "o", pch = 20, lwd = 1.5, cex = .7, col = "darkred")
points(spb.adj.deaths$MONTH.END, spb.adj.deaths$Novgorod, type = "o", pch = 20, lwd = 1.5, cex = .7, col = "orange")

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = c("black", "grey", "navy", "darkgreen", "darkred", "orange"),
	legend = c("Петербург", "Ленинградская обл.", "Карелия", "Вологодская обл.", "Новгородская обл.", "Псковская обл.")
	)

axis.POSIXct(1, at = years.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

png("../plots/instagram/SPb.COVID-19.RA7.PCR_tests_vs_Hospitalized_today_vs_Deaths.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$DATE.spb,
	spb.united$PCR_TESTS.RA7/max(spb.united$PCR_TESTS.RA7, na.rm = TRUE),
	type = "l",
	ylim = c(0, 1),
	col = 3,
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Доля показателя от его максимального опубликованного значения",
	axes = FALSE)

abline(h = 0:10*1e-1, 
	v = as.numeric(timeline.tickmarks), 
	lty = 3, col = 8)

lines(spb.united$DATE.spb, spb.united$HOSPITALIZED_TODAY.spb.RA7/max(spb.united$HOSPITALIZED_TODAY.spb.RA7, na.rm = TRUE), col = 2)
lines(spb.united$DATE.spb, spb.united$DEATHS.sk.RA7/max(spb.united$DEATHS.sk.RA7, na.rm = TRUE), col = 1)
# points(spb.united$CONFIRMED.sk.RA7/max(spb.united$CONFIRMED.sk.RA7, na.rm = TRUE), type = "l", col = "orange")
# points(spb.united$CONFIRMED.spb.RA7/max(spb.united$CONFIRMED.spb.RA7, na.rm = TRUE), type = "l", col = "darkred")

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = 3:1,
	legend = c("PCR-тесты в день (семидневн. скользящ. среднее)",
		"госпитализированные за день (семидневн. скользящ. среднее)",
		"умершие в день (семидневн. скользящ. среднее)"))

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

png("../plots/instagram/SPb.COVID-19.Excessive_deaths.SPb.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.excessive_deaths.2019.tck[1:length(spb.excessive_deaths.sk)], 
	spb.excessive_deaths.2014_2019[1:length(spb.excessive_deaths.sk)],
	type = "n",
	ylim = c(min(c(spb.excessive_deaths.2014_2019, spb.excessive_deaths.2019, spb.excessive_deaths.sk), na.rm = TRUE), 
		max(c(spb.excessive_deaths.2014_2019, spb.excessive_deaths.2019, spb.excessive_deaths.sk), na.rm = TRUE)),
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Количество избыточных смертей в месяц",
	axes = FALSE)

abline(h = (0:10*1e+3)/2, 
	v = as.numeric(timeline.tickmarks), 
	lty = 3, col = 8)

abline(h = 0, 
	v = as.numeric(timeline.tickmarks[c(16, 28)]), 
	lty = 3, col = 1)

lines(spb.excessive_deaths.2019.tck, spb.excessive_deaths.2014_2019[1:length(spb.excessive_deaths.2019.tck)], type = "o", pch = 20, cex = .7, col = "blue")
lines(spb.excessive_deaths.2019.tck, spb.excessive_deaths.2019[1:length(spb.excessive_deaths.2019.tck)], type = "o", pch = 20, cex = .7, col = "black")
lines(spb.excessive_deaths.sk.tck, spb.excessive_deaths.sk, type = "o", pch = 20, cex = .7, col = "red")

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = c("blue", "black", "red"),
	cex = .9,
	legend = c(paste("От среднего за 2015—19 гг. (≈",
			round(sum(spb.excessive_deaths.2014_2019[2:length(spb.excessive_deaths.2014_2019)], na.rm = TRUE)), " за ", spb.adj.deaths$MONTH[172], " 2020 — ", spb.adj.deaths$MONTH[nrow(spb.adj.deaths)], " 2021)", sep=""), 
		paste("От уровня 2019 г. (",
			round(sum(spb.excessive_deaths.2019, na.rm = TRUE)), " за ", spb.adj.deaths$MONTH[171], " 2020 — ", spb.adj.deaths$MONTH[nrow(spb.adj.deaths)], " 2021)", sep=""), 
		paste("На стопкоронавирус.рф (", 
			sum(spb.excessive_deaths.sk), " за март 2020 — ", spb.adj.deaths$MONTH[nrow(spb.adj.deaths)], " 2021)", sep="")
		)
)

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

png("../plots/instagram/SPb.COVID-19.PCR_Positivity.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$TIME.sk, spb.united$CONFIRMED.sk / spb.united$PCR_TESTS,
	type = "n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Доля положительных тестов",
	axes = FALSE)

lines(spb.united$TIME.sk[520:nrow(spb.united)], 
	spb.united$CONFIRMED.sk[520:nrow(spb.united)] / spb.united$PCR_TESTS[520:nrow(spb.united)],
	type = "l")
lines(spb.united$TIME.sk[2:459], spb.united$CONFIRMED.spb[1:458] / spb.united$PCR_TESTS[2:459],
	type = "l")

abline(v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

abline(h = c(0, .5), 
	v = as.numeric(timeline.tickmarks[c(16, 28)]), 
	lty = 3, col = 1)

rect(xleft = c(0, 
		as.numeric(strptime("2021-06-03", format = "%Y-%m-%d"))),
	xright = c(as.numeric(strptime("2020-12-08", format = "%Y-%m-%d")),
		as.numeric(strptime("2021-08-02", format = "%Y-%m-%d"))),
	ybottom = rep(-1, 2),
	ytop = rep(1, 2),
	border = rgb(0,0,0,.025),
	col = rgb(0,0,0,.05))

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()


png("../plots/instagram/SPb.COVID-19.Smoothing.png", height=600, width=600, res=120, pointsize=9)
par(mar=c(6,4,2,2)+.1)

plot(spb.united$TIME.sk, 
	abs(spb.united$CONFIRMED.sk - spb.united$CONFIRMED.sk.RA7)/spb.united$CONFIRMED.sk.RA7, 
	type = "n",
	main = "Санкт-Петербург / Эпидемия COVID-19",
	xlab = "",
	ylab = "Коэффициент сглаживания относительно скользящего среднего",
	axes = FALSE)

abline(v = as.numeric(timeline.tickmarks),
	lty = 3, col = 8)

lines(spb.united$TIME.sk, abs(spb.united$HOSPITALIZED_TODAY.spb - spb.united$HOSPITALIZED_TODAY.spb.RA7)/spb.united$HOSPITALIZED_TODAY.spb.RA7, col = rgb(0, 0, 0, .2))
lines(spb.united$TIME.sk, abs(spb.united$PCR_TESTS - spb.united$PCR_TESTS.RA7)/spb.united$PCR_TESTS.RA7, col = rgb(0, 0, 0, .2))
lines(spb.united$TIME.sk, abs(spb.united$DEATHS.sk - spb.united$DEATHS.sk.RA7)/spb.united$DEATHS.sk.RA7, col = rgb(0, 0, 0, .2))

abline(h = .1, lty = 3)

lines(spb.united$TIME.sk, abs(spb.united$CONFIRMED.spb - spb.united$CONFIRMED.spb.RA7)/spb.united$CONFIRMED.spb.RA7, col = "white", lwd = 3)
lines(spb.united$TIME.sk, abs(spb.united$CONFIRMED.spb - spb.united$CONFIRMED.spb.RA7)/spb.united$CONFIRMED.spb.RA7, col = 2)

lines(spb.united$TIME.sk, abs(spb.united$CONFIRMED.sk - spb.united$CONFIRMED.sk.RA7)/spb.united$CONFIRMED.sk.RA7, col = "white", lwd = 3)
lines(spb.united$TIME.sk, abs(spb.united$CONFIRMED.sk - spb.united$CONFIRMED.sk.RA7)/spb.united$CONFIRMED.sk.RA7, col = 1)

legend("topleft",
	bty="o",
	box.lty = 0,
	bg = rgb(1, 1, 1, .45),
	fill = c(1, 2, 8),
	legend = c("Для выявленных случаев по версии «Стопкоронавирус.рф»", 
		"Для выявленных случаев по версии Межвед. городского совета",
		"Для данных по PCR-тестам, госпитализации, умершим (приведены для масштаба)")
		)

shadowtext(x = timeline.tickmarks[10], y = .1, pos = 3, labels = "S = 0.1", col = 1, bg = "white")

axis.POSIXct(1, at = timeline.tickmarks, format = "%Y-%m-%d", las = 2)
axis(2)

dev.off()

# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.PCR_tests.png ../plots/instagram/01.SPb.COVID-19.PCR_tests.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.confirmed.png ../plots/instagram/02.SPb.COVID-19.confirmed.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.hospitalized_today.png ../plots/instagram/03.SPb.COVID-19.hospitalized_today.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.deaths.png ../plots/instagram/04.SPb.COVID-19.deaths.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.Hospitalized_vs_Hospitalized_today_vs_Occupied_beds.png ../plots/instagram/05.SPb.COVID-19.Hospitalized_vs_Hospitalized_today_vs_Occupied_beds.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.Yandex_vs_deaths.png ../plots/instagram/06.SPb.COVID-19.Yandex_vs_deaths.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.overview.Y_log10.png ../plots/instagram/SPb.COVID-19.overview.Y_log10.mini.png")
# system("convert -resize 75% ../plots/instagram/SPb.COVID-19.PCR_Positivity.png ../plots/instagram/07.SPb.COVID-19.PCR_Positivity.mini.png")
