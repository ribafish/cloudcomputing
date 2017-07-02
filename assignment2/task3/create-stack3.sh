openstack stack create -t server-landscape.yaml assignment2-task3-stack \
--parameter "name=assignment2-task3-vm" \
--parameter "router=cc17-23-router" \
--parameter "server=cc17-23-server" \
--parameter "network=cc17-23-net"	\
--parameter "subnet=cc17-23-subnet" \
--parameter "key_pair=group06key" \
--parameter "network_public=tu-internal"
