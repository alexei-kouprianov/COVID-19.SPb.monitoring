spb.gov.A00.DATE <- read.table("../downloads/gov.spb.ru.covid-19.extracted.DATE.txt", h=FALSE)
spb.gov.B01.CONFIRMED <- read.table("../downloads/gov.spb.ru.covid-19.extracted.CONFIRMED.txt", h=FALSE)
spb.gov.B02.RECOVERED <- read.table("../downloads/gov.spb.ru.covid-19.extracted.RECOVERED.txt", h=FALSE)
spb.gov.B03.DEATHS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.DEATHS.txt", h=FALSE)
spb.gov.B04.RT <- read.table("../downloads/gov.spb.ru.covid-19.extracted.RT.txt", h=FALSE)
spb.gov.B05.Y.act <- read.table("../downloads/gov.spb.ru.covid-19.extracted.YACT.txt", h=FALSE)

spb.gov.C01.HOSPITALS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.HOSPITALS.txt", h=FALSE)
spb.gov.C02.BEDS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.BEDS.txt", h=FALSE)
spb.gov.C03.BEDS.free <- read.table("../downloads/gov.spb.ru.covid-19.extracted.FREEBEDS.txt", h=FALSE)

spb.gov.C04.HOSPITALIZED <- read.table("../downloads/gov.spb.ru.covid-19.extracted.HOSPITALIZED.txt", h=FALSE)
spb.gov.C05.HOSPITALIZED.today <- read.table("../downloads/gov.spb.ru.covid-19.extracted.HOSPITALIZED_TODAY.txt", h=FALSE)
spb.gov.C06.RELEASED <- read.table("../downloads/gov.spb.ru.covid-19.extracted.RELEASED.txt", h=FALSE)

spb.gov.C07.INTENSIVE_CARE <- read.table("../downloads/gov.spb.ru.covid-19.extracted.INTENSIVECARE.txt", h=FALSE)
spb.gov.C08.VENT <- read.table("../downloads/gov.spb.ru.covid-19.extracted.VENT.txt", h=FALSE)
spb.gov.C09.LENEXPO <- read.table("../downloads/gov.spb.ru.covid-19.extracted.LENEXPO.txt", h=FALSE)
spb.gov.C10.ZARYA <- read.table("../downloads/gov.spb.ru.covid-19.extracted.ZARYA.txt", h=FALSE)

spb.gov.C11.AMB <- read.table("../downloads/gov.spb.ru.covid-19.extracted.AMB.txt", h=FALSE)

spb.gov.C12.OBSERV <- read.table("../downloads/gov.spb.ru.covid-19.extracted.OBSERV.txt", h=FALSE)
spb.gov.C13.QUARANTINE <- read.table("../downloads/gov.spb.ru.covid-19.extracted.QUARANTINE.txt", h=FALSE)

spb.gov.V01.V.STATIONS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.VSTATIONS.txt", h=FALSE)
spb.gov.V02.V1.CS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V1CS.txt", h=FALSE)
spb.gov.V03.V1.today <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V1TODAY.txt", h=FALSE)
spb.gov.V04.V2.CS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V2CS.txt", h=FALSE)
spb.gov.V05.V2.today <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V2TODAY.txt", h=FALSE)
spb.gov.V06.V12.CS <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V12CS.txt", h=FALSE)
spb.gov.V07.V12.today <- read.table("../downloads/gov.spb.ru.covid-19.extracted.V12TODAY.txt", h=FALSE)
spb.gov.V08.V.rem <- read.table("../downloads/gov.spb.ru.covid-19.extracted.VREMAINING.txt", h=FALSE)

spb.gov.Z01.PCR.labs <- read.table("../downloads/gov.spb.ru.covid-19.extracted.PCRLABS.txt", h=FALSE)
spb.gov.Z02.PCR.points <- read.table("../downloads/gov.spb.ru.covid-19.extracted.PCRPOINTS.txt", h=FALSE)
spb.gov.Z03.PCR.tests <- read.table("../downloads/gov.spb.ru.covid-19.extracted.PCRTESTS.txt", h=FALSE)

spb.gov.ext <- data.frame(
spb.gov.A00.DATE,
spb.gov.B01.CONFIRMED,
spb.gov.B02.RECOVERED,
spb.gov.B03.DEATHS,
spb.gov.B04.RT,
spb.gov.B05.Y.act,

spb.gov.C01.HOSPITALS,
spb.gov.C02.BEDS,
spb.gov.C03.BEDS.free,

spb.gov.C04.HOSPITALIZED,
spb.gov.C05.HOSPITALIZED.today,
spb.gov.C06.RELEASED,

spb.gov.C07.INTENSIVE_CARE,
spb.gov.C08.VENT,
spb.gov.C09.LENEXPO,
spb.gov.C10.ZARYA,

spb.gov.C11.AMB,

spb.gov.C12.OBSERV,
spb.gov.C13.QUARANTINE,

spb.gov.V01.V.STATIONS,
spb.gov.V02.V1.CS,
spb.gov.V03.V1.today,
spb.gov.V04.V2.CS,
spb.gov.V05.V2.today,
spb.gov.V06.V12.CS,
spb.gov.V07.V12.today,
spb.gov.V08.V.rem,

spb.gov.Z01.PCR.labs,
spb.gov.Z02.PCR.points,
spb.gov.Z03.PCR.tests
)

colnames(spb.gov.ext) <- c(
"A.DATE", 
"B01.CONFIRMED", 
"B02.RECOVERED", 
"B03.DEATHS", 
"B04.RT", 
"B05.Y.act", 

"C01.HOSPITALS", 
"C02.BEDS", 
"C03.BEDS.free", 

"C04.HOSPITALIZED", 
"C05.HOSPITALIZED.today", 
"C06.RELEASED", 

"C07.INTENSIVE_CARE", 
"C08.VENT", 
"C09.LENEXPO", 
"C10.ZARYA", 

"C11.AMB", 

"C12.OBSERV", 
"C13.QUARANTINE", 

"V01.V.STATIONS", 
"V02.V1.CS", 
"V03.V1.today", 
"V04.V2.CS", 
"V05.V2.today", 
"V04.V12.CS", 
"V05.V12.today", 
"V06.V.rem", 

"Z01.PCR.labs", 
"Z02.PCR.points", 
"Z03.PCR.tests"
)

write.table(spb.gov.ext, file = "../data/spb.gov.v.2021-08-03.csv", sep = ",", row.names = FALSE)
