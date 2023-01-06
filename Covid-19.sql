--select data

select * From CovidProject..CovidDeaths
where continent is not null
order by 3,4;

select * From CovidProject..CovidVaccinations
where continent is not null
order by 3,4;

-- Total Cases VS Total Deaths(likelihood of dying due to covid in each country)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPrecentage
From CovidProject..CovidDeaths
where continent is not null
order by 1,2;

-- Total Cases VS Population(% of population got covid)

select location, date, total_cases, population, (total_cases/population)*100 as PrecentageforCovid
From CovidProject..CovidDeaths
where continent is not null
order by 1,2;

--Countries with highest infection rate wrt population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) as PrecentageforCovid
From CovidProject..CovidDeaths
where continent is not null
group by location, population
order by PrecentageforCovid DESC;


--Continents with highest death count wrt population (by location)
select location, MAX(cast(total_deaths as int)) as TotalDeathCount 
From CovidProject..CovidDeaths
where continent is null and not location like '%income%'
group by location
order by TotalDeathCount DESC;


--Countries with highest death count wrt population (by income status)
select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidProject..CovidDeaths
where continent is null and location like '%income%' 
group by location
order by TotalDeathCount DESC;


--Golbal Numbers
select , SUM(new_cases) as new_cases_that_day, -- i.e. total_cases
SUM(cast(new_deaths as int)) as new_deaths_that_day, --i.e. total_deaths
(SUM(cast(new_deaths as int))/SUM(new_cases))*100 as DeathPrecentage
From CovidProject..CovidDeaths
where continent is not null
group by date
order by 1,2;

--Total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) 

From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccinations vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
order by 2,3;