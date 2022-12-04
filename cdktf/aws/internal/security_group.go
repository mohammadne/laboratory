package internal

import "github.com/aws/jsii-runtime-go"

func securityGroup() {
	vpc.NewSecurityGroup(stack, jsii.String("security-group"), &vpc.SecurityGroupConfig{
		Name:        jsii.String("CDKtf-TypeScript-Demo-sg"),
		Description: jsii.String("Allow traffic to the instance"),
		Ingress: []vpc.SecurityGroupIngress{
			vpc.SecurityGroupIngress{
				Protocol:   jsii.String("tcp"),
				FromPort:   jsii.Number(80),
				ToPort:     jsii.Number(80),
				CidrBlocks: &[]*string{jsii.String("0.0.0.0/0")},
			},
			vpc.SecurityGroupIngress{
				Protocol:   jsii.String("tcp"),
				FromPort:   jsii.Number(22),
				ToPort:     jsii.Number(22),
				CidrBlocks: &[]*string{jsii.String("0.0.0.0/0")},
			},
			vpc.SecurityGroupIngress{
				Protocol:   jsii.String("tcp"),
				FromPort:   jsii.Number(443),
				ToPort:     jsii.Number(443),
				CidrBlocks: &[]*string{jsii.String("0.0.0.0/0")},
			},
		},
		Egress: []vpc.SecurityGroupEgress{
			vpc.SecurityGroupEgress{
				Protocol: jsii.String("-1"),
				FromPort: jsii.Number(0),
				ToPort:   jsii.Number(0),
			},
		},

		Tags: &map[string]*string{
			"Name":    jsii.String("Security-Group-Golang-Ec2"),
			"Team":    jsii.String(team),
			"Company": jsii.String(company),
		},
	})
}
