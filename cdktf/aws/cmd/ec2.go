package cmd

import (
	"os"

	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
	"github.com/spf13/cobra"
)

type EC2 struct{}

func (r EC2) Command(trap chan os.Signal) *cobra.Command {
	run := func(_ *cobra.Command, _ []string) { r.main(trap) }
	cmd := &cobra.Command{Use: "ec2", Short: "create aws ec2", Run: run}
	return cmd
}

func (EC2) main(trap chan os.Signal) {
	app := cdktf.NewApp(nil)
	defer app.Synth()

	var id = "aws"
	stack := cdktf.NewTerraformStack(app, &id)

	cdktf.NewRemoteBackend(stack, &cdktf.RemoteBackendProps{
		Hostname:     jsii.String("app.terraform.io"),
		Organization: jsii.String("jigsaw373"),
		Workspaces:   cdktf.NewNamedRemoteWorkspace(jsii.String("cdktf-go-aws-ec2")),
	})

}

func NewMyStack(scope constructs.Construct, id string) cdktf.TerraformStack {
	stack := cdktf.NewTerraformStack(scope, &id)

	// The code that defines your stack goes here

	return stack
}
