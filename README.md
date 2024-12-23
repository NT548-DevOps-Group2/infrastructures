
## Connect AWS CLI to kubectl
```
aws eks update-kubeconfig --region us-east-1 --name production-environment
aws eks update-kubeconfig --region us-east-1 --name test-environment
```

## Install ArgoCD
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}'
kubectl apply -n argocd -f argocd/application-prod.yaml
```

## Deploy app
```
kubectl create ns app

kubectl apply -f microservices/frontend-deploy.yaml -f microservices/auth-service-deploy.yaml -f microservices/comment-service-deploy.yaml -f microservices/gateway-deploy.yaml -f microservices/post-service-deploy.yaml -f secret-config/api-configmap.yaml -f secret-config/database-secret.yaml -n app
```