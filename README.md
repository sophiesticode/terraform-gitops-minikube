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

