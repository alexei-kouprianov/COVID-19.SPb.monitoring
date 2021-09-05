# Мониторинг эпидемии COVID-19 в Санкт-Петербурге

*For an English version of the text, please, scroll down.*

В данном репозитории хранятся данные, касающиеся динамики эпидемии COVID-19 в Санкт-Петербурге (Россия), скрипты для их преобразования, инфографика и повествовательные отчеты. Здесь сведены данные, публиковавшиеся ранее или публикуемые на сайтах [`"стопкоронавирус.рф"`](https://стопкоронавирус.рф/information/), [gov.spb.ru](https://www.gov.spb.ru/) и [`gogov.ru`](https://gogov.ru/stories/219195), в телеграм-канале [`"Петербург против коронавируса"`](https://t.me/koronavirusspb) и, в отдельных случаях, почерпнутые из публикаций в средствах массовой информации. Часть данных ранее публиковалась мной в репозиториях [`COVID.2019.ru`](https://github.com/alexei-kouprianov/COVID.2019.ru/) (пополняется) и [`COVID-19.SPb`](https://github.com/alexei-kouprianov/COVID-19.SPb/) (не пополняется). Этот проект был бы невозможен без поддержки Уполномоченного по правам человека в Санкт-Петербурге, Александра Владимировича Шишлова, которому автор выражает искренннюю признательность.

Наиболее полный набор данных за период с начала эпидемии находится в файле [`SPb.COVID-19.united.csv`](data/SPb.COVID-19.united.csv), описание переменных, содержащихся в нем, см. в файле [`SPb.COVID-19.united.variables_explained.txt`](data/SPb.COVID-19.united.variables_explained.txt). Он формируется на основе файла [`SPb.stopkoronavirus_archived.csv`](data/SPb.stopkoronavirus_archived.csv), копируемого из репозитория [`COVID.2019.ru`](https://github.com/alexei-kouprianov/COVID.2019.ru/blob/master/data/SPb.stopkoronavirus_archived.csv) (данные сайта "стопкоронавирус.рф" по Петербургу с учетом информации Роспотребнадзора за период до создания сайта "стопкоронавирус.рф"), файла [`gov.spb.ru_archived.csv`](data/gov.spb.ru_archived.csv) (данные с сайта правительства Петербурга и из иных источников с 29 марта 2020 по 2 августа 2021 г. включительно, наиболее полно представлены данные за период с 9 декабря 2020 по 2 июня 2021 г.) и ежедневных обновлений, скачиваемых со страницы ["Петербург против коронавируса. Официальная информация"](https://www.gov.spb.ru/covid-19/) (начиная с 3 августа 2021 г.).

Общая характеристика источников данных дана в файле [SPb.COVID-19.data.sources.md](texts/SPb.COVID-19.data.sources.md). Дополнительную информацию об источниках данных для файлов `SPb.stopkoronavirus_archived.csv` и `gov.spb.ru_archived.csv` см. в файлах [Appendix.A.txt](https://github.com/alexei-kouprianov/COVID-19.SPb/blob/main/texts/Appendix.A.txt) и [Appendix.B.txt](https://github.com/alexei-kouprianov/COVID-19.SPb/blob/main/texts/Appendix.B.txt), опубликованных в репозитории [COVID-19.SPb](https://github.com/alexei-kouprianov/COVID-19.SPb/).

Папки данного репозитория:

* [`data`](data/) содержит файлы с данными
* [`downloads`](downloads/) содержит файлы, ежедневно скачиваемые со страницы ["Петербург против коронавируса. Официальная информация"](https://www.gov.spb.ru/covid-19/), начиная с 3 августа 2021 г.
* [`plots`](plots/) содержит инфографику
* [`scripts`](scripts/) содержит скрипты для скачивания, преобразования данных, печати инфографики и повествовательных отчетов
* [`texts`](texts/) содержит повествовательные отчеты:
    * [COVID-19 в Петербурге, сводный инфографический отчет](SPb.COVID-19.r_report.md)
    * [Что важно знать гражданам Санкт-Петербурга об эпидемии коронавируса](SPb.COVID-19.overview.md)
    * [Основные источники данных по эпидситуации c COVID-19 в Санкт-Петербурге](SPb.COVID-19.data.sources.md)
    * [Критический анализ показателей эпидемической статистики](SPb.COVID-19.data_critique.md)

## Лицензии

Данные, тексты и инфографика размещены в этом репозитории на условиях лицензии Creative Commons Attribution-ShareAlike 4.0 International ([CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)). На скрипты распространяется лицензия [GNU GPL](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Ссылки

* Kouprianov, A. (2020--2021). COVID.2019.ru. Coronavirus epidemics in Russia: data and scripts. 
URL [https://github.com/alexei-kouprianov/COVID.2019.ru](https://github.com/alexei-kouprianov/COVID.2019.ru/)
* Kouprianov, A. (2021). COVID-19.SPb. Coronavirus epidemics in St. Petersburg, Russia: data and scripts.
URL [https://github.com/alexei-kouprianov/COVID-19.SPb](https://github.com/alexei-kouprianov/COVID-19.SPb/)

**Для ссылки на этот репозиторий, пожалуйста, используйте данный шаблон:**

    Kouprianov, A. (2021). COVID-19.SPb.monitoring. Monitoring COVID-19 epidemic in St. Petersburg, Russia: Data and scripts.
    URL https://github.com/alexei-kouprianov/COVID-19.SPb.monitoring

**Шаблон BibTeX для пользователей LaTeX:**

    @Manual{,
        title = {COVID-19.SPb.monitoring. Monitoring COVID-19 epidemic in St. Petersburg, Russia: Data and scripts},
        author = {Kouprianov, Alexei},
        year = {2021},
        note = {data, Perl and R code, infographics, narrative reports},
        url = {https://github.com/alexei-kouprianov/COVID-19.SPb.monitoring},
    }

# Monitoring COVID-19 epidemic in St. Petersburg, Russia

This repository contains data on the COVID-19 epidemic in St. Petersburg (Russia), scripts for data transformation, infographics, and narrative reports (in Russian). It summarizes data published on the websites ["стопкоронавирус.рф"](https://стопкоронавирус.рф/information/), [`gov.spb.ru`](https://www.gov.spb.ru/), and [`gogov.ru`](https://gogov.ru/stories/219195), in the telegram channel [@koronavirusspb](https://t.me/koronavirusspb) and, in some cases, in the on-line periodicals. Some of the data were already published in the repositories [COVID.2019.ru](https://github.com/alexei-kouprianov/COVID.2019.ru/) and [COVID-19.SPb](https://github.com/alexei-kouprianov/COVID-19.SPb/). It would not be possible to complete this project without the support by Alexander Shishlov, St. Petersburg Ombudsman, to whom I am cordially indebted.

The file [SPb.COVID-19.united.csv](data/SPb.COVID-19.united.csv) contains the most complete dataset for the period since the beginning of the outbreak, see [SPb .COVID-19.united.variables_explained.txt](data/SPb.COVID-19.united.variables_explained.txt) for the explanation of the variables. It combines the data from  [SPb.stopkoronavirus_archived.csv](data/SPb.stopkoronavirus_archived.csv), copied from [COVID.2019.ru](https://github.com/alexei-kouprianov/COVID.2019.ru/blob/master/data/SPb.stopkoronavirus_archived.csv) (St. Petersburg data from ["стопкоронавирус.рф"](https://стопкоронавирус.рф/information/)), [gov.spb.ru_archived.csv](data/gov.spb.ru_archived.csv) (data archived from the St. Petersburg government website and online periodicals from 2020-03-29 through 2021-08-02, best covered period: 2020-12-09 -- 2021-06-02), and daily updates from ["St. Petersburg against coronavirus. Official information"](https://www.gov.spb.ru/covid-19/) (from 2021-08-03 on).

A quick review of the folders in this repository:

* [`data`](data/) contains data files
* [`downloads`](downloads/) contains files based on the daily downloads from the page ["St. Petersburg against coronavirus. Official information"](https://www.gov.spb.ru/covid-19/) starting from August 3, 2021.
* [`plots`](plots/) contains infographics
* [`scripts`](scripts/) contains scripts for downloading and transforming the data, printing infographics and narrative reports
* [`texts`](texts/) contains narrative reports

The data sources are briefly characterized in [SPb.COVID-19.data.sources.md](texts/SPb.COVID-19.data.sources.md) (available in Russian only). Additional information on the sources for `SPb.stopkoronavirus_archived.csv` and `gov.spb.ru_archived.csv` see in [Appendix.A.txt](https://github.com/alexei-kouprianov/COVID-19.SPb/blob/main/texts/Appendix.A.txt) and [Appendix.B.txt](https://github.com/alexei-kouprianov/COVID-19.SPb/blob/main/texts/Appendix.B.txt) published in [COVID-19.SPb](https://github.com/alexei-kouprianov/COVID-19.SPb/).

## Licenses

Data, texts and infographics stored in this repository are licensed under the Creative Commons Attribution-ShareAlike 4.0 International license ([CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)). The scripts are licensed under the [GNU GPL](https://www.gnu.org/licenses/gpl-3.0.en.html).

## References

* Kouprianov, A. (2020--2021). COVID.2019.ru. Coronavirus epidemics in Russia: data and scripts. 
URL [https://github.com/alexei-kouprianov/COVID.2019.ru](https://github.com/alexei-kouprianov/COVID.2019.ru/)
* Kouprianov, A. (2021). COVID-19.SPb. Coronavirus epidemics in St. Petersburg, Russia: data and scripts.
URL [https://github.com/alexei-kouprianov/COVID-19.SPb](https://github.com/alexei-kouprianov/COVID-19.SPb/)

**To cite this repository in publications use:**

    Kouprianov, A. (2021). COVID-19.SPb.monitoring. Monitoring COVID-19 epidemic in St. Petersburg, Russia: Data and scripts.
    URL https://github.com/alexei-kouprianov/COVID-19.SPb.monitoring

**A BibTeX entry for LaTeX users is:**

    @Manual{,
        title = {COVID-19.SPb.monitoring. Monitoring COVID-19 epidemic in St. Petersburg, Russia: Data and scripts},
        author = {Kouprianov, Alexei},
        year = {2021},
        note = {data, Perl and R code, infographics, narrative reports},
        url = {https://github.com/alexei-kouprianov/COVID-19.SPb.monitoring},
    }

<hr />

![](misc/CC-BY-SA-icon.png "CC-BY-SA")
