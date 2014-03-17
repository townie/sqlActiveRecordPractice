-- Mass Health challenge

--What 3 towns have the highest population of citizens that are 65 years and older?
select town from town_health_records
where total_population_2005 < 853535
ORDER BY population_greater_than_65_2005 DESC  LIMIT 3;

--What 3 towns have the highest population of citizens that are 19 years and younger?
select town from town_health_records where total_population_2005 < 853535
ORDER BY population_0_to_19_2005 DESC  LIMIT 3;

--What 5 towns have the lowest per capita income?
SELECT town FROM town_health_records ORDER BY per_capita_income_2000 limit 5 ;

--Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
SELECT town, percent_teen_births_2005_to_2008
FROM town_health_records
WHERE town != 'Boston' AND  town !=  'Becket' AND town != 'Beverly' AND id < 352 AND percent_teen_births_2005_to_2008 IS NOT NULL
ORDER BY percent_teen_births_2005_to_2008 DESC limit 1;

--Omitting Boston, what town has the highest number of infant mortalities?
SELECT town, total_infant_deaths_2005_to_2008  FROM town_health_records
WHERE (town != 'Boston' AND id < 352)
ORDER BY total_infant_deaths_2005_to_2008 DESC limit 1;

--Of the 5 towns with the highest per capita income,
--which one has the highest number of people below the poverty line?

SELECT town, per_capita_income_2000, persons_below_poverty_2000 FROM
(SELECT town, per_capita_income_2000, persons_below_poverty_2000
  FROM town_health_records ORDER BY per_capita_income_2000 DESC limit 5) AS foo
ORDER BY  persons_below_poverty_2000 DESC limit 1;

--Of the towns that start with the letter b, which has the highest population?
SELECT town, total_population_2005 FROM town_health_records WHERE town ILIKE 'b%' ORDER BY total_population_2005 DESC limit 1;

--Of the 10 towns with the highest percent publicly financed prenatal care,
--are any of them also the top 10 for total infant deaths?

SELECT town, percent_publicly_financed_prenatal_care_2005_to_2008, total_infant_deaths_2005_to_2008
FROM
  (SELECT town, percent_publicly_financed_prenatal_care_2005_to_2008, total_infant_deaths_2005_to_2008
  FROM town_health_records where percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL
  order by percent_publicly_financed_prenatal_care_2005_to_2008 DESC limit 10)
AS foo WHERE town in
  (SELECT town FROM town_health_records
  where total_infant_deaths_2005_to_2008 IS NOT NULL
  order by total_infant_deaths_2005_to_2008 DESC limit 10);

--Which town has the highest percent multiple births?

select town, percent_multiple_births_2005_to_2008 from town_health_records
where percent_multiple_births_2005_to_2008 is not null order by percent_multiple_births_2005_to_2008 desc limit 1;

--What is the percent adequacy of prenatal care in that town?

select town, percent_multiple_births_2005_to_2008, percent_adequacy_pre_natal_care from town_health_records
where percent_multiple_births_2005_to_2008 is not null order by percent_multiple_births_2005_to_2008 desc limit 1;


--Excluding towns that start with W, how many towns are part of this data?

SELECT count(town) FROM town_health_records WHERE town not ILIKE  'w%';

--How many towns have a lower per capita income that of Boston?
SELECT count(town) FROM town_health_records WHERE per_capita_income_2000 < (SELECT per_capita_income_2000 From town_health_records where town = 'Boston');


