

## Configuration Details
### Provider Configuration
The code begins by configuring the libvirt provider. It specifies the URI for the libvirt connection as qemu:///system.

### Terraform Version and Required Providers
Next, the code specifies the Terraform version and the required providers. It requires Terraform version 0.13 or higher and the libvirt provider from the source "dmacvicar/libvirt."

### Virtual Machine Resources
The code defines various virtual machine resources using Terraform's resource blocks. Each resource follows a similar pattern, consisting of:

- Data Blocks: Data blocks are used to read and template user data and network configuration files. These templates are used for cloud-init configuration.
- Libvirt Cloud-Init Disk: These resources create cloud-init ISOs, which are used for configuring the virtual machines during provisioning. They include user data and network configuration templates.
- Libvirt Volume: These resources define disk volumes that the VMs will use. They include information such as volume names, size, and format.
- Libvirt Domain (Virtual Machine): These resources define the virtual machines themselves. They include details such as name, memory, CPU settings, cloud-init configuration, network interfaces, disks, and graphics settings.

## Usage
To use this Terraform configuration, follow these steps:

- Ensure you have Terraform (version 0.13 or higher) installed.
- Create the necessary user data and network configuration files for each virtual machine based on the templates.
- Modify the resource definitions as needed to match your infrastructure requirements.
- Run `terraform init` to initialize the required providers.
- Run `terraform plan` to preview the changes that Terraform will make.
- Run `terraform to apply` the configuration and create the virtual machines.

## Customization
You can customize this configuration by:

- Modifying the virtual machine specifications (memory, CPU, network interfaces, etc.) for each VM according to your requirements.
- Changing the names and sizes of the disk volumes.
- Adjusting the network configuration, IP addresses, and graphics settings for each VM.
- Modifying the cloud-init templates to set up the VMs according to your specific use case.

## Important Notes
- This configuration assumes that you have already prepared base images like "ubuntu-jammy.img" in the "isos" pool. Please ensure that the base images are available in your libvirt environment.
- Ensure that your libvirt provider is correctly configured with access to your virtualization platform.
- Carefully review and modify the IP addresses, network names, and other settings to fit your network infrastructure.
- Be cautious when applying the configuration, as it may create or modify virtual machines in your environment.

## Cleanup
To remove the virtual machines and associated resources created by this Terraform configuration, you can run `terraform destroy` after applying the configuration.

