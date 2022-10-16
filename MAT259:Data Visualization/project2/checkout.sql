SELECT YEAR
 ( cout ),
 title,
 COUNT( 1 )  'checkouts'
FROM
 spl_2016.outraw 
WHERE
 ( INSTR( title, 'stock market' )> 0 OR INSTR( title, 'Tesla' )> 0 OR INSTR( title, 'Elon Musk' )> 0 OR INSTR( title, 'investment' )> 0 OR INSTR( title, 'Battery' )> 0 OR INSTR( title, 'stock' )> 0) 
 AND YEAR ( cout ) BETWEEN 2010 
 AND 2021 
GROUP BY
 YEAR ( cout ),
 title