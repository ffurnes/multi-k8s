docker build -t furbo85/multi-client:latest -t furbo85/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t furbo85/multi-server:latest -t furbo85/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t furbo85/multi-worker:latest -t furbo85/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push furbo85/multi-client:latest
docker push furbo85/multi-server:latest
docker push furbo85/multi-worker:latest

docker push furbo85/multi-client:$SHA
docker push furbo85/multi-server:$SHA
docker push furbo85/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=furbo85/multi-server:$SHA
kubectl set image deployments/client-deployment client=furbo85/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=furbo85/multi-worker:$SHA