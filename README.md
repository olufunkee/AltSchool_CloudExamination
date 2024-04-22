STEPS IN CARRYING OUT ALTSCHOOL CLOUD ENGINEERING SECOND SEMESTER EXAMINATION PROJECT

- A new folder was opened for the project and named ansible_project

- Vagrant was initialized using 'vagrant init' command

- The provisioning of two ubuntu-based servers were automated using vagrant - Two virtual machines were defined and configured: ansible_master and ansible_slave with respective ip addresses of 192.168.33.22 and 192.168.33.23

- The vagrantfile was saved and the virtual machines were started using 'vagrant up' command

- Using the 'vagrant ssh ansible_master', the master node was accessed

- Using the 'vagrant ssh ansible_slave', the slave node was accessed

- On the master node, a bash script was created to automate the deployment of LAMP

- The script clones a PHP application from Github, all necessary packages were installed, Apache web server configured and MySQL

- The script was ensured to be reusable and easily readable

- SSH key was generated on the master node and was added to the ssh/authorization keys on the slave node to create a connection

- Still on the master node, the host file was created to add in the IP address (inventory) of the slave node

- The command 'ansible all -m ping -i host' was run to ensure connectivity to the slave node

- The playbook.yml file was then created and edited to include all the instructions for the slave nodes which included; copying and running of the bash script on the slave node, verifying PHP accessibility through the VM's IP address and creating a cron job to cheeck the server's uptime every 12am

- The playbook was run on the master node by running the command 'ansible-playbook -i host'

- On ensuring a successful playbook run, the PHP application was accessed by opening a web browser and navigating to the IP address 192.168.33.23 of the slave node
