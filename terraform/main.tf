terraform {
  required_version = ">= 1.1"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "stackio" {
  metadata {
    name = "stackio"
  }
}
resource "kubernetes_secret" "credentials" {
  metadata {
    name      = "credentials"
    namespace = kubernetes_namespace.stackio.metadata[0].name
  }
  data = {
    MARIADB_PASSWORD = "stackio"
  }
}

resource "kubernetes_stateful_set" "stackio_backend" {
  metadata {
    name      = "stackio-backend"
    namespace = kubernetes_namespace.stackio.metadata[0].name
    labels = {
      app = "backend"
    }
  }

  spec {
    service_name = "backend"
    replicas     = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name              = "stackio-backend"
          image             = "mfandrade/stackio-backend:latest"
          image_pull_policy = "Always"

          port {
            container_port = 3306
          }

          env {
            name = "MARIADB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.credentials.metadata[0].name
                key  = "MARIADB_PASSWORD"
              }
            }
          }

          volume_mount {
            name       = "credentials-volume"
            mount_path = "/mnt/credentials-volume"
            read_only  = true
          }
        }

        volume {
          name = "credentials-volume"

          secret {
            secret_name = kubernetes_secret.credentials.metadata[0].name
          }
        }
      }
    }
  }
}

