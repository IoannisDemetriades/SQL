--Intro to SQLite 
--SQL returns values in tables
--Each column has one data type ONLY

Select * FROM recent_grads LIMIT 3 --seletcs 3 rows and all the columns ;
SELECT Major, ShareWomen FROM recent_grads --selects specific columns;
SELECT Major, ShareWomen FROM recent_grads WHERE ShareWomen < 0.5 -- selects columns with condition ;

SELECT Major, Major_category, Median, ShareWomen 
FROM recent_grads 
WHERE ShareWomen > 0.5 AND Median  > 50000 --using boolean condition and ;

SELECT Major, Major_category, ShareWomen, Unemployment_rate From recent_grads
WHERE (Major_category == "Engineering") AND (Women > Men OR Unemployment_rate < 5.1)
--boolean condition with parenthesis ;

SELECT Major, ShareWomen, Unemployment_rate FROM recent_grads
WHERE (ShareWomen > 0.3) AND (Unemployment_rate < 0.1)
ORDER BY ShareWomen DESC --return columns in descending order with respect to ShareWomen column ;

SELECT MIN(ShareWomen) FROM recent_grads --returns a table of 1 column with label ShareWomen and the minimum value ;


--Aggregarion Functions apply over a column and return A value in the form of a column
--Aggregation functions ignore Null values
SELECT MAX(ShareWomen) FROM recent_grads; --other examples are : AVG, COUNT, SUM...

SELECT COUNT(Major) FROM recent_grads
WHERE ShareWomen < 0.5; --aggregation function with boolean condition
SELECT COUNT(*), COUNT(Unemployment_rate) FROM recent_grads; --shows a 1x2 table with rows of all the file and rows of Unemployment_rate column

--ALLIAS
--Giving temporary name to table or columns, actual name in database is unchanged
SELECT COUNT(*) AS "Number of Majors", MAX(Unemployment_rate) AS Highest_Unemployment_Rate FROM recent_grads; --creating ALLIAS, when there are spaces use "" else, not needed

SELECT COUNT(DISTINCT Major) AS unique_majors,
    COUNT(DISTINCT Major_category) AS unique_major_categories, 
    COUNT(DISTINCT Major_code) AS unique_major_codes
    FROM recent_grads; --counts dinstinct values for each column

--Functions
--Take a column as an input and return another column
SELECT 'Cat: ' || Major_category, LENGTH(Major_category) AS size
  FROM recent_grads
  LIMIT 2; --combines 'Cats:' with content in Major_category column -> SELECT 'Data' || 'quest' as 'e-learning'; returns table with content a value = Dataquest
           --prints size of content for Major_category column before adding'Cats:'

--CASE-WHEN-THEN
--if-elif-else condition 
SELECT major, Sample_size, 
CASE
    WHEN Sample_size < 200 THEN 'Small'
    WHEN Sample_size < 1000 THEN 'Medium'
    ELSE 'Large'
    END AS Sample_category
    FROM recent_grads;
    
--GROUP BY
--Grouping and applyign an aggregation/function based on a certain column
SELECT Major_category, SUM(Total) AS Total_graduates
    From recent_grads
GROUP BY Major_category; --Can even GROUP BY  more than one categories

--Using a sub-set of the data/Filtering rows
--WHEN cannot be used, instead HAVING is used
--ROUND(), rounds to decimal place
SELECT Major_category, ROUND(AVG(Low_wage_jobs)/AVG(Total),2) AS Share_low_wage
FROM new_grads
GROUP BY Major_category
HAVING Share_low_wage > 0.1
ORDER BY Share_low_wage; --'Share_low_wage' is used to locate column

--CAST() -> changes type 
SELECT Major_category, CAST(SUM(Women) AS Float)/CAST(SUM(Total) AS Float) AS SW
FROM new_grads
GROUP BY Major_category
ORDER BY  SW;


--SubQueries
SELECT COUNT(*),
       (SELECT COUNT(*)
          FROM recent_grads
       )
  FROM recent_grads
 WHERE ShareWomen > (SELECT AVG(ShareWomen)
                       FROM recent_grads
                    );--prints a table with count of rows > AVG(ShareWomen) and count of all rows