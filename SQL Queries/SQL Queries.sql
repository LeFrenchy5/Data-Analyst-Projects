---------------------------------
# Vaccinations Per Country #
---------------------------------
/* Calculates the Countries vaccinated, fully vaccinated for Covid-19. Using population and fully vaccinated 
we calculate the percentage of the population that have recieved the full vaccination in each country. */

select d.continent,d.location, d.population, max(v.people_vaccinated) as vaccinated, max(v.people_fully_vaccinated) As fullyVaccinated, greatest(max(d.population)-max(v.people_fully_vaccinated),0) as NotFullyVaccinated,
((max(v.people_fully_vaccinated/d.population)))*100 as PercentPopulatedFullyVaccinated
from covid_vacs v
join covid_deaths d on v.location = d.location and v.date = d.date 
group by d.location, d.population, d.continent
order by PercentPopulatedFullyVaccinated desc;

---------------------------------
# Global Vaccinations Numbers For Covid-19
---------------------------------
/* Using a CTE to calculate the global vaccinated, fully vaccinated and population.
Taking the max value for each countries people_vaccinated, fully_vaccinated and population,
using a CTE called VacsvsFully to sum all the locations max values to get a final global value */

with VacvsFully(continent, location, people_vaccinated, people_fully_vaccinated,population)
as
(
	select v.continent, v.location, max(v.people_vaccinated), max(v.people_fully_vaccinated), max(d.population)
	from covid_vacs v
	join covid_deaths d on v.location = d.location and v.date = d.date
	group by location, continent
)
select Sum(people_vaccinated) as Global_Vaccination, sum(people_fully_vaccinated) as Global_fully_vaccinated, Sum(population) as Global_population
from VacvsFully;

---------------------------------
# Global Values
---------------------------------
/* Using a CTE to sum the max population, total_tests, total_vaccinations, total_boosters
people_vaccinated, fully_vaccinated and using population and vaccinated to calculate people that are not vaccinated at all for each country,   */
with vaccinations (continent,location,population,total_tests,total_vaccinations,total_boosters,people_vaccinated, people_fully_vaccinated, not_vaccinated)
as
(
	Select v.continent,v.location,max(d.population), max(v.total_tests), max(v.total_vaccinations), max(v.total_boosters), max(v.people_vaccinated), max(v.people_fully_vaccinated),
	(max(d.population)-max(v.people_vaccinated)) as not_vaccinated
	from covid_vacs v
	join covid_deaths d on v.location = d.location and v.date = d.date
	group by v.location,v.continent
)
select sum(population) as population , sum(total_tests) as Global_tests ,sum(total_vaccinations) as Global_vaccinations
,sum(total_boosters) as Global_boosters,sum(people_vaccinated) as Global_vaccinated,sum(people_fully_vaccinated) as Global_fully_vaccinated, 
sum(not_vaccinated) as Global_not_vaccinated
from vaccinations;

---------------------------------
# Global Numbers Per Year 2020-2024 (January)
---------------------------------
/* Using a CTE global_num to calculate the total global deaths , cases , vaccinations and population per year, 
from 2020 till January 2024.*/

With global_num(location, year, population, deaths,cases,vaccinations)
as
(
	select d.location, year(d.date) as year, max(d.population), sum(d.new_deaths) , sum(d.new_cases), sum(v.new_vaccinations)
	from covid_deaths d 
	join covid_vacs v 
	on d.date = v.date and d.location = v.location
	group by d.location, year(d.date)
)
select year, sum(population) as population, sum(deaths) as deaths ,sum(cases) as cases ,sum(vaccinations) as vaccinations
from global_num
group by year;

---------------------------------
# Countries Hospital vs ICU Patients
---------------------------------
/* Calculate the total cases, hospital patients and icu patients. 
Calculating the percentage of cases hospitalized by dividing hosp_patients by total_cases
and calculating the percentage of hospital patients in the ICU by dividing icu_patients by hosp_patients. */

select continent,location , max(total_cases) as total_cases, sum(hosp_patients) as total_hospital_patients,sum(icu_patients) as Total_ICU_patients,
	(sum(hosp_patients)/max(total_cases))*100 as Percent_of_Cases_hosp,
	(sum(icu_patients)/sum(hosp_patients))*100 as Percent_Hosp_patients_ICU
from covid_deaths
group by location, continent
order by Percent_Hosp_patients_ICU desc;

---------------------------------
# Comparing Population Density to New Cases Per Country
---------------------------------
/* Calculate the new_cases and the rolling total cases per week (using partition) to compare 
to population density per country */

select continent, location, date, population, population_density, new_cases,
sum(new_cases) over (partition by location order by location,date) as Rolling_Total_Cases
from covid_deaths;

---------------------------------
# Comparing GDP to Vaccinations over Time per Country
---------------------------------
/* Calculate new_vaccinations and rolling vaccinations (using partition)
to compare GDP per capita per country*/

select d.continent, d.location, d.date, d.population, d.gdp_per_capita, new_vaccinations,
sum(new_vaccinations) over (partition by d.location order by d.location, d.date) as rolling_vacs
from covid_deaths d 
join covid_vacs v on d.location = v.location and d.date = v.date;


