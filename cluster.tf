data "aws_iam_role" "labrole-arn" {
  name = "LabRole"
}

resource "aws_eks_cluster" "obligatorio_cluster" {
  name     = "obligatorio-cluster"
  role_arn = data.aws_iam_role.labrole-arn.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.obligatorio_public_subnet.id,
      aws_subnet.obligatorio_public_subnet2.id
    ]
  }
}

resource "aws_eks_node_group" "obligatorio_node_group" {
  cluster_name    = aws_eks_cluster.obligatorio_cluster.name
  node_group_name = "obligatorio-node-group"
  node_role_arn   = data.aws_iam_role.labrole-arn.arn
  subnet_ids      = [
    aws_subnet.obligatorio_public_subnet.id,
    aws_subnet.obligatorio_public_subnet2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }
}

# resource "aws_launch_template" "obligatorio_node_group_launch_template" {
#   name_prefix = "obligatorio-node-group-launch-template"

#   # image_id             = data.aws_eks_cluster.obligatorio_cluster.core_instance_group.launch_template[0].image_id
#   instance_type        = "t3.medium"  # Update with the desired instance type
#   security_group_names = ["eks-cluster-sg"]  # Add the EKS cluster security group name(s)

#   # Add any additional configuration for the launch template
# }




  # provisioner "remote-exec" {
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("./labsuser.pem")
  #     host        = self.private_ip
  #   }

  #   inline = [
  #     "sudo echo 'Instalando AWS CLI 2.12:'",
  #     "sudo curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
  #     "sudo unzip awscliv2.zip",
  #     "sudo ./aws/install",
  #     "sudo echo 'Instalando cliente de Kubernetes'",
  #     "curl -LO 'https://dl.k8s.io/release/stable.txt'",
  #     "K8S_VERSION=$(cat stable.txt)",
  #     "curl -LO \"https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl\"",
  #     "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
  #     "sudo echo 'La versión del cliente de Kubernetes es:'",
  #     "sudo /usr/local/bin/kubectl version --client",
  #     "sudo echo 'Configurando AWS CLI'",
  #     "mkdir -p ~/.aws",
  #     "echo -e '[default]\naws_access_key_id=${var.aws_access_key_id}\naws_secret_access_key=${var.aws_secret_access_key}\n' >> ~/.aws/credentials",
  #     "echo -e '[default]\nregion=${var.aws_default_region}\n' >> ~/.aws/config",
  #     "aws configure list > /tmp/aws_configure_output",
  #     "sudo aws eks --region ${var.aws_default_region} update-kubeconfig --name ${aws_eks_cluster.obligatorio_cluster.name} --profile default",
  #     "kubectl get nodes",
  #     "sudo echo 'Kubeconfig actualizado para el clúster ${aws_eks_cluster.obligatorio_cluster.name}'",
  #     "sudo cat /tmp/aws_configure_output"
  #   ]
  # }

