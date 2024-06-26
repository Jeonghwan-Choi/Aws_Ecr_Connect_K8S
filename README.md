## AWS ECR(Amazon Elastic Container Registry) 쿠버네티스와 연결

## 무중단구현

### [ecr_deploy.sh](ecr_deploy.sh)
#### docker build && Ecr Push
```shell
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin {aws}.dkr.ecr.ap-northeast-2.amazonaws.com

docker build -t app-v1 .

docker tag app-v1:latest {aws}.dkr.ecr.ap-northeast-2.amazonaws.com/app-v1:latest

docker push {aws}.dkr.ecr.ap-northeast-2.amazonaws.com/app-v1:latest

```


### [only_first_step.sh](only_first_step.sh)
#### Setting && Apply 
```shell
##Secret setting
kubectl create secret generic aws-secret --from-literal=AWS_ACCESS_KEY_ID={AWS_ACCESS_KEY_ID} --from-literal=AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}

##Secret setting
kubectl create secret docker-registry ecr-registry-secret --docker-server={aws}.dkr.ecr.ap-northeast-2.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password --region ap-northeast-2)

kubectl delete deployment deployment
kubectl delete svc service
kubectl delete ingress ingress
kubectl delete svc service
kubectl delete deployment,svc,ingress -l app=app
kubectl delete hpa hpa

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f hpa.yaml
```

### [k8s_deploy.sh](k8s_deploy.sh)
#### Ecr pull && k8s deployment
```shell
kubectl apply -f deployment.yaml

kubectl scale deployment deployment --replicas=2

kubectl rollout restart deployment deployment

kubectl rollout status deployment deployment

kubectl scale deployment deployment --replicas=1
```

```logcatfilter
\app_v1> kubectl rollout status deployment app-deployment
Waiting for deployment "app-deployment" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "app-deployment" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "app-deployment" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "app-deployment" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "app-deployment" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "app-deployment" rollout to finish: 1 old replicas are pending termination...
deployment "app-deployment" successfully rolled out
```