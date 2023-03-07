# Docker

This code has been tested with: https://www.docker.com/play-with-docker/

## 1. Using Docker

Build your image
```bash
# docker build --tag <my_image>:<my_tag> .
docker build --tag my-lovely-app:latest .
```

See all built images
```bash
docker images
```

Run your container
```bash
# docker run <my_image>:<my_tag>
docker run my-lovely-app:latest
```

Ah, but now we're using up a terminal (not ideal).

Let's run it in detached mode instead. We'll also expose the port so we can talk to the microservice from outside the container

```bash
# docker run --detach -it --publish <host_port>:<container_port> <my_image>:<my_tag>
docker run --detach -it --publish 8000:8000 my-lovely-app:latest
```

View running containers. Take a note of the container name e.g. agitated_albattani
```bash
docker ps
```

Execute code from within the running container
```
# docker exec -it <my_container> ls
docker exec -it agitated_albattani ls
```

Check the microservice is running (from inside the container)
```bash
# docker exec -it <my_container> python3 -c "import requests; print(requests.get('http://0.0.0.0:8000/').json())"
docker exec -it agitated_albattani python3 -c "import requests; print(requests.get('http://0.0.0.0:8000/').json())"

# docker exec -it <my_container> python3 -c "import requests; print(requests.get('http://0.0.0.0:8000/check').json())"
docker exec -it agitated_albattani python3 -c "import requests; print(requests.get('http://0.0.0.0:8000/check').json())"
```

Check the port is exposed properly  (from outside the container)
```bash
python3 -c "import requests; print(requests.get('http://localhost:8000/').json())"
```

To delete an image, you must first:
* Stop any containers  built from that image
* Delete any containers built from that image

Stop the running container
```bash
# docker stop <my_container>
docker stop agitated_albattani
```

View all containers (including stopped ones)
```bash
docker ps -a
```

Delete the container(s)
* There should be at least one container to delete
* There may be at least one other (if you ran the step where you ran the container not in detached mode) 

```bash
# docker rm <my_container>
docker rm agitated_albattani
```

Delete the image
```bash
# docker rmi <my_image>:<my_tag>
docker rmi my-lovely-app:latest
```

## 2. Using Docker Compose

The above steps can be automated with the use of a docker-compose file.

Bring up the container
```bash
docker compose up --detach --build
```

Check the port is exposed properly  (from outside the container)
```bash
python3 -c "import requests; print(requests.get('http://localhost:8000/').json())"
```

Tear down the container
```bash
docker compose down
```

## 3. Teardown

First, let's spin up a variety of containers and images

Git clone
```bash
git clone https://github.com/docker/awesome-compose.git
```

Change directory
```bash
cd awesome-compose
```

Run three microservices on ports 8001, 8002 and 8003
```bash
# Run "API" service as defined in:
# https://github.com/docker/awesome-compose/blob/master/fastapi/compose.yaml
cd fastapi
docker compose run --publish 8001:8000 --detach api
cd ..

# Run "web" service as defined in:
# https://github.com/docker/awesome-compose/blob/master/flask/compose.yaml
cd flask
docker compose run --publish 8002:8000 --detach web
cd ..

# Run "web" service as defined in:
# https://github.com/docker/awesome-compose/blob/master/django/compose.yaml
cd django
docker compose run --publish 8003:8000 --detach web
cd ..
```

Now you have a number of containers and images to manage, what a mess!

Delete all stopped containers and images not in use
```bash
docker system prune -a
```

What about deleting the running containers?

Delete all containers (running and stopped)
```bash
docker rm -f $(docker ps --all --quiet)
```

Delete all images
```bash
docker rmi $(docker images --all --quiet)
```
