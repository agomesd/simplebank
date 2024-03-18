postgres:
	docker run --name postgres-latest -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=pita1234 -d postgres:latest

createdb:
	docker exec -it postgres-latest createdb --username=root --owner=root simplebank

dropdb:
	docker exec -it postgres-latest dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:pita1234@localhost:5432/simplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc