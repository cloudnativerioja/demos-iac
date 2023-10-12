resource "kubernetes_deployment_v1" "example" {
  metadata {
    name = "pod-demo"
    namespace = "test"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 3
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 0
      }
    }
    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "ghcr.io/stefanprodan/podinfo:6.5.1"
          name  = "example"
          port {
            name           = "http"
            container_port = 9898
            protocol       = "TCP"
          }
          port {
            name           = "http-metrics"
            container_port = 9797
            protocol       = "TCP"
          }
          port {
            name           = "grpc"
            container_port = 9999
            protocol       = "TCP"
          }
          command = ["./podinfo", "--port=9898", "--port-metrics=9797", "--grpc-service-name=podinfo", "--level=info", "--random-delay=false", "--random-error=false"]
          env {
            name  = "PODINFO_UI_COLOR"
            value = "#4e99ff"
          }
          env {
            name  = "PODINFO_UI_MESSAGE"
            value = "Hola desde Cloud Native Rioja! 🤘"
          }
          env {
            name  = "PODINFO_UI_LOGO"
            value = "https://docs.cloudnativerioja.com/recursos/assets/logo-black.svg"
          }
          resources {
            limits = {
              memory = "256Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "example" {
  metadata {
    name = "service-demo"
    namespace = "test"
  }
  spec {
    selector = {
      test = kubernetes_deployment_v1.example.metadata.0.labels.test
    }
    session_affinity = "ClientIP"
    port {
      port        = 9898
      name        = "http"
      target_port = "http"
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "example_ingress" {
  metadata {
    name = "ingress-demo"
    namespace = "test"
    annotations = {
    "cert-manager.io/cluster-issuer"                   = "letsencrypt-prod"
    "kubernetes.io/ingress.class"                      = "traefik"
    "traefik.ingress.kubernetes.io/router.entrypoints" = "web,websecure"
    "traefik.ingress.kubernetes.io/router.tls"         = "true"
  }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "service-demo"
              port {
                number = 9898
              }
            }
          }

          path = "/"
        }
      }
      host = "demo.cloudnativerioja.com"
    }
    tls {
      hosts = [
        "demo.cloudnativerioja.com"
      ]
      secret_name = "tls-demo-cloudnativerioja-com"
    }
  }
}