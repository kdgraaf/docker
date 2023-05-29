CONTAINER_NAME_PG=pg-local
CONTAINER_NAME_PGADMIN=pgadmin-local

SCRIPT_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

$SCRIPT_DIR/remove-container.sh $CONTAINER_NAME_PG
$SCRIPT_DIR/remove-container.sh $CONTAINER_NAME_PGADMIN