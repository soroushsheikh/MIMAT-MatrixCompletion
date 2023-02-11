# MIMAT-MatrixCompletion

The code provided is an implementation of the MIMAT algorithm for matrix completion inspired by IMAT algorithm (Marvasti et al.). MIMAT works based on adaptive singular value thresholding.

## Inputs to the Algorithm
- `num_rows`: the number of rows in the matrix
- `num_columns`: the number of columns in the matrix
- `observation_mask`: a binary matrix indicating the observed elements in the matrix
- `observed_matrix`: the matrix with observed values
- `tolerance1`: a tolerance value for the stopping criterion for outer loop of the algorithm
- `tolerance2`: a tolerance value for the stopping criterion for inner loop of the algorithm


## Outputs
The code returns the completed matrix by combining the observed matrix with the approximated matrix using the missing_mask and observation_mask. 

## Algorithm Steps
1. The missing_mask is calculated as the complement of the observation_mask.
2. The initial approximation of the matrix is calculated using singular value decomposition (SVD) and the rank of the approximation is set to 1.
3. The outer loop of the algorithm runs until the Frobenius norm of the error between the observed matrix and the approximated matrix is greater than or equal to `tolerance1`.
4. Within the outer loop, the inner loop runs until the relative error between two consecutive approximations of the matrix is greater than or equal to `tolerance2`.
5. The inner loop updates the approximation of the matrix by performing SVD and keeping only the singular values

Here is the full pseudocode:
![pseudocode](https://github.com/soroushsheikh/MIMAT-MatrixCompletion/blob/main/material/pseudocode.png)

## Evaluation and Comparison with Other Algorithms

In this project, the performance of the proposed MIMAT algorithm is evaluated and compared with the well-known FPC and SVT algorithms. The comparison is done in terms of accuracy. The results show that the MIMAT algorithm outperforms the other algorithms in terms of accuracy and robustness while maintaining a reasonable computation time.
