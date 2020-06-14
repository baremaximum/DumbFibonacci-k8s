docker image build -t baremaximum/dumbfibonacci-client:latest -t baremaximum/dumbfibonacci-client:$GIT_SHA -f ./client/Dockerfile ./client
docker image build -t baremaximum/dumbfibonacci-server:latest -t baremaximum/dumbfibonacci-server:$GIT_SHA -f ./server/Dockerfile ./server
docker image build -t baremaximum/dumbfibonacci-worker:latest -t baremaximum/dumbfibonacci-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push baremaximum/dumbfibonacci-client:latest
docker push baremaximum/dumbfibonacci-client:$GIT_SHA

docker push baremaximum/dumbfibonacci-server:latest
docker push baremaximum/dumbfibonacci-server:$GIT_SHA

docker push baremaximum/dumbfibonacci-worker:latest
docker push baremaximum/dumbfibonacci-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=baremaximum/dumbfibonacci-server:$GIT_SHA
kubectl set image deployments/client-deployment client=baremaximum/dumbfibonacci-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=baremaximum/dumbfibonacci-worker:$GIT_SHA
