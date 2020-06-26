# Final version project 4, ready for provisioning.
Terraform

Use Infrastructure as Code to provision and manage any cloud, infrastructure, or service

Nagios XI

Enterprise Server and Network Monitoring Software

Comprehensive application, service, and network monitoring in a central solution.



# provider.tf Configure the AWS Provider
    provider "aws" {
    version = "~> 2.66"
    region  = "${var.region}"
    }



1. Provisioner.tf 
Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.


#this part we be creating a key


    resource "aws_key_pair" "deployer" {

    key_name   = "deployer-key"
  
    public_key = "${file("~/.ssh/id_rsa.pub")}"
  
    }
 

#this part runs a user data from nagios.sh file in order to install prerequisites for nagios server.
  
    user_data = "${file("nagios.sh")}"
  
    instance_type = "t3.medium"
 
 
#the name of the project

    tags = {
   
     Name = "NagiosProject"
  


#security groups 

    resource "aws_security_group" "allow_tls" {
  
    name        = "allow_tls"
  
    description = "Allow TLS inbound traffic"
  

    ingress {
    
    description = "TLS from VPC"
    
    from_port   = 443
    
    to_port     = 443
    
    protocol    = "tcp"
     
     cidr_blocks = ["0.0.0.0/0"]
  
  }
  



2. aws_vpc provides details about a specific VPC.


This resource can prove useful when a module accepts a vpc id as an input variable and needs to, for example, determine the CIDR block of that VPC.


    resource "aws_vpc" "main" {
  
     cidr_block = "${var.cidr_block}"

      }

    tags = {
   
     Name = "ProjectVPC"
  
    }

    }



3.private and public subnets

aws_subnet provides details about a specific VPC subnet.

This resource can prove useful when a module accepts a subnet id as an input variable and needs to, for example, determine the id of the VPC that the subnet belongs to.



4.networking.tf

file contains variables from private and public subnets, as well as routing table, internet gateway and private subnet association with RT.



5.centos_ami.tf this file gathers data about instance

    data "aws_ami" "centos" {
 
    most_recent = true
  
    filter {
    
     name   = "name"
    
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  
    }
  
    filter {
    
    name   = "virtualization-type"
    
    values = ["hvm"]
  
    }
  
    owners = ["679593333241"] # Canonical

    }

    output "CENTOS_AMI_ID" {
    
     value = "${data.aws_ami.centos.id}"

    }


6. user data nagios.sh contains bash script which runs while image getting created and install needed tools to run 

nagios server.

    #! /bin/bash
       
       sudo setenforce 0
        
	sudo yum install epel-release -y
		
		sudo yum install curl -y
		
		sudo curl  https://assets.nagios.com/downloads/nagiosxi/install.sh | sh
    
    
 7. backend.tf contains data about S3 bucket, changed it into your own bucket name. 
 
    
    
    
