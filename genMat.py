import random
import numpy as np

# Function to generate a 10x10 matrix with random integers between 1 and 10
def generate_matrix():
    return [[random.randint(1, 8) for _ in range(17)] for _ in range(17)]

# Generate a non-singular matrix (determinant != 0)
def generate_non_singular_matrix():
    while True:
        matrix = generate_matrix()
        if abs(np.linalg.det(np.array(matrix))) < 1000000000:  # Check determinant
            print("Matrix determinant: ", np.linalg.det(np.array(matrix)))
            return matrix

# Generate and print the matrix
matrix = generate_non_singular_matrix()
for row in matrix:
    print(row)
