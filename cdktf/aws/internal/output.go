package internal

import (
	"github.com/aws/jsii-runtime-go"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
)

func output() {
	cdktf.NewTerraformOutput(stack, jsii.String("public_ip"), &cdktf.TerraformOutputConfig{
		Value: instance.PublicIp(),
	})
}
