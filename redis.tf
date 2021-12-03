# ------------------------------------ #
 ############### REDIS ################
# ------------------------------------ #
resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "laureano-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"
  port                 = 6379
  security_group_ids = [aws_security_group.allow_redis.id, ]
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name

  tags = {
    Name = "laureano-redis-cluster"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #

# ------------------------------------ #
 ######### Redis Subnet Group ###########
# ------------------------------------ #
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "laureano-subnet-group-redis"
  subnet_ids = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]

  tags = {
    Name = "laureano-DB-subnet-group-redis"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #

# ------------------------------------ #
 ########## SECURITY GROUP ############
# ------------------------------------ #
resource "aws_security_group" "allow_redis" {
  name        = "allow_redis"
  description = "Allow redis inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Redis from VPC"
    from_port        = 6379
    to_port          = 6379
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
    Name = "allow_http"
    Terraform = "true"
    Environment = "dev"
  }
}
# ------------------------------------ #