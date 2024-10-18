resource "aws_docdb_cluster" "mongo_cluster" {
  provider                = aws.docdb_region
  cluster_identifier      = var.mongo_cluster_identifier
  master_username         = var.mongo_master_username
  master_password         = var.mongo_master_password
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.mongo_sg.id]
  
  tags = {
    Name = var.mongo_name_tag
  }
}

resource "aws_docdb_cluster_instance" "mongo_instance" {
  provider                = aws.docdb_region
  identifier              = var.mongo_instance_identifier
  cluster_identifier      = aws_docdb_cluster.mongo_cluster.id
  instance_class          = var.mongo_instance_class
  apply_immediately       = true
  
  tags = {
    Name = var.mongo_name_tag
  }
}

resource "aws_security_group" "mongo_sg" {
  provider    = aws.docdb_region
  name        = "mongo-security-group"
  description = "Allow backend to access DocDb"
  tags = {
    Name = "mongo-security-group"
  }
}

resource "aws_security_group_rule" "mongo_to_be" {
  provider                 = aws.docdb_region
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = aws_security_group.mongo_sg.id
  cidr_blocks              = ["0.0.0.0/0"] # TODO: Cross-Region VPC Peering / Correct CIDR
}