---
title: "Hashibiz Part 1"
date: 2018-06-30T11:28:36+01:00
draft: true
---

HashiBiz is a fictitious online company that have heavily adopted HashiCorp tools to run their cloud infrastructure. See my project landing page for more information and a full list of posts. 

In this post I will be using Terraform to setup a three node cluster of webservers behind a load balancer in Azure. 

DISCLAIMER: I wont be going over detailed steps for each technology involved but rather my "how" I used each and the problems that came up in doing so

# Connecting to Azure
I dont have much experience with Azure just yet and getting the right connection credentials was not a very clear to me. Its seems there should be multiple ways to do this but honestly the only way i could get to work was to use the AzureCLI. Rather than repeat the process the steps to retreive the values you need are [documented here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

You want to end up with the following saved to a file called terraform.tfvars, as is best practise.
```hcl
subscription_id = "xxxxxxxx-xxxx-xxx-xxxx-xxxxxxxxxxx" # your azure subscription
client_id       = "xxxxxxxx-xxxx-xxx-xxxx-xxxxxxxxxxx" # azure service principal username
client_secret   = "xxxxxxxx-xxxx-xxx-xxxx-xxxxxxxxxxx" # azure service principal password
tenant_id       = "xxxxxxxx-xxxx-xxx-xxxx-xxxxxxxxxxx" # tenant id aka azure directory id
```
These are the keys to the kingdom so you definately want to keep these out of github using a .gitignore file. 

# Spinning up a VM
Now that you can connect to the Azure api we want to be able to create VMs. I recommend first reading the [Terraform docs](https://www.terraform.io/docs/index.html) as well as the [Microsoft docs](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-create-complete-vm). 

The resources used in order were:
* azurerm_resource_group
* azurerm_virtual_network
* azurerm_subnet
* azurerm_network_security_group
* azurerm_availability_set
* azurerm_public_ip
* azurerm_network_interface
* azurerm_virtual_machine



hugo commands 
hugo new site website
