output "db_secret_arn" {
  value = aws_secretsmanager_secret.pg.arn
}
