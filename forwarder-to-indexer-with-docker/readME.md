
Commands:
1. docker-compose build
2. docker-compose up

Or combined: docker-compose up --build

Then go to localhost:8000 and insert in the SPL query: index="syslog-index"
You should see different kind of messages (system, cron etc').


When you finish: 
docker-compose down -v