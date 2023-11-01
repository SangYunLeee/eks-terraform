resource "aws_security_group" "example" {
  name_prefix = "example-"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.ports
    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ports" {
  description = "List of ports to open"
  type        = list(number)
  default     = [80, 443]
}
