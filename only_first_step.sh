##secret setting
kubectl create secret generic aws-secret   --from-literal=AWS_ACCESS_KEY_ID={AWS_ACCESS_KEY_ID}   --from-literal=AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}

##secret setting
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