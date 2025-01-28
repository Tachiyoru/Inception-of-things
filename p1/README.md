# K3s Cluster Setup with Vagrant

## Objective

This part of the project involves setting up **two virtual machines** using Vagrant. The goal is to configure a K3s cluster with the following roles:

- **Server (Controller)**: Manages the cluster and controls the workloads.
- **Server Worker (Agent)**: Runs the workloads based on instructions from the control plane.

## Requirements

1. **Two Machines**: Each machine must be named after a member of the team, followed by `S` for Server and `SW` for Server Worker.
2. **Dedicated IPs**: 
   - Server (Controller): `192.168.56.110`
   - Server Worker (Agent): `192.168.56.111`
   - These IPs must be set on the `eth1` interface.
3. **Minimum Resources**: Both machines must have:
   - 1 CPU
   - 1024 MB RAM

### Server (Controller)

- Hostname: `<login>S`
- IP: `192.168.56.110`
- K3s will run in **controller mode**:
  - Manages the cluster (API Server, Scheduler, Controller Manager, etcd).
  - Can run pods, but it's not recommended in production.
  - Manages the control plane.

### Server Worker (Agent)

- Hostname: `<login>SW`
- IP: `192.168.56.111`
- K3s will run in **agent mode**:
  - Executes workloads (pods) based on instructions from the control plane.
  - Runs Kubelet, Kube-proxy, and container runtime.
  - Primarily runs pods and containers.

## Steps

1. **Create the Vagrantfile**:
   - Use the latest stable Linux distribution (e.g., Debian).
   - Configure VMs with 1 CPU, 1024 MB RAM, and the dedicated IPs as mentioned.
2. **Install K3s**:
   - On the Server, install [K3s](https://docs.k3s.io/) in controller mode.
   - On the Server Worker, install K3s in agent mode.
3. **Install kubectl**:
   - Ensure `kubectl` is installed on both machines to manage the cluster.

## Key Points

- Use SSH to connect to both machines without a password.
- Ensure the cluster is properly set up and that both machines communicate correctly.

## Useful Commands

- `kubectl get nodes` - To check if the nodes are registered and ready.
- `kubectl get pods -A` - To check all pods in the cluster.
