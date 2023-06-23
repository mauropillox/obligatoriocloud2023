# Outputs
output "vpc_id" {
  value = aws_vpc.vpc_obligatorio.id
}

output "public_subnet_id" {
  value = aws_subnet.obligatorio_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.obligatorio_private_subnet.id
}

output "private_subnet_2_id" {
  value = aws_subnet.obligatorio_private_subnet_2.id
}

output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "http_sg_id" {
  value = aws_security_group.http_sg.id
}

output "public_subnet_cidr2" {
  description = "CIDR block for the additional public subnet"
  value       = aws_subnet.obligatorio_public_subnet2.cidr_block
}


# output "db_sg_id" {
#   value = aws_security_group.db_sg.id
# }

# # Output del endpoint del cluster EKS
# output "endpoint" {
#   value = aws_eks_cluster.obligatorio-cluster.endpoint
# }
# # Output para el certificado de authority data de EKS
# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.obligatorio-cluster.certificate_authority[0].data
# }

# Output para la dirección IP pública del servidor web del frontend
output "frontend_ip" {
  value = aws_instance.obligatorio_frontend.public_ip
}

# Output para el ID de la instancia del servidor web del frontend
output "frontend_instance_id" {
  value = aws_instance.obligatorio_frontend.id
}

# # Output para el ID de la instancia de base de datos
# output "database_instance_id" {
#   value = aws_db_instance.obligatorio_database.id
# }

# # Output para el ID del grupo de objetivos
# output "target_group_attachment_id" {
#   value = aws_lb_target_group_attachment.obligatorio_frontend.id
# }