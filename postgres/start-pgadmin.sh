CONTAINER_NAME_PG=pg-local
CONTAINER_NAME_PGADMIN=pgadmin-local
PG_EMAIL=info@occurro.nl
PG_PWD=test

./remove-container.sh $CONTAINER_NAME_PGADMIN
IP_POSTGRES=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME_PG) &>/dev/null 2>&1
if [ -z "$IP_POSTGRES" ]
then
  echo "PostgreSQL container $CONTAINER_NAME_PG not found, exiting"
  exit 1
else
  echo "IP Address of PostgreSQL container: $IP_POSTGRES"
fi

docker run --name $CONTAINER_NAME_PGADMIN -p 5050:80 -e "PGADMIN_DEFAULT_EMAIL=$PG_EMAIL" -e "PGADMIN_DEFAULT_PASSWORD=$PG_PWD"  -d dpage/pgadmin4

# Give the container some time to get started
while [ -z "$CONTAINER" ]
do
  sleep 1
  CONTAINER=$(docker ps | grep $CONTAINER_NAME_PGADMIN)
done

sed "s/HOSTNAME/$IP_POSTGRES/g" servers.json > servers.tmp
docker cp servers.tmp $CONTAINER_NAME_PGADMIN:/pgadmin4/servers.json
rm servers.tmp

echo "PG Admin container started, use http://localhost:5050 with login: $PG_EMAIL and pwd: $PG_PWD to login"
