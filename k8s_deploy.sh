kubectl apply -f deployment.yaml

kubectl scale deployment deployment --replicas=2

kubectl rollout restart deployment deployment

kubectl rollout status deployment deployment

kubectl scale deployment deployment --replicas=1