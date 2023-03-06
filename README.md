# Docker

This code has been tested with: https://www.docker.com/play-with-docker/

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
# This line is untested.
# python3 -c "import requests; print(requests.get('https://localhost:8000/').json())"
```

Stop the running container
```bash
# docker stop <my_container>
docker stop agitated_albattani
```

View all containers (including stopped ones)
```bash
docker ps -a
```

Delete the image
```bash
# docker rmi <my_image>:<my_tag>
docker rmi my-lovely-app:latest
```
