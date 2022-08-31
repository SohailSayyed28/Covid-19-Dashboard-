use covid_portfolio ;
select * from coviddeath ;
-- 1. For global location

Select SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, 
SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
-- Where location like '%states%'
where continent is not null ;
-- Group By date 


-- 2. For location India 

Select SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, 
SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
Where location = 'India' and continent is not null ;
-- Group By date 


-- 3. We take these out as they are not inluded in the above queries and want to stay consistent
-- continent is not null and location not in World , European Union , International

Select location, SUM(new_deaths) as TotalDeathCount
From coviddeath
Where continent is not null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc ;


-- 4. Highest Infection Count vs Percent Population Infected 

Select Location, Population, MAX(total_cases) as HighestInfectionCount, 
 Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
-- Where location like '%states%'
Group by Location, Population 
order by PercentPopulationInfected desc ;

-- 5.
Select location, SUM(new_deaths) as TotalDeathCount , MAX(total_cases) as HighestInfectionCount ,
Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
Where continent is not null 
and location = 'India'
Group by location
order by TotalDeathCount desc ;
 
 
-- 6.
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  
Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
-- Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc ;


-- 7.
Select Location, date, population, total_cases, total_deaths
From coviddeath
-- Where location like '%states%'
where continent is not null 
order by 1,2;


-- 8. Total Vaccination for China (as it is with the highest population)
Select  dea.location, dea.date, dea.population
, MAX(vac.total_vaccinations) as TotalVaccinationGiven
-- , (RollingPeopleVaccinated/population)*100
From coviddeath dea
Join CovidVaccinationsnew vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.location = 'China' 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3 ;

