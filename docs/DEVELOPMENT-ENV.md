# Development Environment — HPC Stack

This document describes the **shared development environment** used to build and deploy HPC scientific codes.

---

## Purpose

The development environment ensures:

- Reproducible builds
- Consistent compiler and library versions across codes
- Simplified module management

---

## Key Components

| Component         | Module / Version      | Purpose                                         |
|------------------|---------------------|------------------------------------------------|
| Compiler          | `compiler/latest`    | C/C++/Fortran compiler                          |
| MPI               | `mpi/latest`         | Parallel execution support                      |
| Math Libraries    | `mkl/latest`         | Optimized linear algebra                        |
| Threading Library | `tbb/latest`         | Parallel threading support                      |
| Sparse Solver     | `umf/latest`         | Sparse matrix support                            |
| Compiler Runtime  | `compiler-rt/latest` | Runtime libraries for modern compilers         |

---

## Usage

Load the development environment before building any code:

```bash
module load development-env
````

---

## Best Practices

1. Always load `development-env` before building any HPC code.
2. Avoid mixing system compilers with development environment modules.
3. Use environment variables provided by the module for paths and library linking.
4. Keep the module updated and document changes for reproducibility.
