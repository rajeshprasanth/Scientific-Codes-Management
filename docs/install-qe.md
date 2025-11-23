# Quantum ESPRESSO Deployment Script — `install-qe.sh`

This script automates the deployment of **Quantum ESPRESSO (QE)** binaries and modulefiles on your HPC environment. It is **interactive**, asks for required paths, and generates a proper environment module for easy usage.

---

## **Purpose**

- Deploy compiled QE binaries to the target installation directory (default: `/opt/codes/qe/qe-<VERSION>`)  
- Automatically generate a **modulefile** in the proper modules directory (default: `/opt/codes/qe/qe_modulesfiles/quantum-espresso/<VERSION>`)  
- Update the **`latest` symlink** to point to the newly deployed version  
- Ensure environment variables and dependencies are set correctly  

> **Note:** The script must be run with **root privileges** to write to `/opt/codes`.

---

## **Location**

```

install-scripts/install-qe.sh

````

---

## **Prerequisites**

- QE must be already compiled; build directory should contain `bin/` with `.x` executables  
- HPC environment modules installed:
  - `tbb/latest`  
  - `compiler-rt/latest`  
  - `umf/latest`  
  - `compiler/latest`  
  - `mkl/latest`  
  - `mpi/latest`  
- Run script as root:
```bash
sudo ./install-qe.sh
````

---

## **Usage**

```bash
sudo ./install-qe.sh
```

The script will interactively ask for:

1. **QE Version** (example: `7.5`)
2. **QE Build Directory** (must contain `bin/`)
3. **Deploy Target Directory** (default: `/opt/codes/qe/qe-<VERSION>`)
4. **Modulefile Path** (default: `/opt/codes/qe/qe_modulesfiles/quantum-espresso/<VERSION>`)

It will then:

* Copy binaries to the deploy target
* Create the modulefile
* Update the `latest` symlink to the new version

---

## **Interactive Deployment Steps**

1. Run the script with `sudo`
2. Confirm the deployment summary
3. Script will copy binaries and generate modulefile
4. Script outputs instructions to load the module:

```bash
module use /opt/codes/qe/qe_modulesfiles/quantum-espresso
module load quantum-espresso/<VERSION>
module load quantum-espresso/latest
```

---

## **Modulefile Details**

The modulefile generated will:

* Set `QE_ROOT` to the deployed QE path
* Prepend `$QE_ROOT/bin` to `PATH`
* Load dependency modules automatically:

```
tbb/latest
compiler-rt/latest
umf/latest
compiler/latest
mkl/latest
mpi/latest
```

* Modulefile location: `/opt/codes/qe/qe_modulesfiles/quantum-espresso/<VERSION>`
* `latest` symlink updated to point to this version

---

## **Help / Options**

```bash
sudo ./install-qe.sh -h
sudo ./install-qe.sh --help
```

Displays a usage summary and instructions.

---

## **Post-Deployment**

After deployment, users can load the QE environment with:

```bash
module use /opt/codes/qe/qe_modulesfiles/quantum-espresso
module load quantum-espresso/7.5
# or
module load quantum-espresso/latest
```
