# Syncouse Application

## Project Overview

Syncouse is a powerful web application designed to streamline the management of cooperative societies. Whether you are handling member records, billing, announcements, or complaints, Syncouse provides a comprehensive solution. Here are some of its key features:

- **Society Management**: Create and manage multiple cooperative societies, each with its own network.
- **Admin Controls**: Society admins can serve various roles such as secretaries and managers, allowing for effective management and communication.
- **Billing and Payments**: Admins can set up and send billing structures for maintenance fees with due dates. Members can conveniently make payments using UPI.
- **Announcements**: Admins can make announcements and notices that members can view, ensuring that important information is communicated effectively.
- **Complaints Handling**: Members can submit complaints which are then visible to admins for resolution.

### How to Use

1. **Register a New Society**

   If your society is not yet created, register as an admin by providing a new society code. Share this code with members and other admins to establish your society network.

2. **Start Managing**

   Once the network is set up, you can start using Syncouse to manage members, send bills, make announcements, and handle complaints.

### Tech Stack

**Development:**

- **Backend**: Built with [Spring Boot](https://spring.io/projects/spring-boot) for a robust and scalable backend solution.
- **Frontend**: Utilizes [Bootstrap](https://getbootstrap.com/), HTML, CSS, and jQuery for a responsive and interactive user interface.
- **Database**: [MySQL](https://www.mysql.com/) is used for storing and managing data.

**DevOps:**

- **Docker**: Containerized the application and MySQL database to ensure consistent environments across development and production.
- **Kubernetes**: Deployed the Docker containers on [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/), providing scalability, high availability, and efficient management.
- **Azure AKS**: Orchestrates the containers, allowing seamless scaling and management of application instances.

### Access the Application

You can access the Syncouse application at [http://4.213.220.89:8080/](http://4.213.220.89:8080/).

## DevOps Architecture

The DevOps architecture for Syncouse ensures that the application is highly available and easy to manage. Here’s how it works:

1. **Dockerization**: Both the Syncouse application and the MySQL database are packaged into Docker containers. This encapsulates all dependencies and configurations, ensuring that the application runs consistently across different environments.

2. **Kubernetes Deployment**: The Docker containers are deployed on Azure Kubernetes Service (AKS). Kubernetes manages the deployment, scaling, and operation of the containers. It handles load balancing, monitors the health of the application, and ensures that the right number of containers are running.

3. **Azure AKS**: Provides a managed Kubernetes environment on Azure. It simplifies the deployment and management of Kubernetes clusters, offering built-in support for scaling, networking, and security.

With this setup, you get a reliable and scalable application infrastructure that can handle varying loads and ensure continuous availability.

