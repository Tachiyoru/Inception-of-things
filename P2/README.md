# K3s Web Application Deployment with Vagrant

## Objective
The goal of this exercise is to deploy three web applications in a K3s cluster using Vagrant. Each application should be accessible via a specific hostname, depending on the client request to the IP address `192.168.56.110`.

### Requirements:
1. **Virtual Machine**: One virtual machine with the latest stable version of a Linux distribution (e.g., Debian).
2. **K3s in Server Mode**: Install and configure K3s in server mode.
3. **Web Applications**: Deploy three web applications in your K3s cluster.
    - **App1**: Accessed when the client uses the `Host: app1.com`.
    - **App2**: Accessed when the client uses the `Host: app2.com`.
    - **App3**: Default app, accessed when neither `app1.com` nor `app2.com` is used.
4. **Replicas**: Ensure application 2 has 3 replicas.

## Key Concepts:
- **Vagrant**: An open-source tool that simplifies creating and managing virtualized development environments. In this project, Vagrant automates the setup of a VM with K3s.
- **K3s**: A lightweight version of Kubernetes ideal for low-resource environments. It is used to orchestrate the deployment of web applications within your VM.
- **Ingress**: Ingress configuration is used to route traffic based on the hostname to different web applications in your cluster.
- **Services**: Services expose your applications inside the cluster and allow traffic to reach the web apps.

## Steps:
1. **Set up the VM**: Use Vagrant to create and configure a virtual machine.
2. **Install K3s**: Install K3s in server mode on the VM.
3. **Deploy Web Applications**: Set up 3 web applications inside the K3s cluster.
4. **Configure Ingress**: Set up an ingress controller to route traffic to the correct application based on the requested hostname.
5. **Test Access**: Verify that you can access each app via `app1.com`, `app2.com`, and `app3.com`.

## Useful Commands:
- `kubectl get services` - To check the status of the services in the cluster.
- `kubectl get ingress` - To check the ingress configuration.
- `kubectl describe ingress <name>` - To inspect ingress details.

## Note:
During the final defense, you will need to demonstrate your working ingress setup.
