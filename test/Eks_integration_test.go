package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestIntegrationVpc(t *testing.T) {
	t.Parallel()
	// region := "eu-west-1"
	terraformOptions := &terraform.Options{
		TerraformDir: "../example",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	endpoint := terraform.Output(t, terraformOptions, "endpoint")
	assert.Contains(t, endpoint, "https://")

}
