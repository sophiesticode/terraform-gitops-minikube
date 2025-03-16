terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }
  }
}

provider "kubernetes" {}

provider "helm" {}

# gitea
resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gitea"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "helm_release" "gitea" {
  name       = "gitea"
  repository = "https://dl.gitea.io/charts/"
  chart      = "gitea"
  namespace  = kubernetes_namespace.gitea.metadata[0].name
  values = [
    <<EOF
service:
  http:
    type: NodePort
    nodePort: 32000  

gitea:
  config:
    server:
      ROOT_URL: "http://192.168.49.2:32000/"
persistence:
  enabled: true
  size: 10Gi
EOF
  ]
}

data "kubernetes_service" "gitea" {
  metadata {
    name      = "gitea-http"
    namespace = kubernetes_namespace.gitea.metadata[0].name
  }
  depends_on = [helm_release.gitea]
}

# argocd
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.9"
  namespace  = "argocd"
}
