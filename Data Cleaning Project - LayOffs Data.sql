-- Data Cleaning

-- create a new schema - world_layoffs

--  import dataset from excel file with 2361 rows.

select * from layoffs;

-- the data containg the layoffs from around the world. It contains the comapany, locations, industry, total laid off, percentage laid off, date, stage, country and others.alter

-- The data cleaning steps

-- 1.  Remove Duplicates
-- 2.  Standardize the data
-- 3.  Null values and blank values
-- 4. Remove Any unwanted columns

-- 1. First step
-- Create a duplicate table call layoffs_staging. This is to take precaution in destroying the original table by mistakes

CREATE TABLE layoffs_staging
LIKE layoffs;

Select * from layoffs_staging;

-- 2. insert everything in layoffs table into layoffs_staging table

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- verify the insert command

Select * from layoffs_staging;

-- To remove project. The data does not contain foreign key so we need to add a row number

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date` ) AS row_nun
FROM layoffs_staging;

-- We want to filter by row number so that we can identify if there is any duplicates. We will do that
-- by creating a CTE statement

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date` ) AS row_nun
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_nun
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_nun > 1;

-- To verify if one of the comapny is actually a duplicate from the dataset result from the query above

SELECT *
FROM layoffs_staging
WHERE company = 'Oda';

-- Oda is not realy duplicate. So we dig further

-- updating the CTE query above with all the columns reveal that Oda is not part of the duplicated company

-- Checking if Casper is a duplicate

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

-- Casper is duplicated. So we need to remove one of those. Note, we cannot update a CTE table, so we have to work around this

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_nun
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_nun > 1;

-- the query above cannot delete any row from the cte so we need to create another table that containg the actual data

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_nun` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table layoffs_staging2 has been created with the statement above and one column , row_nun, is added to make it a duplicate of layoffs_staging
SELECT *
FROM layoffs_staging2;

-- Now we would insert all the data into this table.

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_nun
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_nun > 1;

-- Verifying if the duplicates information is correct

SELECT *
FROM layoffs_staging2
WHERE company = 'Cazoo';

-- Deleting the duplicates

DELETE
FROM layoffs_staging2
WHERE row_nun > 1;

SELECT *
FROM layoffs_staging2
WHERE row_nun > 1;

-- The duplicates are gone so we can do away with the row_nun column

-- Standardzing data

-- first, we need to trim the comapny column 

SELECT company, trim(company)
FROM layoffs_staging2;

-- We update with the trim results

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- Standadizing industry

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

-- Standardizing Location

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Standadized country

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United%'
ORDER BY 1;

SELECT DISTINCT country, trim(TRAILING '.' FROM country)
FROM layoffs_staging2
WHERE country LIKE 'United%'
ORDER BY 1;



-- Formating the date column to 

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

-- Change the text data type of `date` to DATE data type

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Working with null and blank values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

SELECT *
FROM layoffs_staging2
WHERE industry is NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry, t1.location, t2.location
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry is NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    SET t1.industry = t2.industry
WHERE t1.industry is NULL
AND t2.industry is NOT NULL;

-- THE UPDATE is not working so we need to set industry to null where they are blank

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    SET t1.industry= t2.industry
WHERE t1.industry is NULL
AND t2.industry is NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete row_nun column

ALTER TABLE layoffs_staging2
DROP COLUMN row_nun;
