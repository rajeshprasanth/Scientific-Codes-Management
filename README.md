# Scientific-Codes-Management
Collection of HPC scientific applications (Quantum ESPRESSO, VASP, LAMMPS, etc.) with their build configurations, versioned documentation, modulefiles, and environment setups for cluster deployment.

## **Table of Contents**

1. [Overview](#overview)
2. [Repository Structure](#repository-structure)
3. [Usage](#usage)
4. [Adding a New Code](#adding-a-new-code)
5. [Modulefiles](#modulefiles)
6. [Maintaining Version Documentation](#maintaining-version-documentation)
7. [Contributing](#contributing)
8. [License](#license)

---

## **Overview**

This repository organizes multiple **scientific and HPC applications** in a standardized, maintainable format.

Each package (e.g., Quantum ESPRESSO, VASP, LAMMPS) has its own directory containing:

* **Version-specific documentation** (`VERSION-x.y.md`)
* **Modulefiles** for environment management (Lmod / module load)
* **Installation notes**
* **Scripts for reproducible builds**

This structure allows for:

* Clean separation of codes
* Easy version tracking
* Reproducible HPC workflows
* Centralized environment module management

---

## **Repository Structure**

```
Scientific-Codes-Management/
├── aflow
│   ├── aflow-3.2.13
│   │   └── bin
│   └── aflow-4.0.5
│       └── bin
├── gulp
│   └── gulp-6.3.4
│       └── bin
├── matlab-runtime
│   └── v91
│       ├── appdata
│       ├── bin
│       ├── cefclient
│       ├── etc
│       ├── extern
│       ├── help
│       ├── java
│       ├── license_agreement.txt
│       ├── mcr
│       ├── MCR_license.txt
│       ├── patents.txt
│       ├── polyspace
│       ├── remote
│       ├── resources
│       ├── rtw
│       ├── runtime
│       ├── settings
│       ├── sys
│       ├── toolbox
│       ├── trademarks.txt
│       └── ui
├── modules
│   ├── aflow
│   │   ├── 3.2.13
│   │   ├── 4.0.5
│   │   └── latest -> 4.0.5
│   ├── gulp
│   │   ├── 6.3.4
│   │   └── latest -> 6.3.4
│   ├── intel-devel
│   │   └── intel-devel
│   ├── nwchem
│   │   ├── nwchem_mpich
│   │   └── nwchem_openmpi
│   ├── quantum-espresso
│   │   ├── 7.5
│   │   └── latest -> 7.5
│   └── uspex
│       ├── 10.5
│       └── 25
├── nwchem
├── quantum-espresso
│   └── qe-7.5
│       └── bin
├── siesta
├── spglib
├── USPEX
|   ├── USPEX-10.5
│   ├── appdata
│   ├── application
│   ├── uninstall
|   └── USPEX-25
|       └── bin
├── install-scripts/
│   ├── install-qe.sh
│   ├── install-vasp.sh
│   └── install-lammps.sh
└── docs/
    ├── DEVELOPMENT-ENV.md
    ├── HOW-TO-ADD-A-NEW-CODE.md
    ├── MODULEFILE-GUIDE.md
    └── HPC-STANDARD-LAYOUT.md
```

---

## **Usage**

### **Load the Development Environment**

```bash
module load development-env
```

### **Load a Specific Code**

```bash
module load quantum-espresso/7.5
```

or

```bash
module load vasp/6.3
```

### **Run the Code**

```bash
# Example: QE SCF run
pw.x < scf.in > scf.out

# Example: Phonon calculation
ph.x < ph.in > ph.out
```

---

## **Adding a New Code**

1. Create a directory under `codes/` for the new software.
   Example: `codes/my-new-code/`

2. Add a `README.md` with:

   * Code description
   * Dependencies
   * Usage notes

3. Add **version-specific Markdown files** for each installed version:

   ```
   VERSION-x.y.md
   ```

   Include:

   * Build instructions
   * Compilers used
   * Installation paths
   * Validation notes

4. Create **modulefiles** for each version inside:

   ```
   codes/my-new-code/modulefiles/
   ```

5. Update `docs/HOW-TO-ADD-A-NEW-CODE.md` with relevant steps.

---

## **Modulefiles**

* Located in `modules/` and in each code’s `modulefiles/` directory.
* Ensure each modulefile sets:

  * `PATH` to binaries
  * `LD_LIBRARY_PATH` for dependencies
  * Environment variables like `CODE_HOME`

Example:

```
module load quantum-espresso/7.5
echo $QE_HOME  # /opt/codes/qe/qe-7.5
```

---

## **Maintaining Version Documentation**

* **One Markdown file per version**
  Example:

  ```
  codes/quantum-espresso/VERSION-7.5.md
  ```
* Include:

  * Build options & flags
  * Compiler version
  * Dependencies
  * Installation path
  * Validation steps
* Keep version files updated when upgrading.

---

## **Contributing**

* Fork the repository
* Add or update package directories, modulefiles, or docs
* Submit a pull request with a clear description of changes

---

## License

This repository is licensed under the **GNU General Public License v3.0 (GPLv3)**.  
You are free to use, modify, and redistribute this repository under the terms of GPLv3.

See [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.en.html) for full details.

---
