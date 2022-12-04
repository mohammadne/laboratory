package config

import (
	"fmt"
	"log"
	"strings"

	"github.com/davecgh/go-spew/spew"
	"github.com/knadh/koanf"
	"github.com/knadh/koanf/providers/env"
	"github.com/knadh/koanf/providers/structs"
	"gitlab.snapp.ir/dispatching/in-app-call/heliograph/internal"
)

const (
	PREFIX    = "AWS_"
	delimeter = "."
	seperator = "__"

	tagName = "koanf"

	upTemplate     = "================ Loaded Configuration ================"
	bottomTemplate = "======================================================"
)

func Load(print bool) (*Config, error) {
	k := koanf.New(delimeter)

	// load default configuration
	if err := k.Load(structs.Provider(Default(), "koanf"), nil); err != nil {
		log.Fatalf("error loading default config: %v", err)
	}

	// load environment variables
	if err := LoadEnv(k); err != nil {
		return nil, fmt.Errorf("error loading default values: %v", err)
	}

	config := Config{}
	var tag = koanf.UnmarshalConf{Tag: tagName}
	if err := k.UnmarshalWithConf("", &config, tag); err != nil {
		return nil, fmt.Errorf("error unmarshalling config: %v", err)
	}

	if print {
		// pretty print loaded configuration using provided template
		log.Printf("%s\n%v\n%s\n", upTemplate, spew.Sdump(config), bottomTemplate)
	}

	return &config, nil
}

func LoadEnv(k *koanf.Koanf) error {
	var prefix = strings.ToUpper(internal.Subsystem) + seperator

	callback := func(source string) string {
		base := strings.ToLower(strings.TrimPrefix(source, prefix))
		return strings.ReplaceAll(base, seperator, delimeter)
	}

	// load environment variables
	if err := k.Load(env.Provider(prefix, delimeter, callback), nil); err != nil {
		return fmt.Errorf("error loading environment variables: %s", err)
	}

	return nil
}
