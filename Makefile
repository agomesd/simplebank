postgres:
	docker run --name postgres-latest -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=pita1234 -d postgres:latest

createdb:
	docker exec -it postgres-latest createdb --username=root --owner=root simplebank

dropdb:
	docker exec -it postgres-latest dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose down 1

migrateforce:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose force 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/agomesd/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown migrateforce sqlc test server mock migrateup1 migratedown1
