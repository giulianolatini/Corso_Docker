echo "supersecretpassword" | docker secret create db_password -

docker stack deploy -c docker-compose.yml demo