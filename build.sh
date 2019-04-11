#!/usr/bin/env sh

SERVER_NAME=eureka-server

./gradlew build

sudo $(aws ecr get-login --no-include-email --region cn-northwest-1)
sudo docker build -t $SERVER_NAME .
sudo docker tag $SERVER_NAME:latest 076880417388.dkr.ecr.cn-northwest-1.amazonaws.com.cn/$SERVER_NAME:latest
sudo docker push 076880417388.dkr.ecr.cn-northwest-1.amazonaws.com.cn/$SERVER_NAME:latest

kubectl delete -f k8s-deployment.yml --kubeconfig $KUBE_CONFIG
kubectl create -f k8s-deployment.yml --kubeconfig $KUBE_CONFIG
