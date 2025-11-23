# ** `DEVELOPMENT-ENV.md`**

````markdown
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

````

---

# **2. `HOW-TO-ADD-A-NEW-CODE.md`**

```markdown
# Adding a New HPC Code

This guide explains how to add a **new HPC code** to the shared environment.

---

## Directory Structure

````

/opt/codes/codes/<code-name>/

````

Recommended contents:

- `README.md` — Overview and usage  
- `VERSION-<version>.md` — Version-specific build and deployment info  
- `modulefiles/` — Environment modules per version  
- `install-scripts/` — Optional automated build/deploy scripts  

---

## Build and Installation

1. Load the development environment:

```bash
module load development-env
````

2. Build the code according to its instructions.
3. Deploy binaries to:

```
/opt/codes/codes/<code-name>/<version>/bin
```

---

## Modulefile Creation

1. Place modulefile under:

```
/opt/codes/codes/<code-name>/modulefiles/<version>
```

2. Include:

* Dependency modules
* `PATH` to binaries
* Environment variables (e.g., `<CODE>_HOME`)

3. Create or update `latest` symlink to the newest version:

```
/opt/codes/codes/<code-name>/modulefiles/latest -> <version>
```

---

## Documentation

* Add `VERSION-<version>.md` documenting:

  * Build steps
  * Dependencies
  * Installation path
  * Validation tests

* Update the main `README.md` with a version table.

---

## Notes

* Follow the **HPC standard layout** (see `HPC-STANDARD-LAYOUT.md`)
* Document versions, dependencies, and modulefile paths clearly.

````

---

# **3. `MODULEFILE-GUIDE.md`**

```markdown
# HPC Modulefile Guide

This document explains how to **create and maintain modulefiles** for any scientific code.

---

## Purpose

Modulefiles allow users to:

- Set environment variables
- Prepend binaries to `PATH`
- Load dependency modules automatically
- Switch between versions easily

---

## Modulefile Location

````

/opt/codes/codes/<code-name>/modulefiles/<version>

```

Use a `latest` symlink to indicate the default version:

```

/opt/codes/codes/<code-name>/modulefiles/latest -> <version>

````

---

## Modulefile Template

```tcl
#%Module1.0
##
## <Code Name> <Version>
##

proc ModulesHelp { } {
    puts stderr "<Code Name> <Version>"
}

module-whatis "<Code Name> <Version>"

# Load dependencies
module load development-env

# Set paths
set root /opt/codes/codes/<code-name>/<version>
prepend-path PATH $root/bin
setenv <CODE>_HOME $root
````

---

## Best Practices

1. Always include dependency modules.
2. Export a root environment variable (e.g., `<CODE>_HOME`).
3. Use `prepend-path` for `PATH` and `LD_LIBRARY_PATH`.
4. Keep `latest` symlink updated.
5. Document modulefile changes in `README.md` or `VERSION-<version>.md`.

---

## Loading a Module

```bash
module use /opt/codes/codes/<code-name>/modulefiles
module load <code-name>/<version>
module load <code-name>/latest
```

````

---

# **4. `HPC-STANDARD-LAYOUT.md`**

```markdown
# HPC Standard Directory Layout

This document defines the **standard layout** for all HPC codes in `/opt/codes`.

---

## Base Directory

````

/opt/codes/

```

Contains:

- `modules/` — Environment modules (e.g., `development-env`)  
- `codes/` — Installed scientific codes  
- `install-scripts/` — Build/deploy scripts  
- `docs/` — Documentation

---

## Code Directory Structure

```

/opt/codes/codes/<code-name>/
├── README.md                  # Overview and usage
├── VERSION-<version>.md       # Version-specific documentation
├── modulefiles/               # Modules per version
│   ├── <version>              # Modulefile for that version
│   └── latest -> <version>    # Default version
└── install-scripts/           # Optional scripts for build/deploy

```

---

## Best Practices

1. Maintain one Markdown file per code version.  
2. Keep modulefiles versioned and updated.  
3. Use `latest` symlink for default version.  
4. Load `development-env` before building any code.  
5. Document all changes in version files and README.  
6. Follow consistent naming conventions.

---

## Notes

- This layout ensures reproducibility, maintainability, and consistency for all HPC software deployments.  
- All new codes should follow this structure for smooth integration.
```
