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
