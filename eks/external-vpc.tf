data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "private" {
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.selected.id
    ]
  }

  filter {
    name = "tag:tier"
    values = ["private"]
  }
}

data "aws_subnets" "public" {
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.selected.id
    ]
  }

  filter {
    name = "tag:tier"
    values = ["public"]
  }
}
