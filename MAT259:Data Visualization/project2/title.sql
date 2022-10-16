select *
from spl_2016.outraw
where (
LOWER(title) like '% Elon Musk %'
or LOWER(title) like '% Tesla %'
or LOWER(title) like '% Panasonic %'
or LOWER(title) like '% Lithium Iron Phosphate %'
or LOWER(title) like '% Battery %'
or LOWER(title) like '% stock %'
or LOWER(title) like '% stock market %'
or LOWER(title) like '% investment %'
)AND YEAR(cout) BETWEEN 2010 AND 2021
