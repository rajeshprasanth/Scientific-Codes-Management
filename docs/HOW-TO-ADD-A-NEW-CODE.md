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
