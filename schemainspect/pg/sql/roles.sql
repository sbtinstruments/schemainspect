select
    rolname,
    rolsuper,
    rolinherit,
    rolcanlogin
FROM pg_roles
ORDER BY oid;