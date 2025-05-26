library(digest)

hash_password <- function(password) {
  digest(password, algo = "sha256")
}
