#!/usr/bin/env bash

# pandoc -t html texts/SPb.COVID-19.overview.md -o texts/SPb.COVID-19.overview.html
# pandoc -t html texts/SPb.COVID-19.data.sources.md -o texts/SPb.COVID-19.data.sources.html
# pandoc -t html texts/SPb.COVID-19.data_critique.md -o texts/SPb.COVID-19.data_critique.html
# pandoc -t html texts/SPb.COVID-19.r_report.md -o texts/SPb.COVID-19.r_report.html
sed -i 's/\.md/.html/g' texts/SPb.COVID-19.overview.html
sed -i 's/\.md/.html/g' texts/SPb.COVID-19.data.sources.html
sed -i 's/\.md/.html/g' texts/SPb.COVID-19.data_critique.html
sed -i 's/\.md/.html/g' texts/SPb.COVID-19.r_report.html
sed -i 's/<h1 class="title toc-ignore">Что важно знать гражданам Санкт-Петербурга об эпидемии коронавируса<\/h1>//g' texts/SPb.COVID-19.overview.html
sed -i 's/<h4 class="author">Алексей Куприянов<\/h4>//g' texts/SPb.COVID-19.overview.html
sed -i 's/<h1 class="title toc-ignore">COVID-19 в Петербурге, критический анализ показателей эпидемической статистики<\/h1>//g' texts/SPb.COVID-19.data_critique.html
sed -i 's/<h4 class="author">Алексей Куприянов<\/h4>//g' texts/SPb.COVID-19.data_critique.html
sed -i 's/<h1 class="title toc-ignore">COVID-19 в Петербурге, основные источники данных по эпидситуации<\/h1>//g' texts/SPb.COVID-19.data.sources.html
sed -i 's/<h4 class="author">Алексей Куприянов<\/h4>//g' texts/SPb.COVID-19.data.sources.html
sed -i 's/<h1 class="title toc-ignore">COVID-19 в Петербурге, сводный инфографический отчет<\/h1>//g' texts/SPb.COVID-19.r_report.html
sed -i 's/<h4 class="author">Алексей Куприянов<\/h4>//g' texts/SPb.COVID-19.r_report.html
