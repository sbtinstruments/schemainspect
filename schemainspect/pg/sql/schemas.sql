with extension_oids as (
  select
      objid
  from
      pg_depend d
  WHERE
      d.refclassid = 'pg_extension'::regclass
      and d.classid = 'pg_namespace'::regclass
) select
    s.nspname as schema,
    roles.rolname as owner
from
    pg_catalog.pg_namespace s
    left outer join extension_oids e
    	on e.objid = oid
    left join pg_roles roles
      on s.nspowner = roles.oid
-- SKIP_INTERNAL where nspname not in ('pg_internal', 'pg_catalog', 'information_schema', 'pg_toast')
-- SKIP_INTERNAL and nspname not like 'pg_temp_%' and nspname not like 'pg_toast_temp_%'
order by 1;
