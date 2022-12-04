package main

import (
	"github.com/hashicorp/terraform-cdk-go/cdktf"

	"github.com/mohammadne/laboratory/cdktf/aws-ec2/internal"
)

func main() {
	app := cdktf.NewApp(nil)

	internal.NewStack(app, "aws-ec2")

	app.Synth()
}
