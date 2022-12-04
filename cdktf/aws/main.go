package main

import (
	"fmt"

	"github.com/mohammadne/laboratory/cdktf/aws/cmd"
	"github.com/spf13/cobra"
)

const description = "AWS is used to provision aws instances"

func main() {
	root := &cobra.Command{Short: description}
	root.AddCommand(cmd.VPS{}.Command(channel), cmd.EC2{}.Command(channel))

	if err := root.Execute(); err != nil {
		fmt.Println(err.Error())
		panic(map[string]interface{}{"err": err, "msg": "failed to execute root command"})
	}
}
