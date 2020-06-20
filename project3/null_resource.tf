# resource "null_resource" "mine" {
#     triggers = {
#         always_run = "${timestamp()}"
#      }    
#   depends_on = ["aws_instance.centos"]
#   provisioner   "remote-exec" {
#     connection {
#         host        = "${aws_instance.centos.public_ip}"
#         type        = "ssh"
#         user        = "centos"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     inline = [
#        "sudo yum install epel-release -y",
# 		"sudo yum install curl -y",
# 		"sudo curl  https://assets.nagios.com/downloads/nagiosxi/install.sh | sh",
     
#     ]
#   }
# }

resource "aws_key_pair" "deployer2" {
  key_name   = "deployer2-key"
  public_key = "${file("~/.ssh/id_rsa")}"
}
resource "aws_instance" "centos" {
  ami           = "${data.aws_ami.centos.id}"
  key_name      = "${aws_key_pair.deployer2.key_name}"
  instance_type = "t3.medium"
  provisioner   "remote-exec" {
    connection {
        host        = "${self.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo yum install epel-release -y",
	  "sudo yum install curl -y",
      "sudo curl  https://assets.nagios.com/downloads/nagiosxi/install.sh | sh",
     
    ]
  }
}
  