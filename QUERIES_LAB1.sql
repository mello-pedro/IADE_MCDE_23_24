------- 1.

SELECT * FROM 
PRODUCTS;

------- 2.

SELECT LASTNAME, TITLE, COUNTRY, BIRTHDATE 
FROM EMPLOYEES;

------ 3.

SELECT PRODUCTID, PRODUCTNAME FROM
PRODUCTS
WHERE CATEGORYID IN (2,3) 
AND UNITPRICE > 10
AND QUANTITYPERUNIT LIKE '%bottles%'

------ 4.

SELECT PRODUCTID, PRODUCTNAME, QUANTITYPERUNIT FROM
PRODUCTS
WHERE (CATEGORYID = 8)
AND (QUANTITYPERUNIT LIKE '%250 g%' OR QUANTITYPERUNIT LIKE '%200 g%' OR QUANTITYPERUNIT LIKE '%500 g%');

------ 5.

SELECT PRODUCTID, 
PRODUCTNAME,
UNITPRICE,
(UNITPRICE * 1.23) AS FINALPRICE
FROM PRODUCTS
WHERE CATEGORYID IN (2,5)

------- 6.

SELECT PRODUCTID, 
PRODUCTNAME,
UNITPRICE,
UNITSINSTOCK,
(UNITPRICE * UNITSINSTOCK) AS STOCKVALUE
FROM PRODUCTS
WHERE CATEGORYID IN (2,5)

------- 7.

SELECT
    COMPANYNAME,
    CITY,
    ( CONTACTTITLE
      || CONTACTNAME ) AS CONTACTTITLEANDNAME
FROM
    SUPPLIERS
WHERE
    COUNTRY = 'USA';
ORDER BY CITY ASC;

-------- 8.

SELECT COUNT (PRODUCTNAME)
FROM PRODUCTS;

------- 9.
SELECT SUPPLIERID,
COUNT(PRODUCTID) AS PRODUCTSPERSUPPLIER
FROM PRODUCTS
GROUP BY SUPPLIERID
ORDER BY PRODUCTSPERSUPPLIER DESC;

------- 10.
SELECT CATEGORYID,
COUNT(PRODUCTID) AS PRODUCTSPERCATEGORY
FROM PRODUCTS
GROUP BY CATEGORYID
HAVING COUNT(PRODUCTID) >= 10
ORDER BY CATEGORYID DESC;

------- 11.
SELECT ORDERID,
COUNT (DISTINCT PRODUCTID)
FROM ORDERDETAILS
GROUP BY ORDERID
HAVING COUNT(PRODUCTID) > 5

------- 12.
SELECT PRODUCTS.PRODUCTNAME, PRODUCTS.CATEGORYID, PRODUCTS.SUPPLIERID,
SUPPLIERS.CITY, SUPPLIERS.COUNTRY, SUPPLIERS.COMPANYNAME
FROM PRODUCTS
INNER JOIN SUPPLIERS ON SUPPLIERS.SUPPLIERID = PRODUCTS.SUPPLIERID  
WHERE COUNTRY = 'France'
ORDER BY SUPPLIERS.CITY ASC, SUPPLIERS.COMPANYNAME ASC;

------- 13.
SELECT ORDERDETAILS.ORDERID, 
        COUNT (DISTINCT ORDERDETAILS.PRODUCTID) AS PRODUTOS, 
        ORDERS.SHIPCOUNTRY
FROM ORDERDETAILS
INNER JOIN ORDERS ON ORDERS.ORDERID = ORDERDETAILS.ORDERID 
WHERE SHIPCOUNTRY = 'Norway'
GROUP BY ORDERDETAILS.ORDERID, ORDERS.SHIPCOUNTRY
ORDER BY ORDERDETAILS.ORDERID ASC;

------- 14.
SELECT CITY, COUNTRY,
COUNT (EMPLOYEEID)
FROM EMPLOYEES
GROUP BY CITY, COUNTRY
ORDER BY COUNTRY ASC, CITY ASC;

------ 15.

SELECT ORDERDETAILS.ORDERID, 
ORDERS.ORDERDATE,
AVG(ORDERDETAILS.QUANTITY),
SUM (ORDERDETAILS.PRODUCTID),
PRODUCTS.PRODUCTNAME
FROM ORDERDETAILS
INNER JOIN ORDERS ON ORDERS.ORDERID = ORDERDETAILS.ORDERID
INNER JOIN PRODUCTS ON PRODUCTS.PRODUCTID = ORDERDETAILS.PRODUCTID
WHERE EXTRACT (YEAR FROM ORDERS.ORDERDATE) = 1997
GROUP BY ORDERDETAILS.PRODUCTID, ORDERDETAILS.ORDERID, ORDERS.ORDERDATE, PRODUCTS.PRODUCTNAME
HAVING AVG(ORDERDETAILS.QUANTITY) > 30;

-------- 16.

SELECT COUNT (*)
FROM ORDERS
INNER JOIN EMPLOYEES ON ORDERS.EMPLOYEEID = EMPLOYEES.EMPLOYEEID
INNER JOIN CUSTOMERS ON ORDERS.CUSTOMERID = CUSTOMERS.CUSTOMERID
INNER JOIN ORDERDETAILS ON ORDERS.ORDERID = ORDERDETAILS.ORDERID
INNER JOIN PRODUCTS ON ORDERDETAILS.PRODUCTID = PRODUCTS.PRODUCTID
INNER JOIN SUPPLIERS ON PRODUCTS.SUPPLIERID = SUPPLIERS.SUPPLIERID
WHERE CUSTOMERS.Country = EMPLOYEES.Country AND EMPLOYEES.Country = SUPPLIERS.Country

-------- 17.
SELECT CUSTOMERID, COMPANYNAME FROM
CUSTOMERS
WHERE CUSTOMERID NOT IN
(SELECT CUSTOMERID
FROM ORDERS);
