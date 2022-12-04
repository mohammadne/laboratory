package internal

import "github.com/aws/jsii-runtime-go"

func Provider() {
	awsprovider.NewAwsProvider(stack, jsii.String("AWS"), &awsprovider.AwsProviderConfig{
		Region: jsii.String("us-west-1"),
	})
}
