#What 3 towns have the highest population of citizens that are 65 years and older?mass
TownHealthRecord.where('total_population_2005 < 853535').order('population_greater_than_65_2005 DESC' ).limit(3).pluck("town")


#--What 3 towns have the highest population of citizens that are 19 years and younger?

TownHealthRecord.where('total_population_2005 < 853535').order('population_0_to_19_2005 DESC').limit(3).pluck("town")

#--What 5 towns have the lowest per capita income?


TownHealthRecord.order('per_capita_income_2000').limit(5).pluck('town')


#--Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
TownHealthRecord.where("town != 'Boston' AND  town !=  'Becket' AND town != 'Beverly' AND id < 352 AND percent_teen_births_2005_to_2008 IS NOT NULL").order("percent_teen_births_2005_to_2008 DESC").limit(1).pluck("town")



#--Omitting Boston, what town has the highest number of infant mortalities?
TownHealthRecord.where("town != 'Boston' AND id < 352").order('total_infant_deaths_2005_to_2008 DESC').limit(1).pluck('town, total_infant_deaths_2005_to_2008')

TownHealthRecord.

#--Of the 5 towns with the highest per capita income,
#--which one has the highest number of people below the poverty line?

TownHealthRecord.select('town').where(town: TownHealthRecord.select('town').order(" per_capita_income_2000 DESC").
  limit(5)).order('persons_below_poverty_2000 DESC').limit(1)

#--Of the towns that start with the letter b, which has the highest population?

TownHealthRecord.select('town').where("town ILIKE 'b%'").order('total_population_2005 DESC').limit(1)

# --Of the 10 towns with the highest percent publicly financed prenatal care,
# --are any of them also the top 10 for total infant deaths?

TownHealthRecord.select('town').where(town: TownHealthRecord.select('town').where("percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL").
  order("percent_publicly_financed_prenatal_care_2005_to_2008 DESC ").limit(10)).where(town: TownHealthRecord.select('town').where("total_infant_deaths_2005_to_2008 IS NOT NULL").order("total_infant_deaths_2005_to_2008 DESC").limit(10))


#--Which town has the highest percent multiple births?
TownHealthRecord.select("town").where("percent_multiple_births_2005_to_2008 is not null").order("percent_multiple_births_2005_to_2008 desc").limit(1)


#--What is the percent adequacy of prenatal care in that town?
TownHealthRecord.select('percent_adequacy_pre_natal_care').where("percent_multiple_births_2005_to_2008 is not null ").order("percent_multiple_births_2005_to_2008 desc").limit(1).pluck('percent_adequacy_pre_natal_care')

#--Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.where("town not ILIKE  'w%'").count('town')

#--How many towns have a lower per capita income that of Boston?
TownHealthRecord.where("per_capita_income_2000 < (SELECT per_capita_income_2000 From town_health_records where town = 'Boston')").count('town')



