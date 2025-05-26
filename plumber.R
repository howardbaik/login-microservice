library(plumber)
library(DBI)
library(RSQLite)
library(jsonlite)

# Source util function
source("utils.R")

#* @apiTitle Login Verification Microservice
#* @apiDescription Authenticates user login credentials

#* POST /login
#* @param req The request body as JSON (username + password)
#* @post /login
function(req, res) {
  body <- fromJSON(req$postBody)
  
  if (is.null(body$username) || is.null(body$password)) {
    res$status <- 400
    return(list(message = "Missing username or password"))
  }
  
  result <- verify_credentials(body$username, body$password)
  
  if (result$success) {
    res$status <- 200
    return(list(message = "Login successful", token = result$token))
  } else {
    res$status <- 401
    return(list(message = result$message))
  }
}

# Establish DB connection
db <- DBI::dbConnect(RSQLite::SQLite(), "users.db")

verify_credentials <- function(username, password) {
  query <- "SELECT username, password_hash FROM users WHERE username = ?"
  user_data <- dbGetQuery(db, query, params = list(username))
  
  if (nrow(user_data) == 0) {
    return(list(success = FALSE, message = "User not found"))
  }
  
  hashed <- hash_password(password)
  
  if (user_data$password_hash == hashed) {
    token <- paste0(sample(c(LETTERS, 0:9), 20, replace = TRUE), collapse = "")
    return(list(success = TRUE, token = token))
  } else {
    return(list(success = FALSE, message = "Incorrect password"))
  }
}