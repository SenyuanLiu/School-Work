select (YEAR(cout)) AS year, COUNT(*) AS count
from spl_2016.outraw 
where (
LOWER(title) like '% car %'
or LOWER(title) like '% automotive %'
or LOWER(title) like '% honda %'
or LOWER(title) like '% mustang %'
or LOWER(title) like '% challenger %'
or LOWER(title) like '% volkswagon %'
or LOWER(title) like '% subaru %'
) 
GROUP BY YEAR(cout)
ORDER BY YEAR(cout)
