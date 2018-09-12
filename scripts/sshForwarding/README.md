# SSH Tunneling through Remote Forwarding

I came across the issue where I needed to gain remote access to a machine behind
my university's firewall. While I had originally been using Teamviewer to connect
to and control the machine remotely, for whatever reason, Teamviewer stopped
working and I was no longer able to connect to my remote machine. 

SSH Remote forwarding was something I'd heard about before, but at the time, Teamviewer 
was working fine and I had little motivation to sort through to figure out how
to set it up.

## Overview 

```
              1.
              ssh -R rp:lh:lp user@external            2.
                                                       ssh user@external
                 +----------+
+------------+   |          |       +------------------+      +-----------------+
|            +---------------------->                  |      |                 |
| Protected  |   | Firewall |       | External Server  <------+ Outside Machine |
|  Machine   <----------------------+                  |      |                 |
+------------+   |          |       +------------------+      +-----------------+
                 +----------+
              3.
              ssh user@local -p lp

```

The main problem solved by the SSH tunnel is as follow: given that your machine
is inaccessible to the outside world, how do you establish a remote connection
to gain access? To solve this problem, we can use a third party, an external server
accessible to both machines to serve as the middle man and broker a connection. 

In this instance, I set up an AWS EC2 instance to serve as the external server
accessible to both machines. 


## Connecting
1. From the protected machine: `ssh -nNT -R rp:localhost:22 user@external.com`
  - `-nNT` supresses output and does not create a TTY instance to the remote machine. 
  Ideal for running as a background task. 
  - rp should be whatever port the remote host will be listening on to forward to 
  the ssh port. This is the port we will eventualy use to connect to the machine. 
  - For SSH default, we need to connect to localhost:22 because that is where the 
  SSH server is running. If we change where it's running, we will need to change the
  port here too. 
2. SSH from the outside machine into the middle man. 
`ssh user@external`
3. From the middle man, we can now attempt to connect back to the Protected Machine. 
`ssh user@localhost -p rp`

## Adding to Startup
Add the ssh connection from protected machine to external server to `/etc/rc.local`
to initiate the connection at startup. 

# Setup for Protected Machine 
0. Make sure ssh server is installed...
  - `systemctl restart ssh; systemctl status ssh` - should return error if not installed
  - If not installed, run: `sudo apt-get install openssh-server`
1. Add SSH Public Key to external server (AWS or GoogleCloud) instance. 
  - If Key Doesn't exist
    ```
    ssh-keygen -t rsa -b 4096 -C "drewtu2@yahoo.com"
    ```
    Keep hitting enter/yes until you get back to the normal screen
  - Once Key Exists
    ```
    sudo apt-get install xclip              # Installs xclip
    xclip -sel clip < ~/.ssh/id_rsa.pub     # Copys id_rsa.pub contents to paste buffer
    ```

2. Edit `/etc/ssh/sshd_config` to allow remote hosts to forwarded ports
    ```
    sudo echo GatewayPorts yes >> /etc/ssh/sshd_config
    ```
3. Restart SSH
    - `$ sudo service ssh restart`
4. From protected machine, setup the connection to GoogleCloud.
    - `ssh -nNT -R 5900:localhost:22 drewtu2@35.231.130.218 &`

5. Add to Crontab to boot on startup
  ```
  crontab -e
  ```
  This will open a window where you can add commands. Type the following and save
  ```
  @reboot $MYUTILS_HOME/scrips/sshforwarding/connectToExternal.sh
  ```
6. Add Client Side Keep Alive
  ```
  echo ServerAliveInterval 120 >> /etc/ssh/sshd_config
  #echo ServerAliveCountMax 720 >> /etc/ssh/sshd_config
  ```

# Setup of External Server (middle man)

Prevent the ssh connection from timing out from the server side by sending null
packets every 120 seconds
```
sudo echo ClientAliveInterval 120 >> /etc/ssh/sshd_config
#sudo echo ClientAliveCountMax 720 >> /etc/ssh/sshd_config
```
