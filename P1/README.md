# Part 1 of the project

## Explaination

We are going to have **2** machines.  
They must have the login of a member of the team.  
They need to have a dedicated IP on the eth1 interface.  
K3s need to be installed on both machines.  
they are going to have the minimum of ressources :  
- 1 CPU
- 1024 Ram

###  1<sup>er</sup> Machine
- The hostname must be followed by the letter `S` for `Server`.  
- The IP will be `192.168.56.110`.  
- K3s is in controller mode.

### 2<sup>e</sup> Machine
- The hostname must be followed by the letter `SW` for `Server Worker`.  
- The IP will be `192,168,56,111`.
- K3s need to be in agend mode.


<!-- You must install K3s on both machines:
• In the first one (Server), it will be installed in controller mode.
• In the second one (ServerWorker), in agent mode. -->