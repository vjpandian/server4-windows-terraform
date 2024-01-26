
resource "aws_security_group" "vijay-server-windows-runner-sg" {
  name        = "vijay-server-4-windows-runner-sg"
  description = "Inbound traffic rules for Windows EC2s"
  vpc_id      = var.vpc_id

  # Nomad SG Access for viewing allocs
  ingress {
    description = "Inbound Access for RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ################################### Windows - Egress ###########################################

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.default_tags, {
    "Name" = "windows-runner-sg"
  }, )
}
