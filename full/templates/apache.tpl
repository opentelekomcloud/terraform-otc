#cloud-config
packages:
  - httpd

runcmd:
 - systemctl start httpd
 - systemctl enable httpd
