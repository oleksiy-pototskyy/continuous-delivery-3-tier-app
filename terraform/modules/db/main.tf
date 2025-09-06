resource "aws_security_group" "pg" {
  name_prefix = "db-"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [
      var.sg_api_id
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "random_password" "pg" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "pg" {
  name       = "pg"
  subnet_ids = var.vpc_db_subnets

  tags = merge(
    tomap({"Name" = "Mastering Terraform Database"}),
    var.mandatory_tags
  )
}

resource "aws_rds_cluster" "pg" {
  engine                 = "aurora-postgresql"
  engine_version         = "15.4"
  database_name          = var.db_name
  master_username        = var.db_name
  master_password        = random_password.pg.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.pg.id]
  db_subnet_group_name   = aws_db_subnet_group.pg.id

  serverlessv2_scaling_configuration {
    max_capacity = 1
    min_capacity = 0.5
  }

  tags = merge(
    tomap({"Name" = "Mastering Terraform Database"}),
    var.mandatory_tags
  )
}

resource "aws_rds_cluster_instance" "pg" {
  count              = 2
  identifier         = "${var.db_name}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.pg.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.pg.engine
  engine_version     = aws_rds_cluster.pg.engine_version
}

resource "aws_secretsmanager_secret" "pg" {
  name = "pg-${var.db_name}"
}

resource "aws_secretsmanager_secret_version" "pg" {
  secret_id = aws_secretsmanager_secret.pg.id

  # encode in the required format
  secret_string = jsonencode(
    {
      dbport   = 5432
      dbname   = var.db_name
      dbuser   = aws_rds_cluster.pg.master_username
      dbpass   = aws_rds_cluster.pg.master_password
      engine   = "postgresql"
      dbhost   = aws_rds_cluster.pg.endpoint
    }
  )
}





