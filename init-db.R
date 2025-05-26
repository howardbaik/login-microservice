library(DBI)
library(RSQLite)
library(digest)

con <- dbConnect(SQLite(), "users.db")
dbExecute(con, "CREATE TABLE users (username TEXT, password_hash TEXT)")
dbExecute(con, "INSERT INTO users VALUES (?, ?)", params = list("jdoe", digest("SuperSecret123!", algo = "sha256")))
dbExecute(con, "INSERT INTO users VALUES (?, ?)", params = list("alim", digest("SuperSuperSecret123!", algo = "sha256")))
dbDisconnect(con)
