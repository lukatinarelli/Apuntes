# ---------------------------------------------------------
# LAB: JFROG ARTIFACTORY OSS EN AWS (AMAZON LINUX 2023)
# ---------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3" # París
}

# --- 1. Obtener la última AMI de Amazon Linux 2023 automáticamente ---
# Esto evita que el script se rompa cuando AWS actualice las IDs
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# --- 2. Generar Claves SSH Automáticamente (Magic!) ---
# Genera una clave privada en memoria
resource "tls_private_key" "temp_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Crea la Key Pair en AWS con la parte pública
resource "aws_key_pair" "generated_key" {
  key_name   = "artifactory-lab-key-auto"
  public_key = tls_private_key.temp_key.public_key_openssh
}

# Guarda la clave privada en tu ordenador para que puedas conectarte
resource "local_file" "ssh_key" {
  content         = tls_private_key.temp_key.private_key_pem
  filename        = "${path.module}/artifactory-key.pem"
  file_permission = "0400"
}

# --- 3. Red (VPC, Subnet, IGW) ---
resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "Artifactory-Lab-VPC" }
}

resource "aws_subnet" "lab_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "Artifactory-Lab-Subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.lab_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.lab_subnet.id
  route_table_id = aws_route_table.rt.id
}

# --- 4. Security Group ---
resource "aws_security_group" "artifactory_sg" {
  name        = "artifactory-lab-sg"
  description = "Permitir SSH y Artifactory UI"
  vpc_id      = aws_vpc.lab_vpc.id

  # SSH (Abierto a todo el mundo por simplicidad de Lab)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Artifactory UI
  ingress {
    from_port   = 8081
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- 5. Instancia EC2 ---
resource "aws_instance" "artifactory_server" {
  ami           = data.aws_ami.amazon_linux_2023.id # Usa la AMI dinámica
  instance_type = "t3.medium"                       # 4GB RAM recomendado
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = aws_subnet.lab_subnet.id
  vpc_security_group_ids = [aws_security_group.artifactory_sg.id]

  # Script de arranque (User Data)
  user_data = <<-EOF
              #!/bin/bash
              set -e
              
              # 1. Preparar Sistema
              dnf update -y
              dnf install -y java-17-amazon-corretto wget

              # 2. Instalar Artifactory OSS
              cd /tmp
              wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo
              mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/
              
              dnf install -y jfrog-artifactory-oss

              # 3. Arrancar Servicio
              systemctl enable artifactory
              systemctl start artifactory
              
              # Esperar un poco (opcional, para logs)
              echo "Artifactory iniciado. Espera 1-2 mins para acceder a la UI."
              EOF

  tags = {
    Name = "Artifactory-Server-OSS"
  }
}

# --- 6. Outputs (Información útil al terminar) ---
output "ssh_connection_string" {
  value       = "ssh -i artifactory-key.pem ec2-user@${aws_instance.artifactory_server.public_ip}"
  description = "Comando para conectarse por SSH (ejecutar desde la carpeta del script)"
}

output "artifactory_url" {
  value       = "http://${aws_instance.artifactory_server.public_ip}:8081"
  description = "URL para acceder al Wizard de Artifactory (Usuario: admin / Pass: password)"
}
