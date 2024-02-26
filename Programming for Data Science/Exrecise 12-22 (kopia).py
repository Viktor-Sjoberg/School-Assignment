# Exrecise 12

def SieveOfEratosthenes(num):
    prime = [True for i in range(num+1)]
# boolean array
    p = 2
    while (p * p <= num):
 
        # If prime[p] is not
        # changed, then it is a prime
        if (prime[p] == True):
 
            # Updating all multiples of p
            for i in range(p * p, num+1, p):
                prime[i] = False
        p += 1
 
    # Print all prime numbers
    for p in range(2, num+1):
        if prime[p]:
            print(p)
 
SieveOfEratosthenes(30)
prime_1 = (SieveOfEratosthenes(1000000))


# Exrecise 13 

import numpy as np


entries = list(range(1, 101))

matrix = np.diag(entries)

inverse_matrix = np.linalg.inv(matrix)

identity_matrix = np.dot(matrix, inverse_matrix)

matrix
inverse_matrix
identity_matrix



# Exrecise 14 

x = np.array([[1, 2], [3, 4], [5, 6]])
y = np.array([1, 2, 3])
z = np.array([1, 2])


np.dot(x.T*y,x*z)
np.dot(x*z,x.T*y)
np.dot(y,y.T)
np.dot(y.T,y)
Y=np.reshape(y,(1,3))
np.dot(Y,Y.T)
np.dot(Y.T,Y)

# Of course the order matter 
# 


# Exrecise 15

telephone_book = {
    "Oscar Winger": "123-456-7890",
    "Victor Snow": "987-654-3210",
    "Cleas White": "012-345-9876",
    "Filip Little": "987-654-3210",
    "Viktor Goodman": "091-827-3645"
    }

def get_phone_number(name):
    return telephone_book.get(name, "Name not found in the telephone book.")

name = "Oscar Winger"
phone_number = get_phone_number(name)
print(f"Phone number for {name}: {phone_number}")

# Exrecise 16

import pandas as pd

data ={ 
       "First_name": ["Oscar", "Victor", "Cleas", "Filip", "Viktor"],
       "Last_name": ["Winger", "Snow", "White", "Little", "Goodman"],
       "Number": ["123-456-7890", "987-654-3210", "012-345-9876", "987-654-3210", "091-827-3645"],
       "Email": ["oscar@gmail.com", "victor@gmail.com", "cleas@gmail.com", "filip@gmail.com", "viktor@gmail.com"]
}


df = pd.DataFrame(data)
df


# Exrecise 17

import numpy as np

def add_random_numbers(arr):
    for i in range(len(arr)):
        for j in range(len(arr[i])):
            arr[i][j] += np.random.random()  

arr = np.array([[1, 2], [3, 4], [5, 6]])
add_random_numbers(arr)
print(arr)

# Exrecise 18  

class ComplexNumber:
    def __init__(self, real, imag):
        self.real = real
        self.imag = imag

    def __add__(self, other):
        return ComplexNumber(self.real + other.real, self.imag + other.imag)

    def __sub__(self, other):
        return ComplexNumber(self.real - other.real, self.imag - other.imag)

    def __mul__(self, other):
        real_part = self.real * other.real - self.imag * other.imag
        imag_part = self.real * other.imag + self.imag * other.real
        return ComplexNumber(real_part, imag_part)

    def __truediv__(self, other):
        denom = other.real**2 + other.imag**2
        real_part = (self.real * other.real + self.imag * other.imag) / denom
        imag_part = (self.imag * other.real - self.real * other.imag) / denom
        return ComplexNumber(real_part, imag_part)

    def __str__(self):
        return f"{self.real} + {self.imag}i"


c1 = ComplexNumber(2, 3)
c2 = ComplexNumber(1, 1)

print("Sum:", c1 + c2)
print("Difference:", c1 - c2)
print("Product:", c1 * c2)
print("Quotient:", c1 / c2)



# Exrecise 19 

"Part 1: Public Access"
"In this part, the Employee class defines attributes name and sal as public, meaning they can be accessed directly" 
"from outside the class using dot notation (JS.name and JS.sal). The programmer may choose this level of" 
"accessibility when they want the attributes to be easily accessible and modified from outside the class without" 
"any restrictions."

"Part 2: Protected Access"
"In this part, the Employee class defines attributes _name and _sal as protected (indicated by a single underscore)." 
"Protected attributes can be accessed from outside the class, but conventionally, it's suggested not to access them" 
"directly. The programmer may choose this level of accessibility when they want to indicate that these attributes" 
"should be treated as internal to the class or for use by subclasses (like HR in this example)."

"Part 3: Private Access"
"In this part, the Employee class defines attributes __name and __sal as private (indicated by double underscores)." 
"Private attributes cannot be accessed directly from outside the class. However, Python performs name mangling, which" 
"means the names of these attributes are modified to _object._class__variable, making it possible to access them, but "
"this practice should be avoided. The programmer may choose this level of accessibility when they want to ensure that "
"the attributes are not accessed or modified from outside the class."


"Control and Consistency:" 
"By controlling access to attributes, the programmer can ensure that they are accessed and modified in a controlled and" 
"consistent manner, helping to maintain the integrity and validity of the data."




















