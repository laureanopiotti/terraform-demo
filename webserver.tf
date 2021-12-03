# ------------------------------------ #
 ########### EC2 INSTANCE #############
# ------------------------------------ #
resource "aws_instance" "web_server" {
  ami           = "ami-0142f6ace1c558c7d" # Amazon Linux 2 AMI (HVM) (64-bit x86)
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets.0
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  user_data = file("install_nginx.sh")
  key_name = aws_key_pair.laureano.key_name
  
  tags = {
    Name = "laureano-webserver-1"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #

# ------------------------------------ #
 ########## SECURITY GROUP ############
# ------------------------------------ #
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0",]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0",]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #


# ------------------------------------ #
 ########### EC2 KEY PAIR #############
# ------------------------------------ #
resource "aws_key_pair" "laureano" {
  key_name   = "laureano-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBn3ZPMtfAD4iRvDZMjFgoCixKNO4lodH6q8ktf/KWSbhuwFkh/dSlMgffQtK9kz7bcTMutB041T7ReGgWi4JCb+xYkmskNnoaszoQBpDeBixBLxlNZj+c+kJO9OjcTg5Rqg8xuzmO4NiKKEkOBwUOqTtm5XE0hSmfcUa9SwVRI6m6aZeyZZaUi5SKdaScVMvai2xDvclIPWq/tk7rR5yUie2fD2zWmnztAPVoBb1ipvjLSLMkQgpOUmbJny3tS0izLT9+RMwfISWoniSvRPYlzYYVIgQOcfQNZiR6kOqwhgMqPiztTLcX1M6a6HBe+ymU5W2rhqiGaGxIqfSlsjIncAl1P2BaJdEPPRdYRCWmJCGV8sZikQLhVdDnzZbx02Ju65/l0h0JCsny9PWYHmiuhWcIVpYNLRJic0TAhbmykkNre/NY8SCon4E1XOnVjXSJS02LOEbHS//luV+gExmV/bdMRLdOFPijqQk7aHgOhpX0jPFGSPuqZcOGy8Rln/PBF5rkCtpI3FoFdKHdXoNBIykk+AYSLgd7U0hG3ezpyElV4Ht9AU3+P3qbqaptHbBwLnJBzlEFGF6nzzXl2iSw0LQjl+KRYxVpAQscZQPssFp1QH6ZBv7ZXyUnPnB6tpBPGKQvh+W5w8MJX5HZzF4vpeDAu1ZKLAZGGIzUalLeOw== laureanopiotti"
}
# ------------------------------------ #
