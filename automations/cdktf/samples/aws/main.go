package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/mohammadne/laboratory/cdktf/aws/cmd"
	"github.com/spf13/cobra"
)

const description = "AWS is used to provision aws instances"

func main() {
	channel := make(chan os.Signal, 1)
	signal.Notify(channel, syscall.SIGINT, syscall.SIGTERM)

	root := &cobra.Command{Short: description}
	root.AddCommand(cmd.EC2{}.Command(channel), cmd.EC2{}.Command(channel))

	if err := root.Execute(); err != nil {
		fmt.Println(err.Error())
		panic(map[string]interface{}{"err": err, "msg": "failed to execute root command"})
	}
}
