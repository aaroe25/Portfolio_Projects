--Review tables
SELECT *
FROM portfolioproject-443701.COVID.CovidDeaths
ORDER BY 3,4;

SELECT *
FROM portfolioproject-443701.COVID.CovidVaccinations
ORDER BY 3,4;

-- Select data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolioproject-443701.COVID.CovidDeaths
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths (Shows likelihood of dying if you contract COCID in your country)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths at specific sountry
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE location = 'United States'
ORDER BY 1,2;

-- Looking at Total Cases vs Total Population worldwide (Shows what percentage of population got COVID)
SELECT location, date, population, total_cases, (total_cases/population)*100 AS contraction_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
ORDER BY 1,2;

-- Looking at Total Cases vs Total Population in the United States
SELECT location, date, population, total_cases, (total_cases/population)*100 AS infected_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE location = 'United States'
ORDER BY 1,2;

--Looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population))*100 AS percentage_population_infected
FROM portfolioproject-443701.COVID.CovidDeaths
GROUP BY location, population
ORDER BY percentage_population_infected DESC;

-- Let's break things down by continent (Showing continents with the highest death count per population)
SELECT location, MAX(total_deaths) AS total_deaths_count
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_deaths_count DESC;

-- Showing countries with the highest deaths count per population
SELECT location, MAX(total_deaths) AS total_deaths_count
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths_count DESC;

-- Global numbers (per day)
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Global numbers (total)
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM portfolioproject-443701.COVID.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

--Joining CovidDeaths and CovidVaccinations tables
SELECT *
FROM portfolioproject-443701.COVID.CovidDeaths AS dea
JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date;

-- Looking at Total Population vs Vaccinations
SELECT dea.continent, dea. location, dea.date, dea.population, vac.new_vaccinations
FROM portfolioproject-443701.COVID.CovidDeaths AS dea
JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

SELECT dea.continent, dea. location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM portfolioproject-443701.COVID.CovidDeaths AS dea
JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

SELECT dea.continent, dea. location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM portfolioproject-443701.COVID.CovidDeaths AS dea
JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Use CTE (common table expression)
WITH popvsvac AS (
  SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
         SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
  FROM portfolioproject-443701.COVID.CovidDeaths AS dea
  JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
  ON dea.location = vac.location
  AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL
)
SELECT continent, location, date, population, new_vaccinations, rolling_people_vaccinated, (rolling_people_vaccinated/population)*100 AS percent_population_vaccinated
FROM popvsvac
ORDER BY location, date;

--Creating View to store data for later visualizations
CREATE VIEW `portfolioproject-443701.COVID.percent_population_vaccinated` AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM portfolioproject-443701.COVID.CovidDeaths AS dea
JOIN portfolioproject-443701.COVID.CovidVaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac.date;


