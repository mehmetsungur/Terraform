#!/bin/bash
yum update –y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
amazon-linux-extras install java-openjdk11 -y
yum install java-11-amazon-corretto -y
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
systemctl status jenkins