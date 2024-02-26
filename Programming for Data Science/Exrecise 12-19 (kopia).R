# Exercise 12
SieveOfEratosthenes <- function(num) {
  prime <- rep(TRUE, num+1)
  
  p <- 2
  while (p * p <= num) {
    if (prime[p] == TRUE) {
      for (i in seq(p * p, num+1, p)) {
        prime[i] <- FALSE
      }
    }
    p <- p + 1
  }
  
  for (p in seq(2, num+1)) {
    if (prime[p] == TRUE) {
      print(p)
    }
  }
}

SieveOfEratosthenes(30)
SieveOfEratosthenes(1000000)



# Exercise 13
library(Matrix)

entries <- seq(1:100)
matrix <- diag(x = entries)
inverse_matrix <- solve(matrix)
identity_matrix <- matrix %*% inverse_matrix

matrix

inverse_matrix

identity_matrix

# Exercise 14
x = matrix(1:6,nrow=3,byrow=T)
y = as.matrix(1:3)
z = as.matrix(1:2)
t = matrix(1:4,2)
v = 1:3


x*x%*%z*z
(x*x)%*%(z*z)
x%*%z*x%*%z
z%*%x*z%*%x
t(z)%*%t(x)*t(z)%*%t(x)
y%*%t(y)
t(y)%*%y
Y=array(y,c(1,3))
Y==t(y)
v%*%v
t(v)%*%v
v%*%t(v)



# Exercise 15
telephone_book <- list(
  "Oscar Winger" = "123-456-7890",
  "Victor Snow" = "987-654-3210",
  "Cleas White" = "012-345-9876",
  "Filip Little" = "987-654-3210",
  "Viktor Goodman" = "091-827-3645"
)

get_phone_number <- function(name) {
  if (name %in% names(telephone_book)) {
    return(telephone_book[[name]])
  } else {
    return("Name not found in the telephone book.")
  }
}

name <- "Oscar Winger"
phone_number <- get_phone_number(name)
cat(paste("Phone number for", name, ":", phone_number))

# Exrecise 16

data <- data.frame(
  First_name = c("Oscar", "Victor", "Cleas", "Filip", "Viktor"),
  Last_name = c("Winger", "Snow", "White", "Little", "Goodman"),
  Number = c("123-456-7890", "987-654-3210", "012-345-9876", "987-654-3210", "091-827-3645"),
  Email = c("oscar@gmail.com", "victor@gmail.com", "cleas@gmail.com", "filip@gmail.com", "viktor@gmail.com")
)

df <- as.data.frame(data)
df

# Exercise 17

modify_array <- function(arr) {
  for (i in seq_along(arr)) {
    arr[i] <- arr[i] + runif(1) 
  }
}

original_array <- c(1, 2, 3, 4, 5)
print("Original array:")
print(original_array)

modify_array(original_array)
print("Modified array:")
print(original_array)


# Exercise 18

setMethod("show", "Complex", function(object) {
  cat("Complex number: ", object@real, " + ", object@imaginary, "i\n")
})

Complex <- setClass(
  "Complex",
  representation(real = "numeric", imaginary = "numeric"),
  prototype(real = 0, imaginary = 0)
)

setMethod("show", "Complex", function(object) {
  cat("Complex number: ", object@real, " + ", object@imaginary, "i\n")
})

setMethod("+", signature("Complex", "Complex"), function(e1, e2) {
  real_sum <- e1@real + e2@real
  imaginary_sum <- e1@imaginary + e2@imaginary
  return(new("Complex", real = real_sum, imaginary = imaginary_sum))
})

setMethod("-", signature("Complex", "Complex"), function(e1, e2) {
  real_diff <- e1@real - e2@real
  imaginary_diff <- e1@imaginary - e2@imaginary
  return(new("Complex", real = real_diff, imaginary = imaginary_diff))
})

setMethod("*", signature("Complex", "Complex"), function(e1, e2) {
  real_product <- e1@real * e2@real - e1@imaginary * e2@imaginary
  imaginary_product <- e1@real * e2@imaginary + e1@imaginary * e2@real
  return(new("Complex", real = real_product, imaginary = imaginary_product))
})

setMethod("/", signature("Complex", "Complex"), function(e1, e2) {
  denominator <- e2@real^2 + e2@imaginary^2
  real_quotient <- (e1@real * e2@real + e1@imaginary * e2@imaginary) / denominator
  imaginary_quotient <- (e1@imaginary * e2@real - e1@real * e2@imaginary) / denominator
  return(new("Complex", real = real_quotient, imaginary = imaginary_quotient))
})

c1 <- new("Complex", real = 2, imaginary = 3)
c2 <- new("Complex", real = 1, imaginary = -2)

show(c1)
show(c2)

sum_result <- c1 + c2
show(sum_result)

diff_result <- c1 - c2
show(diff_result)

prod_result <- c1 * c2
show(prod_result)

quotient_result <- c1 / c2
show(quotient_result)


# Exercise 19

"Only in python"



