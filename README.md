## Section A: Node.js server on Docker and K8s using YAML

1. Create server.js

Copy paste the following in `server.js`

```
const express = require('express')
const app = express()
const port = 8080

app.get('/', (req, res) => res.send('Hello World from KC'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
```

2. Create a node app

Run the following commands

```
npm init
npm install express --save
npm start // to confirm if everything is working as expected
```

3. Create Dockerfile

Cope paste the following in `Dockerfile`

```
FROM node:8.1.0-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

EXPOSE 8080
CMD [ "npm", "start" ]
```

4. Build, view and run the Docker image

Run the following commands

```
docker build -t kaushikchaubal/kube-playground .
docker images
docker run -p 8080:8080 kaushikchaubal/kube-playground:latest // This exposes it to port 8080
```

5. Push to dockerhub

Run the following commands

```
docker login
docker push kaushikchaubal/kube-playground:latest // Pushes this to DockerHub
```

6. Run using Kubernetes

Run the following commands

```
kubectl apply -f kube-playground.yaml 
```

**Note**: In case you want to run the equivalent commands, type in:

```
kubectl run kube-playground --replicas=5 --image=kaushikchaubal/kube-playground:latest --port=8080
kubectl expose deployment kube-playground --type=LoadBalancer --name=kube-playground
```

**Note**: For clean-up, run the following commands

```
kubectl delete deployment kube-playground
kubectl delete svc kube-playground
```

Note: For faster deployments, run the following command:

```
chmod 755 build-and-deploy.sh
./build-and-deploy.sh
```

## Section B: Introducing Helm

1. Install and init Tiller

Run the following commands

```
brew install kubernetes-helm
helm init
```

2. Create a Helm application

Run the following command

```
helm create kube-playground
```

3. Update values.yaml, deployment.yaml and service.yaml as necessary

4. Install the chart

Run the following command

```
helm install kube-playground
```

**Note**: If you want to see the created YAMLs, use the following command:

```
helm install --debug --dry-run kube-playground
```

**Note**: If you want to delete all the services that you created, use the following command:

```
helm ls --all --short | xargs -L1 helm delete --purge
```

## Section C: Introducing Dashboard

1. Setup the Dashboard

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl proxy
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

2. Getting the token

Run the following commands

```
kubectl -n kube-system get secret
kubectl -n kube-system describe secrets service-controller-token-qt4c9  
Copy-paste token
```


