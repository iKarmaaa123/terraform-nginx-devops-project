<h1>Terraform Nginx DevOps Project</h1>

<h2>Brief Overview Of Project</h2>

<p> This project involves installing an nginx web application onto an ec2 instance. The instance is part of a cloud inftrastructure that consists of a VPC with 2 subnets situated in 2 different availaility zones, internet gateway, and an application load balancer.

Within the project I used two modules: one for the ec2 instance (the instance where nginx will be running on), and a VPC (where the instance, and the other important components will be hosted in).  
  
The project involved working with 3 environments: development, which is where I designed and debugged the code; staging, which is where I tested the code to ensure that the quality comes under a production-like environment before application deployment; production, this is environement where the final build of the code goes.</p>

<h2>Directory Structure Of Project</h2>

<p>The project has three directories: environments, modules and tests. Within the environments directory, there are 3 folders for each environment. Each of these enivronment directories will have the same code and files, with the exception of the development directory not having an application load balancer. Within the modules directory, there are 2 folders: a webapp folder, and a vpc folder. 
  
The webapp folder contains the files that are used to create an ec2 instance. The vpc folder contains files need to create the network infrastructure where the instance will be hosted on. The tests directory contains files for terratests that are used to test the cloud infrastructure on golang. 

Outside of these directories is a .gitlab-cy.yml file - this is a CI/CD pipeline that will be utilised to deploy the cloud resources for my project to AWS. A CI/CD pipeline was used to automate the deployment process, making it easier to send swift updates to the infrastructure. Now that we have delved into the directory structure of the project, it is time to go over all the files within these environment directories.
</p>

<h2>Files Within Each Environment directory</h2>

<p> Each environment directory contains the same files: .gitignore, main.tf, terraform.tfvars, variables.tf, versions.tf.

- .gitignore: used to ignore pushing certain files to GitHub in order to protect important credentials and passwords
  
- main.tf: where both modules are being instantiated
  
- terraform.tfvars: custom variables for our project

- variables.tf: where the default variables for the project are created

- versions.tf: file where we set up what version of terraform and aws we would like to use. We also decide what region we would like to deploy our cloud resources to.

Within the staging and production environment, there is a block of code for th creation of an application load balancer. This is not in the dev environment main.tf file. Now that we have discussed about the contents within the environement directory it is time to move over to the main part of project; that being the custom modules that I created.
</p>

<h2> Modules </h2>

<p> In Terrafom, a module is a set of related resources that can be managed together. It enables the user to organise their infrastructure code in a modular and reusable way.

As mentioned earlier, for the project we created two terraform modules: one for the ec2 instance, and one for the vpc.

Within each module directory there are 3 files: main.tf, output.tf and variables.tf.

- main.tf: where the instance, and all the related resources are created.

- output.tf: creating output values that will be passed onto other modules.

- variables.tf: creating default terraform variables which are placeholder values.
</p>

<h2> Tests </h2>

<p> The project utilised terratests to help test various aspects of the infrastructure. For example, to see if we are using the correct vpc cidr block value or using the correct public subnet cidr block value 

The tests directoy has the following folder and files: examples, .gitignore, vpc_test.go, webapp_test.go. The examples folder consists of the modules folders that we are using to test to see if everything works as expected. 

The vpc_test.go file is where we set up a number of tests for our vpc: some of the tests consist of checking the number of public subnets within the network infrastructure, outputting the correct cidr block values for both vpc and both public subnets, and making sure that the resources we create are being deployed to the correct region.

The webapp_test.go file is where we set up a number of tests for our ec2 instance: checking to see if the instance is outputting the correct public_ip address which then used for another test that involves establishing a http request on port 80 to see if the the instance is reachable. Future tests that I could potentially do is trying to connect to the instance via an ALB, to see if the instance can be reached when accessing it via an application load balancer.
</p>


