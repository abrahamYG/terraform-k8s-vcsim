provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "vcsim" {
  metadata {
    name = "vcsim"
  }
}

resource "kubernetes_service" "vcsim_service" {
  metadata {
    name = "vcsim-service"
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
    name = "vcsim-deployment"
    namespace = kubernetes_namespace.vcsim.metadata.0.name
    labels = {
      app = "vcsim"

    }

  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app : "vcsim"
      }
    }

    template {
      metadata {
        labels = {
          app = "vcsim"

        }

      }
      spec {
        container {
          name  = "vcsim"
          image = "vmware/vcsim:latest"

        }

      }

    }
  }

}