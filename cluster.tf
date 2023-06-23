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
  subnet_ids = [
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
  # provisioner "remote-exec" {
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file(var.private_key_path)
  #     host        = self.public_ip
  #   }
  #   inline = [
  #     "echo 'Instalando AWS CLI 2.12:'",
  #     "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
  #     "unzip awscliv2.zip",
  #     "sudo ./aws/install",
  #     "echo 'Instalando cliente de Kubernetes'",
  #     "curl -LO 'https://dl.k8s.io/release/stable.txt'",
  #     "K8S_VERSION=$(cat stable.txt)",
  #     "curl -LO \"https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl\"",
  #     "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
  #     "echo 'La versión del cliente de Kubernetes es:'",
  #     "sudo -u ec2-user /usr/local/bin/kubectl version --client",
  #     "echo 'Configurando AWS CLI'",
  #     "sudo -u ec2-user mkdir -p ~/.aws",
  #     "aws configure set aws_access_key_id ${var.access_key} --profile default",
  #     "aws configure set aws_secret_access_key ${var.secret_key} --profile default",
  #     "aws configure set aws_session_token ${var.token} --profile default",
  #     "aws configure set region ${var.region} --profile default",
  #     "aws configure list > /tmp/aws_configure_output",
  #     "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name} --profile default",
  #     "kubectl get nodes",
  #     "echo 'Kubeconfig actualizado para el clúster ${var.cluster_name}'",
  #     "sudo cat /tmp/aws_configure_output",
  #     "sudo yum install git -y",
  #     "git init",
  #   ]
  # }
}