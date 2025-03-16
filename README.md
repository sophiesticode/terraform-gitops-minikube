# terraform-gitops-minikube

## setup
you need to have minikube installed on your machine.

start minikube
```bash
minikube start
```

export kube config path
```bash
export KUBE_CONFIG_PATH=$HOME/.kube/config
```

add the argocd helm repo
```bash
helm repo add argo-helm https://argoproj.github.io/argo-helm
helm repo update
```

verify minikube ip and change ROOT_URL in helm_release gitea of main.tf (to me it is 192.168.49.2)
```bash
minikube ip
```

## apply
apply the configuration
```bash
terraform init
terraform apply
```

## config

### gitea
config gitea at [http://192.168.49.2:32000/](http://192.168.49.2:32000/)

### argo
port-forward pour utiliser argocd en local
```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```
config argo at [localhost:8081](localhost:8081)

- username: admin
- password:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```