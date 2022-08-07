terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "k8s-kube-news" {
  name   = "k8s-kube-news"
  region = var.region
  version = var.do_version

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = var.nodeCount
  }
}

resource "local_file" "kube_config" {
    content  = digitalocean_kubernetes_cluster.k8s-kube-news.kube_config.0.raw_config
    filename = "kube_config.yaml"
}

variable "do_token" {}
variable "region" {}
variable "do_version" {}
variable "nodeCount" {}