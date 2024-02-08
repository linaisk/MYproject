resource "aws_db_instance" "project" {
  identifier            = "mysql-db-01"
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t2.micro"
  username              = "test2"
  password              = "test1234"
  allocated_storage     = 20
  parameter_group_name  = aws_db_parameter_group.custom_parameter_group.name
  skip_final_snapshot   = true
}

resource "aws_db_parameter_group" "custom_parameter_group" {
  name        = "mysql-57-params"
  family      = "mysql5.7"
  description = "Custom parameter group for MySQL 5.7"

  parameter {
    name  = "max_connections"
    value = "100"
  }

}
