use covid_portfolio ;
select * from coviddeath ;
select * from covidvaccinationsnew ;
select count(*) from covidvaccinationsnew ;
select count(*) from coviddeath ;

select * from coviddeath order by 3,4 ;

select location , `date` , total_cases , new_cases , total_deaths , population 
from coviddeath  where continent is not null;

-- looking at Total cases vs Total Deaths --
select location , `date` , total_cases ,  total_deaths , (total_deaths/total_cases)*100 as DeathPercentage
from coviddeath where continent is not null order by total_cases desc;

-- ordering it by desc to get the highest value in India --
select location , `date` , total_cases ,  total_deaths , (total_deaths/total_cases)*100 as DeathPercentageIndia
from coviddeath where location ='India' order by total_deaths desc; 

-- Looking at  Total cases vs Population  Globally
-- shows what percentage of population got covid
select location , total_cases , population , 
(total_cases/population)*100 as PercentPopulationInfected
from coviddeath ;
 
 -- Countries with Highest Infection Rate compared to Population
select location ,population, max(total_cases) as HighestInfectionCount ,  
max((total_cases/population))*100 as PercentPopulationInfected
from coviddeath where continent is not null group by location , population order by PercentPopulationInfected desc ;


-- Showing countries with Highest Death count per population 
select location , max(total_deaths) as TotalDeathCount from coviddeath
where continent is not null group by location  order by TotalDeathCount desc;

-- showing location with Highest Death Count per population & continent
select location , max(total_deaths) as TotalDeathCount from coviddeath
where continent is not null
group by location order by TotalDeathCount desc;


-- Global Numbers 
select location , `date` , total_cases, total_deaths , (total_deaths/total_cases)*100 as DeathPercentage from coviddeath
where continent is not null order by 1,3;
 
 -- new cases globally vs india
 
select all(location) ,`date`,new_cases,new_deaths,new_cases_per_million from coviddeath;
 
select location,`date`,new_cases,new_deaths,new_cases_per_million from coviddeath where location ='India' ;
 
-- Total cases Globally
select sum(total_cases) , sum(total_deaths) ,max(total_cases/total_deaths)*100 as DeathPercentage from coviddeath ;

-- Total cases in India 
select location,sum(total_cases) , sum(total_deaths) ,max(total_cases/total_deaths)*100 as DeathPercentage from coviddeath 
where location ='India' ;


select * from covidvaccinationsnew ;

-- Joining coviddeath and covidvaccination on location and date to be more specific

select * from coviddeath as dea join covidvaccinationsnew as vac
on dea.location = vac.location and dea.`date` = vac.`date` ;

select dea.continent , dea.location ,dea.`date`,dea.population , vac.new_vaccinations from coviddeath as dea join covidvaccinationsnew as vac
on dea.location = vac.location and dea.`date` = vac.`date` order by new_vaccinations desc ;

select location ,continent , `date` ,new_vaccinations from covidvaccinationsnew ;

-- Total Populations vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated 
From CovidDeath dea
Join covidvaccinationsnew vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3 ;

-- Using CTE to perform Calculation on Partition By in previous query

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists PercentPopulationVaccinated ;
Create Table if not exists PercentPopulationVaccinated
(
Continent char(255),
Location char(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric)
;



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinatednew as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations ,SUM(vac.new_vaccinations) OVER 
(Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeath dea
Join covidvaccinationsnew vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null ;

select * from PercentPopulationVaccinatednew



