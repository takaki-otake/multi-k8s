docker build -t swmn/multi-client-k8s:latest -t swmn/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t swmn/multi-server-k8s:latest -t swmn/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t swmn/multi-worker-k8s:latest -t swmn/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push swmn/multi-client-k8s:latest
docker push swmn/multi-server-k8s:latest
docker push swmn/multi-worker-k8s:latest

docker push swmn/multi-client-k8s:$SHA
docker push swmn/multi-server-k8s:$SHA
docker push swmn/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swmn/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=swmn/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=swmn/multi-worker-k8s:$SHA