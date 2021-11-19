#!/bin/sh

# Build docker images
docker build -t mrmasson/complex-client:latest -t mrmasson/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t mrmasson/complex-server:latest -t mrmasson/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t mrmasson/complex-worker:latest -t mrmasson/complex-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to docker hub
docker push mrmasson/complex-client:latest
docker push mrmasson/complex-server:latest
docker push mrmasson/complex-worker:latest
docker push mrmasson/complex-client:$SHA
docker push mrmasson/complex-server:$SHA
docker push mrmasson/complex-worker:$SHA

# Apply K8s config
kubectl apply -f ./k8s

# Imperatively set latest image on each deployment
kubectl set image deployments/server-deployment server=mrmasson/complex-server:$SHA
kubectl set image deployments/client-deployment client=mrmasson/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=mrmasson/complex-worker:$SHA
