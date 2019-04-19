docker build -t sumantatwm/multi-client:latest -t sumantatwm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sumantatwm/multi-server:latest -t sumantatwm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sumantatwm/multi-worker:latest -t sumantatwm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sumantatwm/multi-client:latest
docker push sumantatwm/multi-server:latest
docker push sumantatwm/multi-worker:latest

docker push sumantatwm/multi-client:$SHA
docker push sumantatwm/multi-server:$SHA
docker push sumantatwm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
