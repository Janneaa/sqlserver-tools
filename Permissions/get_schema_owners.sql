SELECT s.Name as SchemaName, u.name AS [Owner]
FROM sys.schemas s
INNER JOIN sys.sysusers u
    ON u.uid = s.principal_id
INNER JOIN sys.database_principals dp
    ON s.principal_id = dp.principal_id
WHERE s.Name NOT IN ('dbo', 'guest', 'sys', 'INFORMATION_SCHEMA')
    AND dp.type = 'S'
ORDER BY s.Name, u.name
