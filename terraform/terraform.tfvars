aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"
vpc_azs = 2

app_name = "toptal"

rds_type = "db.t3.micro"

domain_name = "toptal.pototskyy.net"

mandatory_tags = {
  "owner"   = "Oleksiy-Pototskyy"
  "email"   = "o.pototskyy@softblues.io"
  "project" = "TopTal Continuous Delivery 3-Tier"
}
