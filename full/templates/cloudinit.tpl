#cloud-config
packages:
  - ${package}

runcmd:
 - systemctl start ${package}
 - systemctl enable ${package}

