CONTAINER_NAME_PG=pg-local
CONTAINER_NAME_PGADMIN=pgadmin-local
POSTGRES_PASSWORD=postgres
POSTGRES_VERSION=11

SCRIPT_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

$SCRIPT_DIR/remove-container.sh $CONTAINER_NAME_PG
$SCRIPT_DIR/remove-container.sh $CONTAINER_NAME_PGADMIN
docker run --name $CONTAINER_NAME_PG -p 5432:5432 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -d postgres:$POSTGRES_VERSION

# Give the container some time to get started
sleep 10

docker cp $SCRIPT_DIR/create_db_users.sql $CONTAINER_NAME_PG:/docker-entrypoint-initdb.d/create_db_users.sql
docker cp $SCRIPT_DIR/create_db.sql $CONTAINER_NAME_PG:/docker-entrypoint-initdb.d/create_db.sql
docker cp $SCRIPT_DIR/create_db_grants.sql $CONTAINER_NAME_PG:/docker-entrypoint-initdb.d/create_db_grants.sql
docker cp $SCRIPT_DIR/create_table.sql $CONTAINER_NAME_PG:/docker-entrypoint-initdb.d/create_table.sql
docker cp $SCRIPT_DIR/insert.sql $CONTAINER_NAME_PG:/docker-entrypoint-initdb.d/insert.sql

docker exec -u postgres $CONTAINER_NAME_PG psql postgres postgres -f /docker-entrypoint-initdb.d/create_db_users.sql
docker exec -u postgres $CONTAINER_NAME_PG psql postgres db_owner -f /docker-entrypoint-initdb.d/create_db.sql
docker exec -u postgres $CONTAINER_NAME_PG psql pg_demo_db db_owner -f /docker-entrypoint-initdb.d/create_table.sql
docker exec -u postgres $CONTAINER_NAME_PG psql pg_demo_db db_owner -f /docker-entrypoint-initdb.d/create_db_grants.sql
docker exec -u postgres $CONTAINER_NAME_PG psql pg_demo_db db_owner -f /docker-entrypoint-initdb.d/insert.sql
