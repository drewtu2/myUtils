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

## Setup 
Edit the sshd_config file on the Protected Machine to allow remote hosts to forwarded ports. 
`$ sudo vim /etc/ssh/sshd_config`

Add (or uncomment or change) 
`GatewayPorts yes`

Restart SSH
`$ sudo service ssh restart`

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


