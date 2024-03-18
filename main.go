package main

import (
	"database/sql"
	"log"

	"github.com/agomesd/simplebank/api"
	db "github.com/agomesd/simplebank/db/sqlc"
	_"github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable"
	serverAddress = ":8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}