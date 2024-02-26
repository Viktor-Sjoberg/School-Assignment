# Exercise 1
circumference <- function(radius = 1) {
  return(2 * pi * radius)
}

# Exercise 2
area <- function(radius) {
  return(pi * radius^2)
}

# Exercise 3
circle_properties <- function(radius, properties="area"){
    1*(properties=="area")*area(radius) +
    1*(properties!="area")*circumference(radius)
}

# Exercise 4
sphere_properties <- function(radius, properties = "volume", properties_2 = "area") {
    1*(properties=="volume")*(4/3*pi*radius^3) +
    1*(properties!="volume")*(properties_2=="area")*area(radius) +
    1*(properties!="volume")*(properties_2!="area")*circumference(radius)
}

# Exercise 5 (with if/else)
circle_properties_if_else <- function(radius, circumference = FALSE) {
  if (circumference) {
    return(2 * pi * radius)
  } 
  else {
    return(pi * radius^2)
  }
}

sphere_properties_if_else <- function(radius, volume = TRUE) {
  if (volume) {
    return((4/3) * pi * radius^3)
  } else {
    return(circle_properties_if_else(radius, circumference = TRUE))
  }
}

# Exercise 6
n <- 100
z <- 1
y <- 2
interval <- y - z
delta_x <- interval / n

lower_bound <- 0
for (i in 1:n) {
  xi <- z + i * delta_x
  lower_bound <- lower_bound + (exp(xi) + log(xi)) * delta_x
}
lower_bound

upper_bound <- 0
for (i in 1:n) {
  xi <- z + i * delta_x
  xi_1 <- xi + delta_x
  upper_bound <- upper_bound + (exp(xi_1) + log(xi_1)) * delta_x
}
upper_bound

error <- upper_bound - lower_bound
error
# Exercise 7
error_threshold <- 0.0001

while (error > error_threshold) {
  error <- 1/n * abs((log(z) + exp(z)) - (log(y) + exp(y)))
  n <- n + 100
  print(error)
}

# Exercise 8
delta_x_2 <- (1 - 0) / n
for (i in 1:n) {
  x_i <- 0 + (i - 1) * delta_x_2
  f_x_i <- exp(x_i) + log(x_i)
  if (log(x_i) < -1) {
    break
  }
}
delta_x_2

# Exercise 9
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
start_date <- as.Date("2023-01-01")  # Start date
end_date <- as.Date("2023-12-31")    # End date
date_list <- vector("character", length = as.numeric(difftime(end_date, start_date, units = "days")) )

for (i in 0:(length(date_list))) {
  current_date <- start_date + i
  day_of_week <- format(current_date, format="%A")
  date_list[i + 1] <- day_of_week
}
date_list



# Exercise 10
num_weeks <- length(date_list) %/% 7  # Calculate the number of weeks
date_matrix <- matrix(date_list[1:(num_weeks*7)], nrow = num_weeks, byrow = TRUE)
extra_week <- rep("", 7)  
extra_week <- c("Sunday", rep("", 6))  # Create a row with "Sunday" as the first value and the rest empty
date_matrix <- rbind(date_matrix, extra_week)  # Add the extra row

print(date_matrix)

# Exercise 11
"If the list of weeks is created by replication of values, changing one week 
would affect all weeks since they share the same underlying object. This can be 
problematic if you want different weeks to have different names. Changing by 
address or using a separate list for each week would be a better approach. 
However, the benefit of replication is that it consumes less memory since it 
doesn't create separate objects for each week."
