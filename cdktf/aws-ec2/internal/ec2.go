package internal

import "github.com/aws/jsii-runtime-go"

func newEC2() {
	ec2.NewInstance(stack, jsii.String("ec2-instance"), &ec2.InstanceConfig{
		Ami:                 jsii.String("ami-03d315ad33b9d49c4"),
		InstanceType:        jsii.String("t2.micro"),
		KeyName:             jsii.String("DevOps"),
		VpcSecurityGroupIds: &[]*string{sg.Id()},
		Tags: &map[string]*string{
			"Name":    jsii.String("Ec2-Instance-Golang"),
			"Team":    jsii.String(team),
			"Company": jsii.String(company),
		},
	})
}
