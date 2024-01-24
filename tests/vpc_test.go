package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestTerraformAwsNetworkExample(t *testing.T) {
	t.Parallel()

	// Give the VPC and the subnets correct CIDRs
	vpcCidr := "10.0.0.0/16"
	publicSubnetCidr := []string{"10.0.1.0/24", "10.0.2.0/24"}
	awsRegion := "us-east-1"

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./examples/vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_cidr_block":           vpcCidr,
			"public_subnet_cidr_block": publicSubnetCidr,
			"region":                   awsRegion,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of output variables
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	publicSubnetIds := terraform.OutputList(t, terraformOptions, "public_subnet_id")

	// Get information about subnets
	Subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)

	// Verify that there are two subnets
	require.Equal(t, 2, len(Subnets))

	// Verify if the network that is supposed to be public is really public
	for _, publicSubnetId := range publicSubnetIds {
		assert.True(t, aws.IsPublicSubnet(t, publicSubnetId, awsRegion))
	}
}
