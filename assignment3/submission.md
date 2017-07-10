*WE DONT NEED TO SUBMIT THIS FILE. THIS IS JUST FOR THE CURIOUS*

# Docker

```
sudo docker build -t frontend:latest .

sudo docker build -t backend:latest .

docker login gitlab-registry.tubit.tu-berlin.de

docker build -t gitlab-registry.tubit.tu-berlin.de/jensk/cc17-docker-registry/backend .

docker push gitlab-registry.tubit.tu-berlin.de/jensk/cc17-docker-registry/backend

docker build -t gitlab-registry.tubit.tu-berlin.de/jensk/cc17-docker-registry/frontend .

docker push gitlab-registry.tubit.tu-berlin.de/jensk/cc17-docker-registry/frontend
```

