# Quantum ESPRESSO — HPC Installation

Quantum ESPRESSO (QE) is an integrated suite of open-source computer codes for electronic-structure calculations and materials modeling at the nanoscale, based on density functional theory (DFT), plane waves, and pseudopotentials.

This directory contains the installation, documentation, and modulefiles for QE in our HPC environment.

---

## Installed Version

| Version | Status    | Modulefile Path                | Notes                     |
|---------|-----------|--------------------------------|---------------------------|
| 7.5     | Installed | `quantum-espresso/7.5`             | Current stable version    |

> Each new QE version should have its own `VERSION-<version>.md` file and modulefile. Update this table when adding new versions.

---

## Directory Layout

```

..
qe
├── qe-7.5
│   └── bin                # Directory for storing quantum espresso executable files
└── qe_modulesfiles
    └── quantum-espresso
        ├── 7.5            # Stable version v7.5
        └── latest -> 7.5  # Symlink for latest version
````

---

## Usage Instructions

### Load Development Environment
```bash
module load development-env
````

### Load QE Module

```bash
module load quantum-espresso/7.5
# or
module load quantum-espresso   # uses 'latest' symlink
```

### Run QE Programs

```bash
# SCF calculation
pw.x < scf.in > scf.out

# Phonon calculation
ph.x < ph.in > ph.out

# Electron-phonon calculation
epw.x < epw.in > epw.out
```

---

## Dependencies

QE 7.5 depends on:

* MPI: `mpi/latest`
* Compiler: `compiler/latest`
* BLAS/LAPACK/MKL: `mkl/latest`
* TBB: `tbb/latest` (optional)
* Additional: `umf/latest`, `compiler-rt/latest`

All dependencies are loaded via the `development-env` module.

---

## Build / Installation Instructions

Example build commands:

```bash
module load development-env
cd /opt/codes/qe/qe-7.5/source

./configure CC=mpicc FC=mpif90 F77=mpif77 \
            --enable-parallel \
            --with-scalapack=yes \
            --prefix=/opt/codes/qe/qe-7.5

make all -j $(nproc)
make install
```

---

## Modulefile

* Path: `/opt/codes/qe/qe_modulesfiles/quantum-espresso/7.5`
* Sets environment variables:

  * `QE_HOME=/opt/codes/qe/qe-7.5`
  * `PATH=$QE_HOME/bin:$PATH`
  * `LD_LIBRARY_PATH` for dependencies
* The `latest` symlink points to the current stable version.

---

## Validation

* Run `pw.x` with test input files
* Verify MPI parallel jobs complete successfully
* Compare outputs with QE reference results

---

## Adding a New QE Version

1. Install QE under `/opt/codes/qe/qe-<version>/`
2. Create a **`VERSION-<version>.md`** documentation file
3. Add a modulefile in `qe_modulesfiles/quantum-espresso/<version>`
4. Update the **Installed Version** table in this README

---

## Automated Install Script

* `install-scripts/install-qe.sh` automates:

  * QE compilation and installation
  * Modulefile generation
  * Deployment to `/opt/codes/qe/qe-<version>/bin`
  * Updates `latest` symlink

---

## References

* [Quantum ESPRESSO Official Website](https://www.quantum-espresso.org/)
* [QE Documentation](https://www.quantum-espresso.org/Doc/)

```

---

This `README.md` is **ready-to-use**, fits your **current environment**, and is structured for **future QE versions**.  

If you want, I can **also draft the `VERSION-7.5.md`** next, with all **build details, dependencies, and validation steps**, fully environment-specific.  

Do you want me to do that?
```
