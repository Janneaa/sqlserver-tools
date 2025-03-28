SELECT DP1.name AS DatabaseRoleName,
    ISNULL(sp.name, '') AS 'LoginName',
	(CASE
	    WHEN sp.is_disabled = 1 THEN 'Disabled'
		WHEN sp.is_disabled = 0 THEN 'Enabled'
		ELSE ''
	END) AS 'LoginStatus',
    ISNULL(DP2.name, '-') AS PrincipalName,
    DP2.type_desc AS PrincipalType
FROM sys.database_role_members AS DRM
RIGHT JOIN sys.database_principals AS DP1
    ON DRM.role_principal_id = DP1.principal_id
LEFT JOIN sys.database_principals AS DP2
    ON DRM.member_principal_id = DP2.principal_id
LEFT JOIN sys.server_principals sp
    ON sp.sid = DP2.sid
WHERE DP1.type = 'R'
    AND DP2.name IS NOT NULL
ORDER BY DP1.name, DP2.name
