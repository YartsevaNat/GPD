-- Здесь мы фильтруем статьи по URL-у
SELECT *
FROM `gdelt-bq.gdeltv2.events`
WHERE SOURCEURL like "%yellow-vest%"
LIMIT 100 


-- То же самое, но только на сайте CNN
SELECT *
FROM `gdelt-bq.gdeltv2.events`
WHERE SOURCEURL LIKE 'https://edition.cnn.com/%yellow-vest%'
LIMIT 100 


-- Запрос из статьи GDELT: сравнение упоминаний России и Китая в теленовостях
-- https://blog.gdeltproject.org/tracking-country-mentions-using-television-ngrams-china-vs-russia/
SELECT DATE, China, Russia from (
SELECT DATE, sum(COUNT) China, 0 Russia FROM `gdelt-bq.gdeltv2.iatv_1gramsv2` where STATION='CNN' and (NGRAM='china' OR NGRAM='chinese' OR NGRAM='beijing') group by DATE
UNION ALL
SELECT DATE, 0 China, sum(COUNT) Russia FROM `gdelt-bq.gdeltv2.iatv_1gramsv2` where STATION='CNN' and (NGRAM='russia' OR NGRAM='russian' OR NGRAM='moscow' OR NGRAM='kremlin' OR NGRAM='putin') group by DATE
) order by DATE asc

