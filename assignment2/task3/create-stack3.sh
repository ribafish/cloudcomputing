openstack stack create -t server.yaml assignment2-task3-stack \
--parameter "name=assignment2-task3-vm" \
--parameter "key_pair=group06key" \
--parameter "image=ubuntu-16.04" \
--parameter "network=cc17-net"
