# To build and deploy to the public Docker repository

````
docker build --no-cache -t research-radar:current .

docker tag research-radar:current cientopolis/research-radar:latest

docker tag research-radar:current cientopolis/research-radar:[commit-hash]

docker push cientopolis/research-radar:latest

docker push cientopolis/research-radar:[commit-hash]
````

# To deploy / run

````
sudo docker pull cientopolis/memorias:latest

sudo docker compose down

sudo docker compose up -d
````

# About the data folder

The docker-compose file mounts a data folder. 

In the data folder you will find a research-radar.fuel file.

If missing, the research-radar.fuel file will be created.
