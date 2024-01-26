data "template_file" "user_data_ec2_windows" {
  template = file("${path.module}/templates/user_data_ec2_windows.ps1")
}

resource "aws_instance" "custeng_server_windows_runner" {

  ami                    = var.windows_ami # Windows_Server-2022-English-Full-Base-2024.01.10
  instance_type          = "t3.large"
  key_name               = var.support_server_keypair
  monitoring             = false
  vpc_security_group_ids = [aws_security_group.custeng-server-windows-runner-sg.id]
  subnet_id                   = var.subnet_id
  user_data                   = data.template_file.user_data_ec2_windows.rendered
  user_data_replace_on_change = true
  tags = merge(var.default_tags, {
    "Name" = "vijay-windows-test-runner"
  }, )
}


resource "aws_ec2_instance_state" "custeng_server_windows_runner_state" {
  instance_id = aws_instance.custeng_server_windows_runner.id
  state       = "running"
}
