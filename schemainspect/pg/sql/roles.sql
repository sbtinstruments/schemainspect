WITH membership AS (
    SELECT 
        r.rolname,
        array_agg(r1.rolname) as memberships
    FROM
        pg_catalog.pg_roles r
        JOIN pg_catalog.pg_auth_members m
        ON m.member = r.oid
        JOIN pg_roles r1
        ON m.roleid = r1.oid
    GROUP BY
        r.rolname
)     
SELECT
    r.rolname,
    r.rolsuper,
    r.rolinherit,
    r.rolcanlogin,
    m.memberships
FROM
    pg_roles r
    LEFT JOIN membership m ON r.rolname = m.rolname;
    
