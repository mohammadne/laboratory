package internal

import (
	"cdk.tf/go/stack/generated/aws"
	"github.com/aws/jsii-runtime-go"
)

func newProvider() {
	aws.NewAwsProvider(stack, jsii.String("AWS"), &aws.AwsProviderConfig{
		Region: jsii.String("us-east-1"),
	})
}
