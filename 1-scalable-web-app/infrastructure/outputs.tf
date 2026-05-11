output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "rds_endpoint" {
  description = "The connection endpoint for the Multi-AZ RDS instance"
  value       = aws_db_instance.database.endpoint
}

output "vpc_id" {
  description = "The ID of the main VPC"
  value       = aws_vpc.main.id
}