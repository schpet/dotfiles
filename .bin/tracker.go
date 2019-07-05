package main

import (
	"fmt"
	"os"
	"os/exec"
	"regexp"
)

func main() {
	if len(os.Args) == 1 {
		fmt.Println(`usage: tracker <command>

Commands are one of

  url    print the link to the tracker story

  open   open the tracker story
`)
		os.Exit(1)
	}

	branch, err := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD").Output()
	if err != nil {
		fmt.Printf("error occured: %s", err)
		os.Exit(1)
	}

	branchStr := string(branch)

	re := regexp.MustCompile("[0-9]+")
	match := re.FindString(string(branch))

	if match == "" {
		fmt.Printf("no tracker id in branch: %s", branchStr)
		os.Exit(1)
	}

	url := "https://www.pivotaltracker.com/story/show/" + match

	actionArg := os.Args[1]

	switch actionArg {
	case "open":
		_, err2 := exec.Command("open", url).Output()
		if err2 != nil {
			fmt.Println("error occured:", err2)
			os.Exit(1)
		}
		fmt.Println("opening ", url)
	case "url":
		fmt.Println(url)
	default:
		fmt.Println("unknown action")
	}
}
