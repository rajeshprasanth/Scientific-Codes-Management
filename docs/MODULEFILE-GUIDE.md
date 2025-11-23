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
