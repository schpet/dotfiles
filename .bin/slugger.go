package main

import (
	"bufio"
	"fmt"
	"github.com/gosimple/slug"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		fmt.Println(slug.Make(scanner.Text()))
	}
}
