# Dockerized RubyCas

Run using `docker-compose build && docker-compose up -d`.

To tail logs: run `docker-compose logs -f -t`

### First time setup

For the first time running: 
  * `docker ps` to find the id of the MySQL container
  * `docker exec -it id bash` 
  * `mysql -u root -p`
  * Create the database & table as show by the query inside of `dump/dump.sql`