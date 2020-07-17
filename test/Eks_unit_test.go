package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestUnitVpc(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../example",
	}

	defer terraform.Destroy(t, terraformOptions)

	output := terraform.InitAndPlan(t, terraformOptions)
	assert.Contains(t, output, "Plan:")
}
