# Exercise 20 

# Setwd("location of the file")

source("print_triangle.R")
print_triangle(10)
print_triangle(15)


# Exercise 21 
# Setwd("location of the file")

source("find_pos.R")

v=c(1,2,5,10)
print(find_pos(v,-1))
print(find_pos(v,4))
print(find_pos(v,11))


# Exercise 22

source("find_pos_2.R")

result <- find_pos_2(v, 2)
cat("Index range:", result$index_range, "\n")
cat("Value range:", result$value_range, "\n")


# Exercise 23 

generate_integer_array <- function(size) {
  return(sample(0:999999, size, replace=TRUE))
}

generate_float_array <- function(size) {
  return(runif(size, min=0, max=1000000))
}

measure_time <- function(find_pos_func, array) {
  start_time <- Sys.time()
  for (x in array) {
    find_pos_func(array, x)
  }
  end_time <- Sys.time()
  return(as.numeric(difftime(end_time, start_time, units = "secs")))
}

integer_array <- generate_integer_array(10000000)
float_array <- generate_float_array(10000000)

time_integer_array <- measure_time(find_pos_2, integer_array)
cat("Time taken for integer array:", time_integer_array, "seconds\n") # 14.11 seconds

time_float_array <- measure_time(find_pos_2, float_array)
cat("Time taken for float array:", time_float_array, "seconds\n") # 14.17

# From the code above we can't say there is a significant difference



# Exercise 24 

binary_search <- function(v, x) {
  if (x < v[1]) {
    return(list(index_range = c('-Inf', 0), value_range = c(-Inf, v[1])))
  } else if (x >= tail(v, 1)) {
    return(list(index_range = c(length(v), 'Inf'), value_range = c(tail(v, 1), Inf)))
  } else {
    start <- 1
    end <- length(v)
    while (start <= end) {
      mid <- floor((start + end) / 2)
      if (v[mid] == x) {
        return(list(index_range = c(mid, mid + 1), value_range = c(v[mid], v[mid + 1])))
      } else if (v[mid] > x) {
        end <- mid - 1
      } else {
        start <- mid + 1
      }
    }
    return(list(index_range = c(end, start), value_range = c(v[end], v[start])))
  }
}

v_int <- 1:10000000
v_float <- as.numeric(1:10000000)

x_int <- sample(1:10000000, 1)
x_float <- runif(1, 1, 10000000)

start_time <- Sys.time()
binary_search(v_int, x_int)
end_time <- Sys.time()
cat("Time for integer array:", as.numeric(end_time - start_time), "seconds\n")

start_time <- Sys.time()
binary_search(v_float, x_float)
end_time <- Sys.time()
cat("Time for float array:", as.numeric(end_time - start_time), "seconds\n")

# Binary search is significant faster 


# Exercise 25

# No there is no significant diffrence with biniary search, however for exercise 23 pyhton works much faster 


# Exercise 26 

library(parallel)
detectCores()
# 8 Cores


# Exercise 29

f <- function(x) {
  return(exp(x) + log(x))
}

a <- 1
b <- 2
n <- 100

delta_x <- (b - a) / n

riemann_sum <- 0
monte_carlo_sum <- 0
midpoint_sum <- 0

set.seed(123)  y
for (i in 1:n) {
  random_x <- runif(1, a, b)  
  monte_carlo_sum <- monte_carlo_sum + f(random_x)
}

for (i in 0:(n - 1)) {
  left_endpoint <- a + i * delta_x
  right_endpoint <- a + (i + 1) * delta_x
  mid_point <- (left_endpoint + right_endpoint) / 2
  riemann_sum <- riemann_sum + f(mid_point) * delta_x
  midpoint_sum <- midpoint_sum + f(mid_point) * delta_x
}

count_inside_point <- function(n) {
  m <- 0
  for (i in 1:n) {
    p_x <- runif(1, -1, 1)
    p_y <- runif(1, -1, 1)
    if (p_x^2 + p_y^2 <= 1) {
      m <- m + 1
    }
  }
  m
}

generate_points_parallel <- function(n) {
  unlist(mclapply(X = rep(n %/% detectCores(), detectCores()), FUN = count_inside_point))
}

generate_points_vectorized <- function(n) {
  p <- array(runif(n * 2, -1, 1), c(n, 2))
  sum((p[, 1]^2 + p[, 2]^2) <= 1)
}

cat("Riemann Sum: ", riemann_sum, "\n")
cat("Monte Carlo Sum: ", monte_carlo_sum / n * (b - a), "\n")



# Exercise 31
# install.packages("microbenchmark")
library(microbenchmark)
library(Rcpp)

Fibonacci_native <- function(n) {
  if (n == 1 || n == 2) {
    return(1)
  } else {
    return(Fibonacci_native(n - 1) + Fibonacci_native(n - 2))
  }
}

sourceCpp('Fibonacci.cpp')

compare_fibonacci_speed <- function(n_values) {
  timings <- data.frame(N = numeric(0), R_native = numeric(0), R_cpp = numeric(0))
  
  for (n in n_values) {
    # Generate Fibonacci using native R implementation
    time_native <- microbenchmark(Fibonacci_native(n), times = 100)$time[1]
    
    # Generate Fibonacci using C++ implementation
    time_cpp <- microbenchmark(Fibonacci(n), times = 100)$time[1]
    
    timings <- rbind(timings, data.frame(N = n, R_native = time_native, R_cpp = time_cpp))
  }
  
  return(timings)
}

n_values <- c(10, 20, 30)

timings <- compare_fibonacci_speed(n_values)

print(timings)

# The R_cpp runs significantly faster den R



























