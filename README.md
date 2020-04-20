# RedTeam AttackBox V1

RedTeam Security developed this tool in the midst of the COVID-19 pandemic, in order to continue to perform internal and wireless penetration testing while maintaining proper social distancing. The goal of this framework is to provide a quick, simple, easy way to set up robust reverse SSH connections out of client networks without any of the pain and frustration often associated with this type of set-up.

AttackBox is a framework, containing both onsite and remote server configuration scripts, to assist in setting up machines to be used for remote internal and wireless pentesting engagements. The framework uses autossh and cron to automate a self-healing SSH connection, which launches on boot, from an onsite machine to a public server, and automatically creates a reverse SSH tunnel to allow for a remote pentester to access a machine on a client network through this tunnel.

The attackbox.py script uses the Python standard library to install a suite of Kali Linux tools, configure SSH keys for root, set up the reverse SSH connection, set it up to run on boot and test the connection.  The attackbox_server.sh script updates the system, sets a root password (needed for initial key transfer from the onsite machine to the public server)

### Equipment

To utilize the AttackBox framework one will need the following equipment/machines:

- A public server: Ubuntu 18.04
- An onsite machine running Kali: This can be a VM or a hardware based machine, such as a NUC
- Domain Name: This is optional. Connections can be set up using an IP, but having a domain name allows the IP to shift if necessary.

### Instructions

1. Set Up the Public Server
- Get software and make executable.

`git clone https://github.com/nothing0x00/AttackBoxV1.git`

`cd AttackBoxV1`

`chmod +x attackbox_server.sh`





### Roadmap

Version 2 will likely involve the following improvements:
- Modularize the framework to operate with one central script and a series of Python modules.
- Automate the SSH configuration on the public server side.
- Add functionality to install software for Raspberry Pi based pentesting dropboxes to be used on physical pentesting engagements.
- Expand attackbox_server.sh for added functionality.
