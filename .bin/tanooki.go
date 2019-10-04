package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"sort"

	"github.com/BurntSushi/toml"
	"github.com/urfave/cli"
)

type trackerInfo struct {
	Project int
}

type tanookiConfig struct {
	Tracker trackerInfo
	Foo     string
	Title   string
}

// https://github.com/urfave/cli

func main() {
	app := cli.NewApp()

	var config tanookiConfig
	if _, err := toml.DecodeFile("tanooki.toml", &config); err != nil {
		fmt.Println("Failed to parse tanooki.toml 💥")
		fmt.Println(err)
		return
	}

	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:  "lang, l",
			Value: "english",
			Usage: "Language for the greeting",
		},
		cli.StringFlag{
			Name:  "config, c",
			Usage: "Load configuration from `FILE`",
		},
	}

	app.Commands = []cli.Command{
		{
			Name:    "tracker",
			Aliases: []string{"t"},
			Usage:   "pivotal tracker",
			Subcommands: cli.Commands{
				cli.Command{
					Name: "open",
					Action: func(c *cli.Context) error {
						url := fmt.Sprintf("https://pivotaltracker.com/n/projects/%v", config.Tracker.Project)

						fmt.Println("opening", url)
						_, err2 := exec.Command("open", url).Output()
						if err2 != nil {
							fmt.Println("error occured:", err2)
							os.Exit(1)
						}

						return nil
					},
				},
			},
		},
	}

	sort.Sort(cli.FlagsByName(app.Flags))
	sort.Sort(cli.CommandsByName(app.Commands))

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
