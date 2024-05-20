-- Exploratory Data Analysis

SELECT *
FROM
layoffs_staging2;

SELECT max(total_laid_off), max(percentage_laid_off)
FROM
layoffs_staging2;

SELECT *
FROM
layoffs_staging2
WHERE percentage_laid_off = 1
order by funds_raised_millions desc;

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT min(`date`), max(`date`)
FROM layoffs_staging2;



SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
group by industry
order by 2 desc;


SELECT country, sum(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc;

SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by YEAR(`date`)
order by 2 desc;

SELECT substring(`date`,6,2) as `MONTH`,  sum(total_laid_off)
FROM  layoffs_staging2
group by `MONTH`;

SELECT substring(`date`,1,7) as `MONTH`,  sum(total_laid_off)
FROM  layoffs_staging2
WHERE substring(`date`,1,7)
group by `MONTH`
order by 1 asc;

with Rolling_Total as 
(
SELECT substring(`date`,1,7) as `MONTH`,  sum(total_laid_off) AS total_off
FROM  layoffs_staging2
WHERE substring(`date`,1,7)
group by `MONTH`
order by 1 asc
)
select `MONTH`, 
total_off,sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_Total;

SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company, YEAR(`date`)
order by company, YEAR(`date`) asc;