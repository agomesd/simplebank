package main

import (
	"database/sql"
	"log"

	"github.com/agomesd/simplebank/api"
	db "github.com/agomesd/simplebank/db/sqlc"
	"github.com/agomesd/simplebank/util"
	_ "github.com/lib/pq"
)



func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}


	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.Port)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
