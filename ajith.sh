 #!/bin/bash
      az login --tenant $(SUB_ID)
      az account show --output yaml
      az group create --name $(RG) --location $(LOCATION)
      az network vnet create -g $(RG) -n $(VNET) --address-prefix 10.0.0.0/16 \
                --subnet-name $(SUBNET) --subnet-prefix 10.0.0.0/24
      az network public-ip create -g $(RG) -n $(IP) --allocation-method Dynamic
      az network nsg create -g $(RG) -n $(NSG)
      az network nic create -g $(RG) --vnet-name $(VNET) --subnet $(SUBNET) -n $(NIC)
      az network nic ip-config create -g $(RG) -n testipConfig --nic-name $(NIC) --make-primary
      az vm create -n $(VM) -g $(RG) --image UbuntuLTS --public-ip-address $(IP) --authentication-type password --admin-username $(USER) --admin-password $(PASSWORD)
