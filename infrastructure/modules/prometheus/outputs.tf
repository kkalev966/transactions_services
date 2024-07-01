# output "nginx_ingress_loadbalancer_ip" {
#   value       = data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip
#   description = "The hostname of the LoadBalancer Nginx created by kubernetes"
# }
