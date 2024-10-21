# K3d Cluster with Continuous Integration using Argo CD

## Objective

In this part of the project, you will set up K3d (K3s in Docker) and configure a basic continuous integration (CI) pipeline with Argo CD. You will deploy an application automatically from a GitHub repository into your K3d cluster.

## Key Concepts

### K3S vs K3D

- **K3S**: A lightweight Kubernetes distribution for resource-constrained environments.
- **K3D**: A tool to run K3s in Docker containers, allowing for quick and easy local Kubernetes clusters.

## Steps

### 1. Setup K3D

1. **Install K3D**:
   - First, install Docker on your virtual machine as K3D runs on top of Docker.
   - Write a script that installs all necessary packages and tools, including Docker and K3D.
   - Ensure Docker is running correctly.

### 2. Create Namespaces

1. **Argo CD Namespace**: Create a namespace dedicated to Argo CD for continuous delivery.
2. **Dev Namespace**: Create another namespace named `dev` where your application will be deployed.

### 3. Application Deployment with Argo CD

1. **GitHub Repository**:
   - Create a public GitHub repository containing your Kubernetes configuration files.
   - The repository name must include the login of a member of your group.

2. **Application**:
   - Deploy an application in the `dev` namespace. You can choose between:
     - **Wil’s ready-made application** on DockerHub (`wil42/playground`), or
     - **Your own application** with two versions (v1 and v2) tagged and pushed to a public DockerHub repository.
   - Wil’s application runs on port `8888`. Make sure your app also uses this port if you're building your own.

### 4. Continuous Deployment with Argo CD

1. **Argo CD Setup**: Use Argo CD to automatically deploy the application to the `dev` namespace.
   - Argo CD will sync with your GitHub repository to manage deployments.
   - When the app version changes in GitHub (e.g., switching from `v1` to `v2`), Argo CD will automatically update the app in your K3d cluster.

### 5. Application Versions

- Ensure the application has **two distinct versions**.
- The differences between v1 and v2 must be visible (e.g., UI changes, behavior changes).
- You must be able to switch versions by updating the GitHub repository, and verify that Argo CD correctly updates the application in the cluster.

## Deliverables

1. A **script** that installs all necessary tools (Docker, K3d, Argo CD, etc.) on your virtual machine.
2. A **public GitHub repository** containing the Kubernetes configuration files for your deployment.
3. A **public DockerHub repository** with two tagged versions (v1 and v2) of your application, unless you use Wil's app.
4. A working **K3d cluster** with continuous deployment using Argo CD.

## Useful Links

- Wil’s DockerHub repository: [https://hub.docker.com/r/wil42/playground](https://hub.docker.com/r/wil42/playground)
- K3D documentation: [https://k3d.io](https://k3d.io)
