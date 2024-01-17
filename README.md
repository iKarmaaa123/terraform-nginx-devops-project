<h1>Terraform Nginx DevOps Project</h1>

<h2>Brief Overview Of Project</h2>

<p> This project involves installing an nginx web application onto an ec2 instance. The instance is part of a cloud inftrastructure that consists of a VPC with 2 subnets situated in 2 different availaility zones, internet gateway, and an application load balancer.

Within the project I used two modules: one for the ec2 instance (the instance where nginx will be running on), and a VPC (where the instance, and the other important components will be hosted in).  
  
The project involved working with 3 environments: development, which is where I designed and debugged the code; staging, which is where I tested the code to ensure that the quality comes under a production-like environment before application deployment; production, this is environement where the final build of the code goes.</p>

<h2>Directory Structure Of Project</h2>

<p>The project has three directories: environments, modules and tests. Within the environments directory, there are 3 folders for each environment. Each of these enivronment directories will have the same code and files, with the exception of the development directory not having an application load balancer: 


</p>
