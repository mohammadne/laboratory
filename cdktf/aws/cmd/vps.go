package cmd

import (
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
	"github.com/spf13/cobra"
)

type VPS struct{}

func (r VPS) Command(app cdktf.App) *cobra.Command {
	run := func(_ *cobra.Command, _ []string) { r.main(app) }
	cmd := &cobra.Command{Use: "vps", Short: "create aws vps", Run: run}
	return cmd
}

func (VPS) main(app cdktf.App) {
	app := cdktf.NewApp(nil)

	NewMyStack(app, "aws")

	app.Synth()
}

func NewMyStack(scope constructs.Construct, id string) cdktf.TerraformStack {
	stack := cdktf.NewTerraformStack(scope, &id)

	// The code that defines your stack goes here

	return stack
}
