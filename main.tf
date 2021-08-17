provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "vcsim" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_service" "vcsim_service" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.vcsim.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vcsim_deployment.metadata.0.labels.app
    }

    port {
      port        = 8989
      target_port = 8989
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "vcsim_deployment" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.vcsim.metadata.0.name
    labels = {
      app = var.app_name

    }

  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name

        }

      }
      spec {
        container {
          name  = "vcsim"
          image = var.image

        }

      }

    }
  }

}