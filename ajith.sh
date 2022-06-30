 #!/bin/bash
      az login --tenant af5a6fb3-b792-4f0e-aa58-7cf18b9cad30
      az account show --output yaml
      az group create --name $(RG) --location eastasia
      az network vnet create -g $(RG) -n $(VNET) --address-prefix 10.0.0.0/16 \
                --subnet-name testsubnet --subnet-prefix 10.0.0.0/24
      az network public-ip create -g $(RG) -n testip --allocation-method Dynamic
      az network nsg create -g $(RG) -n testnsg
      az network nic create -g $(RG) --vnet-name $(VNET) --subnet testsubnet -n testnic
      az network nic ip-config create -g $(RG) -n testipConfig --nic-name testnic --make-primary
      az vm create -n testvm -g $(RG) --image UbuntuLTS --public-ip-address testip --authentication-type password --admin-username demouser --admin-password Ajith@123456789

