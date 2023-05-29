# Simple set of demo scripts to quickly start a Postgres environment for testing purposes

## Usage
`start-postgres.sh` will start a docker container with a postgres:11 server
`start-pgadmin.sh` will start a docker container with pgadmin4 (that connects with the postgres server)

`remove-container.sh [pg-local|pgadmin-local]` will stop and remove the container
`remove-containers.sh` will stop and remove both containers

## Users
`postgres` with pwd `postgres`
`db_owner` with pwd `db_owner`
`db_user` with pwd `db_user`

## Database
db: pg_demo_db
schema: public
table: demo_table

## Login to pgadmin
Use http://localhost:5050 with login: `info@occurro.nl` and pwd: `test` to login

## DBVisualizer
- added a recent postgres driver in `lib/postgresql-42.6.0.jar` (install in: tools -> driver manager)
- added example connections in `lib/dbvis-settings.jar`