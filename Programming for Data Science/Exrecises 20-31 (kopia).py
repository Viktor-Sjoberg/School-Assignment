# Exrecise 20

import os
os.chdir("location of the file")

runfile("print_triangle.py")

print_triangle(10)
print_triangle(15)



# Exreise 21

runfile("find_pos.py")

v = [1, 2, 5, 10]
find_pos(v, 1)
find_pos(v, 2)

# Exreise 22


runfile("find_pos_2.py")



# Exrecise 23 

import numpy as np

def generate_integer_array(size):
    return np.random.randint(0, 1000000, size=size)

def generate_float_array(size):
    return np.random.rand(size) * 1000000

import time

# Function to measure the time taken to run find_pos
def measure_time(find_pos_func, array):
    start_time = time.time()
    for x in array:
        find_pos_func(array, x)
    end_time = time.time()
    return end_time - start_time

# Generate the arrays
integer_array = generate_integer_array(10000000)
float_array = generate_float_array(10000000)

# Measure the time for integer array
time_integer_array = measure_time(find_pos_2, integer_array)
print("Time taken for integer array:", time_integer_array, "seconds") # 3.9 sec

# Measure the time for float array
time_float_array = measure_time(find_pos_2, float_array)
print("Time taken for float array:", time_float_array, "seconds") # 4.5 sec 

# From the code above we cant say there is a significant difference 

#Exercise 24

def binary_search(v, x): 
    if x < v[0]:
        return ('-Inf', 0), (float('-inf'), v[0])
    elif x >= v[-1]:
        return (len(v), 'Inf'), (v[-1], float('inf'))
    else:
        start, end = 0, len(v)-1 
        while start <= end: 
            mid = (start+end)//2 
            if v[mid] == x:
                return (mid, mid+1), (v[mid], v[mid+1])
            elif v[mid] > x:
                end = mid - 1
            else: 
                start = mid + 1
        return (end, start), (v[end], v[start])


import random

v_int = [i for i in range(1, 10000001)]  
v_float = [float(i) for i in range(1, 10000001)]  

x_int = random.randint(1, 10000000)
x_float = random.uniform(1, 10000000)

start_time = time.time()
binary_search(v_int, x_int)
end_time = time.time()
print(f"Time for integer array: {end_time - start_time} seconds")

start_time = time.time()
binary_search(v_float, x_float)
end_time = time.time()
print(f"Time for float array: {end_time - start_time} seconds")

# Binary search is significant faster 


# Axrecise 25

# No there is no significant diffrence with biniary search, however for exercise 23 pyhton works much faster 

# Exrecise 26

class BML:
    def __init__(self, alpha, m, n):
        self.alpha = alpha
        self.shape = (m, n)
        self.initialize_lattice()

    def initialize_lattice(self):
        u = np.random.uniform(0.0, 1.0, self.shape)
        # instead of using default list, we use np.array to create the lattice
        self.lattice = np.zeros_like(u, dtype=int)
        # the parentheses below can’t be ignored
        self.lattice[(u > self.alpha) & (u <= (1.0 + self.alpha) / 2.0)] = 1
        self.lattice[u > (self.alpha + 1.0) / 2.0] = 2

    def odd_step(self):
        # please note that np.where returns a tuple which is immutable
        blue_index = np.where(self.lattice == 1)
        blue_index_i = blue_index[0] - 1
        blue_index_i[blue_index_i < 0] = self.shape[0] - 1
        blue_movable = self.lattice[(blue_index_i, blue_index[1])] == 0
        self.lattice[(blue_index_i[blue_movable],
                      blue_index[1][blue_movable])] = 1
        self.lattice[(blue_index[0][blue_movable],
                      blue_index[1][blue_movable])] = 0

    def even_step(self):
        red_index = np.where(self.lattice == 2)
        red_index_j = red_index[1] + 1
        red_index_j[red_index_j == self.shape[1]] = 0
        red_movable = self.lattice[(red_index[0], red_index_j)] == 0
        self.lattice[(red_index[0][red_movable],
                      red_index_j[red_movable])] = 2
        self.lattice[(red_index[0][red_movable],
                      red_index[1][red_movable])] = 0

#run the previous code in the console, and create a Class 'BML'

bml = BML(0.4, 5, 5)
bml.lattice
#Execute the above commands two times and check whether the returned arrays differ.
# Answer: Yes it differs since its randomized every time its runed


np.random.seed(2022)
bml = BML(0.4, 5, 5)
bml.lattice
#Execute the above commands two times and check whether the returned arrays differ.
#You should get the same matrix. Explain the impact of the "np.random.seed(2022)".
# Answer:  By using np.random.seed(2022), the random numbers generated for lattice initialization will be the same every time the script is run with the same parameters. 


# Exrecise 27

np.random.seed(2022)
bml = BML(0.4, 5, 5)
bml.lattice
bml.odd_step()
bml.lattice
bml.even_step()
bml.lattice
#Explain the impact of the bml.odd_step() and bml.even_step()

# Answeer: By alternating between the odd and even steps, the BML model simulates 
# traffic flow, with blue particles moving vertically and red particles moving horizontally. This mimics the flow of vehicles in a traffic system. 


# Exrecise 28

import matplotlib.pyplot as plt

# Function to experiment with different alpha values
def experiment_with_alpha(alpha_values):
    lattice_sizes = [10, 20, 30]  # Different lattice sizes for experimentation
    num_iterations = 100  # Number of iterations for each alpha value

    for lattice_size in lattice_sizes:
        average_blue_density = []
        for alpha in alpha_values:
            blue_densities = []
            for _ in range(num_iterations):
                np.random.seed(2022)
                bml = BML(alpha, lattice_size, lattice_size)
                for i in range(10):  # Run for a certain number of iterations
                    if i % 2 == 0:
                        bml.odd_step()
                    else:
                        bml.even_step()
                blue_density = np.mean(bml.lattice == 1)
                blue_densities.append(blue_density)
            average_blue_density.append(np.mean(blue_densities))

        plt.plot(alpha_values, average_blue_density, label=f"Lattice Size: {lattice_size}")

    plt.xlabel('Alpha')
    plt.ylabel('Average Blue Particle Density')
    plt.title('Effect of Alpha on Traffic Model')
    plt.legend()
    plt.show()

# Experiment with alpha values from 0.1 to 0.9 in steps of 0.2
alpha_values = np.arange(0.1, 1.0, 0.2)
experiment_with_alpha(alpha_values)


# Exrecise 29


# Exrecise 30 

# 'Laziness' (Lazy Evaluation) delays expression evaluation until their values are necessary, aiding efficiency by avoiding unnecessary computations.
# 'Eagerness' (Eager Evaluation) immediately evaluates expressions when encountered, simplifying program behavior but potentially leading to inefficiencies from unnecessary computations.
# The choice between laziness and eagerness depends on the specific task's needs, favoring laziness for efficient resource utilization with potentially large or infinite data, and eagerness for immediate computation or with small, manageable data.

# exercise 31



