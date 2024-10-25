# Cofactor Expansion Research

This repository contains implementations of the **cofactor expansion algorithm** in **Standard Meta Language (SML)**, **python** and  **C**, aiming to explore the theoretical and practical time and space complexity of this algorithm. It is a series of experiments I undertook in response to a challenge from my professor in the course "21241 - Matrices and Linear Transformations."

## Table of Contents

- [Introduction](#introduction)
- [Algorithm Overview](#algorithm-overview)
- [Installation and Setup](#installation-and-setup)
- [Usage](#usage)
- [Matrix Test Cases](#matrix-test-cases)
- [Performance Logging](#performance-logging)
- [Notes](#notes)

## Introduction

The cofactor expansion algorithm is a recursive method for computing the determinant of a square matrix. Although efficient for small matrices, this method becomes computationally expensive as the matrix size increases due to its recursive nature.

In this experiment, I implemented the algorithm to work on matrices of varying sizes and log performance statistics as the determinant is calculated.

## Algorithm Overview

The determinant is calculated recursively via **cofactor expansion on the first row** of the matrix, reducing the matrix size at each step. The algorithm is implemented to handle square matrices stored in column-major order.

The key components of the algorithm include:

- Recursive cofactor expansion.
- Global counters for tracking the number of recursive calls on matrices of sizes 15x15, 14x14, down to 11x11.
- Functions for matrix manipulation (`rmCol`, `rmColRow`, `mkminors`, etc.).

## Installation and Setup

To run the experiment, you'll need:

- **SML/NJ** or another SML-compatible environment. You can install SML/NJ on Linux using:

```bash
sudo apt-get install smlnj

```

- Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/Mohamed-Waiel-Shikfa/Cofactor-Expansion-Experiment
cd Cofactor-Expansion-Experiment

```

## Usage

1. run the following in the shell of your choice:

```bash
time sml cofactor.sml

```

## Matrix Test Cases

The following matrices are provided in the code for testing:

- **A2**: 2x2 matrix
- **A3**: 3x3 matrix
- **A5**: 5x5 matrix
- **A10**: 10x10 matrix
- **A12, A12b**: 12x12 matrices (commented)
- **A15**: 15x15 matrix (commented)

You can uncomment the test cases in the code and add your own matrix definitions for further experimentation.

## Performance Logging

For matrices larger than 10x10, the algorithm logs the number of recursive calls made to calculate the determinant. The log includes counts for the following matrix sizes:

- **15x15**
- **14x14**
- **13x13**
- **12x12**
- **11x11**

This helps in understanding the recursive nature of the cofactor expansion algorithm and its performance degradation as matrix size increases.

## Notes

- **Efficiency**: The cofactor expansion algorithm has a time complexity of O(n!), making it impractical for large matrices.
- **Customization**: You can easily add more matrices or modify the existing test cases to explore different dimensions or matrix structures.

---

## License

This project is under the MIT license. Feel free to contribute or use it for your own experiments!