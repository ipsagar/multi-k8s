docker build -t ipsagar/multi-client:latest -t ipsagar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ipsagar/multi-server:latest -t ipsagar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ipsagar/multi-worker:latest -t ipsagar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ipsagar/multi-client:latest
docker push ipsagar/multi-client:$SHA
docker push ipsagar/multi-server:latest
docker push ipsagar/multi-server:$SHA
docker push ipsagar/multi-worker:latest
docker push ipsagar/multi-worker:$SHA
kubectl apply -f K8s
kubectl set image deployments/server-deployment server=ipsagar/multi-server:$SHA
kubectl set image deployments/client-deployment client=ipsagar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ipsagar/multi-worker:$SHA
