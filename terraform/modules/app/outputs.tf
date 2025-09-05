output "web_cluster_name" {
  description = "ECS cluster name for web application"
  value       = aws_ecs_cluster.web.name
}

output "api_cluster_name" {
  description = "ECS cluster name for API application"
  value       = aws_ecs_cluster.api.name
}

output "web_service_name" {
  description = "ECS service name for web application"
  value       = aws_ecs_service.web.name
}

output "api_service_name" {
  description = "ECS service name for API application"
  value       = aws_ecs_service.api.name
}

output "web_alb_dns_name" {
  description = "DNS name of the web ALB"
  value       = aws_lb.web.dns_name
}

output "api_alb_dns_name" {
  description = "DNS name of the API ALB"
  value       = aws_lb.api.dns_name
}

output "web_alb_zone_id" {
  description = "Zone ID of the web ALB"
  value       = aws_lb.web.zone_id
}

output "api_alb_zone_id" {
  description = "Zone ID of the API ALB"
  value       = aws_lb.api.zone_id
}

output "web_ecr_repository_url" {
  description = "ECR repository URL for web application"
  value       = aws_ecr_repository.web.repository_url
}

output "api_ecr_repository_url" {
  description = "ECR repository URL for API application"
  value       = aws_ecr_repository.api.repository_url
}