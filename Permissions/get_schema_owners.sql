SELECT s.Name as SchemaName, u.name AS [Owner]
FROM sys.schemas s
INNER JOIN sys.sysusers u
    ON u.uid = s.principal_id
WHERE s.Name NOT IN ('dbo', 'guest', 'sys', 'INFORMATION_SCHEMA')
	AND s.Name NOT LIKE 'db[_]%'
ORDER BY s.Name, u.name