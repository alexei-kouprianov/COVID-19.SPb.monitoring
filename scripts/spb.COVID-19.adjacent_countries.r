# Loading data from COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University

w.deaths <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", h=TRUE)

# Subsetting deaths for countries;

w.deaths.ls <- NULL
w.deaths.ls <- as.list(w.deaths.ls)

for(i in 1:length(levels(w.deaths$Country.Region))){
w.deaths.ls[[i]] <- t(subset(w.deaths, w.deaths$Country.Region == levels(w.deaths$Country.Region)[i])[,c(5:ncol(w.deaths))])
colnames(w.deaths.ls[[i]]) <- subset(w.deaths, w.deaths$Country.Region == levels(w.deaths$Country.Region)[i])[,1]
}

# Extracting deaths for Sweden, Finland, Estonia, Latvia, Lithuania, and Russia (JHU version);

names(w.deaths.ls) <- gsub(" ", "_", levels(w.deaths$Country.Region))

spb.adjacent_countries.d <- cbind.data.frame(
	c(
	"Sweden",
	"Finland",
	"Estonia",
	"Latvia",
	"Lithuania",
	"Russia"
	),
	c(
		tail(w.deaths.ls$Sweden, 1),
		tail(w.deaths.ls$Finland, 1),
		tail(w.deaths.ls$Estonia, 1),
		tail(w.deaths.ls$Latvia, 1),
		tail(w.deaths.ls$Lithuania, 1),
		tail(w.deaths.ls$Russia, 1)
	)
)

colnames(spb.adjacent_countries.d) <- c("NAME", "DEATHS.official")

# Saving data for countries to the file;

write.table(spb.adjacent_countries.d, "../data/SPb.adjacent_countries.official_deaths.csv", row.names = FALSE, sep = ",")

# Removing redundant objects;

rm(w.deaths, w.deaths.ls)
