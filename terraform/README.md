# Terraform

- introduced by HashiCorp and is open source and declarative

- it allows automate and manage your infrastructure (infrastructure provisioning in correct order)

- to deploy the applications on VMs and machines we first should provision and install necessary requirements on the infrastructure

- while terraform is more advanced and newer rather than `ansible`, terraform is better for infra provisioning while ansible is better for infra config managment.

- by managing we mean create and change the infrastructure and automate contineues changes in infra.

- terraform keeps track of the state and we don't care much on changing infrustructure, means the terraform itself will detrmine the current and desired state and will update and remove resources.

- ansible is procedural but terraform is more declarative and the terraform itself manage the orders.

- ansible is for configuration managment while terraform can provision the infrastructure.

- both the ansible and terraform are masterless means they don't nees a master server to do the jobs.

- both ansible and terraform are agentless, they don't require installing agent software on target servers.

## Architecture

1. `Core`: what to create and configure + the state of the setup
    - it checks the current state and detrmine what needs to be done to achieve the desired state.

2. `Providers`: what provider technology (aws, k8s, azure IaaS)
   - every provider has lots of resource to do various jobs with it.

## commands

- `refresh`: query infrastructure to get current state.
- `plan`: create an execution plan.
- `apply`: execute the plan.
- `destroy`: destroy infrastructure and resources.
