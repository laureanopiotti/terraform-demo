# ------------------------------------ #
 ############# RDS SQL ################
# ------------------------------------ #
resource "aws_db_instance" "sql_instance" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "laureanodb"
  username             = "laureano"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  identifier = "laureanosql"
  multi_az = false

  vpc_security_group_ids = [aws_security_group.allow_mysql.id,]
  db_subnet_group_name = aws_db_subnet_group.sql_subnet_group.name
}
# ------------------------------------ #

# ------------------------------------ #
 ######### RDS Subnet Group ###########
# ------------------------------------ #
resource "aws_db_subnet_group" "sql_subnet_group" {
  name       = "laureano-subnet-group-sql"
  subnet_ids = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]

  tags = {
    Name = "laureano-DB-subnet-group-mysql"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #

# ------------------------------------ #
 ########## SECURITY GROUP ############
# ------------------------------------ #
resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow MySQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "MySQL from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.allow_http.id, ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_mysql"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #

# ------------------------------------ #
 ############# Outputs  ###############
# ------------------------------------ #
output "rds_endpoint" {
  value = aws_db_instance.sql_instance.endpoint
}

output "rds_database" {
  value = aws_db_instance.sql_instance.name
}

output "rds_user" {
  value = aws_db_instance.sql_instance.username
}

output "rds_password" {
  value = aws_db_instance.sql_instance.password
  sensitive = true
}
# ------------------------------------ #