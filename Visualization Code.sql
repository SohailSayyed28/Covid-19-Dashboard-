-- Queries used for Visualizing Project

use covid_portfolio ;

-- 1 .
Select SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, SUM(new_deaths )/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
-- Where location like '%states%'
where continent is not null 
-- Group By date
order by 1,2 ;

-- 2. 

Select location, SUM(new_deaths ) as TotalDeathCount
From coviddeath
-- Where location like '%states%'
Where continent is not null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc ;


-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
-- Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc ;


-- 4.

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeath
-- Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc ;

-- 5.

Select dea.continent, dea.location, dea.date, dea.population
, MAX(vac.total_vaccinations) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From coviddeath dea
Join CovidVaccinationsnew vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3 ;

-- 6.

Select SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, 
SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
-- Where location like '%states%'
where continent is not null 
-- Group By date
order by 1,2 ;

-- 7.

Select location ,SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, 
SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From coviddeath
-- Where location like '%states%'
where continent is not null and location = 'India'
-- Group By date
order by 1,2