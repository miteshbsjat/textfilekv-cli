package main

import (
	"fmt"
	"log"

	"github.com/miteshbsjat/textfilekv"
	"github.com/spf13/cobra"
)

var (
	fileName string
	key      string
	value    string
)

var rootCmd = &cobra.Command{
	Use:   "textfilekv-cli",
	Short: "A command-line interface for textfilekv",
}

var setCmd = &cobra.Command{
	Use:   "set",
	Short: "Add or update a key-value pair",
	Run:   setAction,
}

var getCmd = &cobra.Command{
	Use:   "get",
	Short: "Retrieve the value for a given key",
	Run:   getAction,
}

var deleteCmd = &cobra.Command{
	Use:   "delete",
	Short: "Delete a key-value pair",
	Run:   deleteAction,
}

func init() {
	setCmd.Flags().StringVarP(&fileName, "file", "f", "", "Path to the text file")
	setCmd.Flags().StringVarP(&key, "key", "k", "", "Key for the key-value pair")
	setCmd.Flags().StringVarP(&value, "value", "v", "", "Value for the key-value pair")
	setCmd.MarkFlagRequired("file")
	setCmd.MarkFlagRequired("key")
	setCmd.MarkFlagRequired("value")

	getCmd.Flags().StringVarP(&fileName, "file", "f", "", "Path to the text file")
	getCmd.Flags().StringVarP(&key, "key", "k", "", "Key to retrieve")
	getCmd.MarkFlagRequired("file")
	getCmd.MarkFlagRequired("key")

	deleteCmd.Flags().StringVarP(&fileName, "file", "f", "", "Path to the text file")
	deleteCmd.Flags().StringVarP(&key, "key", "k", "", "Key to delete")
	deleteCmd.MarkFlagRequired("file")
	deleteCmd.MarkFlagRequired("key")

	rootCmd.AddCommand(setCmd)
	rootCmd.AddCommand(getCmd)
	rootCmd.AddCommand(deleteCmd)
}

func main() {
	if err := rootCmd.Execute(); err != nil {
		log.Fatal(err)
	}
}

func setAction(cmd *cobra.Command, args []string) {
	store, err := textfilekv.NewKeyValueStore(fileName)
	if err != nil {
		log.Fatal(err)
	}

	if err := store.Set(key, value); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Key-value pair added or updated successfully.")
}

func getAction(cmd *cobra.Command, args []string) {
	store, err := textfilekv.NewKeyValueStore(fileName)
	if err != nil {
		log.Fatal(err)
	}

	val, exists := store.Get(key)
	if !exists {
		log.Fatalf("Not found key = %v\n", key)
	}

	fmt.Println(val)
}

func deleteAction(cmd *cobra.Command, args []string) {
	store, err := textfilekv.NewKeyValueStore(fileName)
	if err != nil {
		log.Fatal(err)
	}

	if err := store.Delete(key); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Key-value pair deleted successfully.")
}
