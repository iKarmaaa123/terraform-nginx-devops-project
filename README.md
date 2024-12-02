
<h1>Terraform Nginx DevOps Project </h1>

<h2> Project Overview </h2>

This Terraform-driven project focuses on deploying an Nginx web server onto an EC2 instance within a robust cloud infrastructure. The architecture comprises a Virtual Private Cloud (VPC) with two strategically placed subnets in different availability zones, an internet gateway facilitating external communication, and an Application Load Balancer (ALB) for efficient traffic distribution.

The project incorporates two essential modules: one for configuring the EC2 instance (the host for Nginx) and another for establishing the VPC housing the instance and other crucial components.

<h2> Project Directory Structure </h2>

The project's structure is organized into three main directories: environments, modules, and tests. The environments directory features three subdirectories for each environment: development, staging, and production. While each environment shares common files, the development directory omits the configuration for an application load balancer. The modules directory houses two folders: webapp for the EC2 instance and vpc for the network infrastructure. The tests directory contains files for Terratests, facilitating thorough testing of the cloud infrastructure using Golang.

At the project's root, a .gitlab-ci.yml file orchestrates a CI/CD pipeline, streamlining the deployment of cloud resources on AWS. This automated pipeline enhances efficiency, enabling swift updates to the infrastructure.

<h2> Environment Files </h2>

<p>
Each environment directory contains the same set of files:

.gitignore: Safeguards sensitive credentials and passwords from being pushed to GitHub.

main.tf: Instantiates both modules, defining the structure of the cloud infrastructure.

terraform.tfvars: Custom variables tailored for the project.

variables.tf: Establishes default variables for the project.

versions.tf: Determines the Terraform and AWS versions to use and specifies the deployment region. Notably, the staging and production environments incorporate code for creating an application load balancer, absent in the development environment.
</p>

<h2> Modules </h2>
<p>
In Terraform, a module encapsulates a set of related resources to be managed collectively. For this project, two modules were created: webapp for the EC2 instance and vpc for the network infrastructure. Each module directory comprises three essential files:

main.tf: Defines the creation of the instance and related resources.

output.tf: Specifies output values communicated to other modules.

variables.tf: Establishes default Terraform variables, serving as placeholder values.
</p>

<h2> GitLab CI/CD Pipeline </h2>

<p>
The CI/CD pipeline automates the deployment process through three stages for each environment: terraform plan, terraform apply, and terraform destroy. Leveraging an S3 remote backend ensures a shared state, preventing conflicts across stages. This approach eliminates the need for individual local backends, emphasizing a cohesive and consistent infrastructure.
</p>

<h2> Testing with Terratest </h2>

<p>
Terratests play a pivotal role in validating various aspects of the infrastructure. The tests directory includes:

examples: Holds module folders for comprehensive testing.

.gitignore: Excludes unnecessary files from version control.

vpc_test.go: Orchestrates tests for the VPC, checking public subnet counts, verifying CIDR block values, and ensuring correct resource deployment to the specified region.

webapp_test.go: Conducts tests for the EC2 instance, validating the accuracy of the public IP address and assessing reachability through an HTTP request on port 80.

The testing strategy embraces future enhancements, potentially including connectivity tests through an ALB to ascertain the instance's accessibility via an Application Load Balancer.

This meticulously structured project, complete with an automated CI/CD pipeline and comprehensive testing suite, ensures the resilience, scalability, and reliability of the deployed infrastructure.
</p>

<h2> Changes That Could Be Made To The Architectural Design Of The Project </h2>

<p> 
As mentioned earlier, this Terraform architecture consists of a VPC hosting two public instances in separate availability zones. There is an Application Load Balancer with an internet gateway.

The project's architecture could have benefited from utilizing private instances stored in private subnets, along with databases also placed within private subnets. The rationale behind this is that while users access the Nginx web application, access logs, security logs, performance metrics, and error logs could be collected and sent to the database, providing a means of assessing the application's state.

The project could have employed public subnets as bastion hosts for the application hosted on two private instances. The bastion host would act as an entry point for users to gain access to Nginx. There are several advantages to this architectural framework:

- Authentication and Authorization: The bastion host serves as a point for authentication. Users must authenticate themselves to the bastion host before gaining access to other servers. This allows for central control and management of user access, ensuring that only authorized users can access the internal network.

- Logging and Monitoring: All remote access to the internal network is funneled through the bastion host, making it a centralized point for logging and monitoring. This aids in auditing user activity, detecting suspicious behavior, and maintaining an audit trail for security purposes.

- Rolling updates and maintenance: Regular maintenance and updates are applied to the bastion host to address security vulnerabilities and ensure that it remains a secure entry point.

- Reduced Attack Surface: By limiting direct access to private instances and exposing only the bastion host to the internet, you reduce the attack surface. The security measures and configurations on the bastion host can be tightly controlled, minimizing the risk of unauthorized access.
</p>
