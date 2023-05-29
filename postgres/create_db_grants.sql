\c pg_demo_db;
GRANT ALL PRIVILEGES ON DATABASE pg_demo_db TO db_owner;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO db_user;