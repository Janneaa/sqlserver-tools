SELECT DISTINCT
    DB_NAME() AS 'DBName',
    p.[name] AS 'PrincipalName',
    ISNULL(sp.name, '') AS 'LoginName',
    (CASE WHEN sp.is_disabled = 1 THEN 'Disabled'
        WHEN sp.is_disabled = 0 THEN 'Enabled'
        ELSE NULL
    END) AS 'LoginStatus',
    p.[type_desc] AS 'PrincipalType',
    p2.[name] AS 'GrantedBy',
    dbp.[state_desc] AS StateDescription,
    dbp.[permission_name] AS PermissionName,
    dbp.class_desc AS ClassDescription,
    (CASE
        WHEN class_desc = 'DATABASE' THEN DB_NAME(dbp.major_id)
        WHEN class_desc = 'SCHEMA' THEN SCHEMA_NAME(dbp.major_id)
        ELSE ''
	END) AS AppliesTo,
	dbp.major_id AS AppliesToID,
	ISNULL(SCHEMA_NAME(so.schema_id), '') AS 'ObjectSchema',
	ISNULL(so.[Name], '') AS 'ObjectName',
    ISNULL(so.[type_desc], '') AS 'ObjectType'
FROM [sys].[database_permissions] dbp
LEFT JOIN [sys].[objects] so
    ON dbp.[major_id] = so.[object_id]
LEFT JOIN [sys].[database_principals] p
    ON dbp.[grantee_principal_id] = p.[principal_id]
LEFT JOIN [sys].[database_principals] p2
    ON dbp.[grantor_principal_id] = p2.[principal_id]
LEFT JOIN sys.server_principals sp
    ON sp.sid = p.sid
WHERE p.name != 'public'
ORDER BY p.name, AppliesTo
