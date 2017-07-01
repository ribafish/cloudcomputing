openstack stack create -t server.yaml assignment2-task3-stack \
--parameter "name=assignment2-task3-vm" \
--parameter "router=cc17-router" \
--parameter "server=cc17-server" \
--parameter "network=cc17-net"	\
--parameter "subnet=cc17-subnet" \
--parameter "key_pair=group06key" \
