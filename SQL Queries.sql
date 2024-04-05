# COVID VAC TABLE QUERIES #

select d.continent,d.location, d.population, max(v.people_vaccinated) as vaccinated, max(v.people_fully_vaccinated) As fullyVaccinated, (max(v.people_vaccinated)-max(v.people_fully_vaccinated)) as NotFullyVaccinated,
((max(v.people_fully_vaccinated/d.population)))*100 as PercentPopulatedFullyVaccinated
from covid_vacs v
join covid_deaths d on v.location = d.location and v.date = d.date 
group by d.location, d.population, d.continent
order by PercentPopulatedFullyVaccinated desc ;


with VacvsFully(continent, location, people_vaccinated, people_fully_vaccinated,population)
as
(
select v.continent, v.location, max(v.people_vaccinated), max(v.people_fully_vaccinated), max(d.population)
from covid_vacs v
join covid_deaths d on v.location = d.location and v.date = d.date
group by location, continent
)
select Sum(people_vaccinated), sum(people_fully_vaccinated), Sum(population)
from VacvsFully;


with vaccinations (continent,location,population,total_tests,total_vaccinations,total_boosters,people_vaccinated, people_fully_vaccinated, not_vaccinated)
as
(
Select v.continent,v.location,max(d.population), max(v.total_tests), max(v.total_vaccinations), max(v.total_boosters), max(v.people_vaccinated), max(v.people_fully_vaccinated),
(max(d.population)-max(v.people_vaccinated)) as not_vaccinated
from covid_vacs v
join covid_deaths d on v.location = d.location and v.date = d.date
group by v.location,v.continent
)
select sum(population) as population , sum(total_tests) as Total_tests ,sum(total_vaccinations) as total_vaccinations
,sum(total_boosters) as total_boosters,sum(people_vaccinated) as People_vaccinated,sum(people_fully_vaccinated) as people_fully_vaccinated, 
sum(not_vaccinated) as not_vaccinated
from vaccinations;
