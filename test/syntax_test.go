package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSyntax(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}
	terraform.RunTerraformCommand(t, terraformOptions, terraform.FormatArgs(terraformOptions, "fmt", "--check")...)

}
