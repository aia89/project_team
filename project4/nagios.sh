#! /bin/bash
        sudo setenforce 0
        sudo yum install epel-release -y
		sudo yum install curl -y
		sudo curl  https://assets.nagios.com/downloads/nagiosxi/install.sh | sh