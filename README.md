![alt text](https://github.com/nothing0x00/AttackBoxV1/blob/master/logo_image.jpeg)
# RedTeam AttackBox V1

RedTeam Security developed this tool in the midst of the COVID-19 pandemic, in order to continue to perform internal and wireless penetration testing while maintaining proper social distancing. The goal of this framework is to provide a quick, simple, easy way to set up robust reverse SSH connections out of client networks without any of the pain and frustration often associated with this type of set-up. The goal is to create a machine that can be mailed to a client, or installed as part of a pre-build virtual machine image, with the client needing to just plug it in or install the image, and turn it on.

AttackBox is a framework, containing both onsite and remote server configuration scripts, to assist in setting up machines to be used for remote internal and wireless pentesting engagements. The framework uses autossh and cron to automate a self-healing SSH connection, which launches on boot, from an onsite machine to a public server, and automatically creates a reverse SSH tunnel to allow for a remote pentester to access a machine on a client network through this tunnel.

The attackbox.py script uses the Python standard library to install a suite of Kali Linux tools, configure SSH keys for root, set up the reverse SSH connection, set it up to run on boot and test the connection.  The attackbox_server.sh script updates the system, sets a root password (needed for initial key transfer from the onsite machine to the public server)

### Equipment

To utilize the AttackBox framework one will need the following equipment/machines:

- A public server: Ubuntu 18.04
- An onsite machine running Kali: This can be a VM or a hardware based machine, such as a NUC
- Domain Name: This is optional. Connections can be set up using an IP, but having a domain name allows the IP to shift if necessary.

The onsite machine or VM image will be set up and tested locally before being deployed to the client.


### Instructions

1. Set Up the Public Server

- SSH into public server as root


- Get software and make executable.

`git clone https://github.com/nothing0x00/AttackBoxV1.git`

`cd AttackBoxV1`

`chmod +x attackbox_server.sh`


- Modify SSH configuration

Allow for PasswordAuthentication:

`nano /etc/ssh/sshd_config`

`PasswordAuthentication yes`

`service ssh restart`


- Run script

`./attackbox_server.sh`

When prompted, set the root password and document for later use.



2. Set up onsite machine

- Install Kali with a desktop environment. Make sure to document the username and password for the non-root user.

- Reboot and log in

- Open a terminal and elevate to root

`sudo su`

- Get software and run

`cd /root`

`git clone https://github.com/nothing0x00/AttackBoxV1.git`

`cd AttackBoxV1`

`python3 attackbox.py`

- Follow the prompts. The script will update apt repositories, then install tools including metapackages for wireless, information gathering, database exploitation, post-exploitation and password cracking tools, as well as ssh and autossh. After the installation of apt packages it will pull WiFite2, Airgeddon and EAPhammer. After installing tools the script checks to see if the root account has SSH keys set up, and if not will generate the keys.

Next, the script asks for the IP or URL of the public server set up earlier, as well as the port that will be forwarded from the public server to the onsite machine (make sure to document this port). The script will then structure the autossh command, build it into a bash script (/root/reverse.sh) and set a cronjob for that script to run on boot. Finally, a test connection will be launched to the public server to test connectivity.

3. Reboot the onsite machine and log into the public server over SSH as root and check that the port forwarding worked on boot.

`netstat -lntp`


4. Lock Down SSH Configuration on Public Server

After connectivity is established and tested, and everything is working, modify the /etc/ssh/sshd_config file on the public server to eliminate PasswordAuthentication.

`nano /etc/ssh/sshd_config`

`PasswordAuthentication no`

`service ssh restart`


5. Connect to the Onsite Machine/VM

While logged into the public server:

`ssh [user on onsite device]@localhost -p [Port set during onsite machine install for port forwarding]`


If disconnected from the onsite machine the autossh configuration will automatically check every 30 seconds to see if the connection is live, and if the connection is down it will relaunch the connection.

### Roadmap

Version 2 will likely involve the following improvements:
- Modularize the framework to operate with one central script and a series of Python modules.
- Automate the SSH configuration on the public server side.
- Add functionality to install software for Raspberry Pi based pentesting dropboxes to be used on physical pentesting engagements.
- Expand attackbox_server.sh for added functionality.
