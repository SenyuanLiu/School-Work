SELECT YEAR(cout) as 'Year',
sum(CASE WHEN  instr(title, 'car' )>0 THEN   1 ELSE 0    END )'car', 
sum(CASE WHEN  instr(title, 'vehicle' )>0 THEN   1 ELSE 0    END )'vehicle',
sum(CASE WHEN  instr(title, 'automotive' )>0 THEN   1 ELSE 0    END )'automotive',
sum(CASE WHEN  instr(title, 'challenger' )>0 THEN   1 ELSE 0    END )'challenger' ,
sum(CASE WHEN instr(title, 'mustang' )>0 THEN   1 ELSE 0    END )'mustang',
sum(CASE WHEN instr(title, 'honda' )>0 THEN   1 ELSE 0    END )'honda',
sum(CASE WHEN  instr(title, 'volkswagon' )>0 THEN   1 ELSE 0    END )'volkswagen',
sum(CASE WHEN  instr(title, 'car repair' )>0 THEN   1 ELSE 0    END )'car repair',
sum(CASE WHEN  instr(title, 'maintenance' )>0 THEN   1 ELSE 0    END )'maintenance',
sum(CASE WHEN  instr(title, 'mechanic' )>0 THEN   1 ELSE 0    END )'mechanic'
 from  outraw 
 GROUP BY YEAR(cout)