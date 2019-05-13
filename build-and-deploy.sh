docker build -t kaushikchaubal/kube-playground .
docker login
docker push kaushikchaubal/kube-playground:latest
kubectl delete deployment kube-playground
kubectl delete svc kube-playground
kubectl apply -f kube-playground.yaml
sleep 5s
curl -i http://localhost:8080/