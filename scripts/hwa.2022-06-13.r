################################

confirmed.1.data <- read.xlsx("data.xlsx",
	sheet = "CONFIRMED",
	startRow = 2,
	colNames= FALSE,
	rowNames = FALSE)

confirmed.1.time <- read.xlsx("data.xlsx",
	sheet = "CONFIRMED",
	rows = 1,
	cols = 2:ncol(confirmed.1.data),
	colNames= FALSE,
	rowNames = FALSE)

confirmed.1.data.t <- t(confirmed.1.data[, 2:ncol(confirmed.1.data)])
confirmed.1.time.t <- t(confirmed.1.time)

confirmed.1.datatime <- cbind.data.frame(confirmed.1.time.t, confirmed.1.data.t)

colnames(confirmed.1.datatime) <- c("TIMESTAMP", confirmed.1.data[, 1])

################################

edn_202203 <- read.xlsx("edn_03-2022.xlsx",
                                 sheet = "t1_1",
				 rows = c(9:26, 28:30, 33:39, 41:48, 50:56, 58:71, 73:75, 79, 81:90, 92:102),
				 cols = c(1, 2, 6, 10, 16, 20),
                                 colNames = FALSE,
                                 rowNames = FALSE)

colnames(edn_202203) <- c("REGION", "BIRTHS", "DEATHS", "DEATHS.1", "MARRIAGES", "DIVORCES")
