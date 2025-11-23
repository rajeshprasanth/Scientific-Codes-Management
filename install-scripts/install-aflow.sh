#!/usr/bin/env bash

set -euo pipefail

# ============================================================
#  AFLOW Deployment Script (Interactive)
#  Root Required • Modulefile Generator • Default Paths
# ============================================================

DEFAULT_BASE="/opt/codes/aflow"
DEFAULT_MODROOT="/opt/codes/modules/aflow"

# ---------------------- HELP MESSAGE ------------------------
show_help() {
    cat <<EOF
AFLOW Deployment Script
----------------------------------

Usage:
  sudo ./install-aflow.sh

This script will ask for:
  - Build Version
  - Build directory (must contain bin/)
  - Deploy target directory (default: ${DEFAULT_BASE}/aflow-<VERSION>)
  - Modulefile path        (default: ${DEFAULT_MODROOT}/<VERSION>)

It will:
  - Copy AFLOW binaries to the target directory
  - Create a modulefile
  - Update 'latest' symlink

Options:
  -h, --help     Show this help message

EOF
}

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && { show_help; exit 0; }

# ---------------------- ROOT CHECK --------------------------
if [[ "$EUID" -ne 0 ]]; then
    echo "[ERROR] This script must be run as root."
    echo "Run: sudo $0"
    exit 1
fi

echo "[OK] Running with root privileges."
echo "============================================================"
echo " AFLOW Deployment (Interactive)"
echo "============================================================"

# ---------------------- GET VERSION -------------------------
read -rp "Enter AFLOW version (example: 7.5): " VERSION
[[ -z "$VERSION" ]] && { echo "[ERROR] Version cannot be empty"; exit 1; }

# ---------------------- GET BUILD DIRECTORY -----------------
read -rp "Enter full path to AFLOW build directory: " BUILD_DIR
[[ ! -d "$BUILD_DIR" ]] && {
    echo "[ERROR] ${BUILD_DIR} does not exist. AFLOW build seems incomplete."
    exit 1
}

# ---------------------- TARGET DIRECTORY (DEFAULT) ----------
DEFAULT_TARGET="${DEFAULT_BASE}/aflow-${VERSION}"
read -rp "Enter deploy target directory [${DEFAULT_TARGET}]: " TARGET_DIR
TARGET_DIR="${TARGET_DIR:-$DEFAULT_TARGET}"
TARGET_BIN="${TARGET_DIR}/bin"

# ---------------------- MODULEFILE PATH (DEFAULT) -----------
DEFAULT_MODULEFILE="${DEFAULT_MODROOT}/${VERSION}"
read -rp "Enter modulefile path [${DEFAULT_MODULEFILE}]: " MODULEFILE
MODULEFILE="${MODULEFILE:-$DEFAULT_MODULEFILE}"

MODULE_DIR="$(dirname "$MODULEFILE")"
LATEST_LINK="${MODULE_DIR}/latest"

# ---------------------- CONFIRM -----------------------------
echo
echo "Deployment Summary:"
echo "------------------------------------------------------------"
echo "  AFLOW Version            : ${VERSION}"
echo "  Build directory       : ${BUILD_DIR}"
echo "  Deploy target         : ${TARGET_DIR}"
echo "  Modulefile            : ${MODULEFILE}"
echo "  Latest symlink        : ${LATEST_LINK} -> ${VERSION}"
echo "------------------------------------------------------------"
read -rp "Proceed? (y/n): " CONFIRM
[[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]] && { echo "[INFO] Deployment aborted."; exit 0; }

# ---------------------- DEPLOY ------------------------------
echo "[INFO] Creating target directory: ${TARGET_BIN}"
mkdir -p "${TARGET_BIN}"
mkdir -p "${MODULE_DIR}"

echo "[INFO] Copying AFLOW binaries to ${TARGET_BIN}"
find ${BUILD_DIR} -name aflow -exec cp {} ${TARGET_BIN} \;

# ---------------------- MODULEFILE --------------------------
echo "[INFO] Writing modulefile: ${MODULEFILE}"

cat > "${MODULEFILE}" <<EOF
#%Module1.0
##
## AFLOW ${VERSION}
##

proc ModulesHelp { } {
    puts stderr "AFLOW ${VERSION}"
}

module-whatis "AFLOW ${VERSION}"

# Export paths
set root ${TARGET_DIR}
prepend-path PATH            \$root/bin
setenv AFLOW_ROOT               \$root
EOF

# ---------------------- LATEST SYMLINK ----------------------
echo "[INFO] Updating latest -> ${VERSION}"
rm -f "${LATEST_LINK}"
ln -s "${VERSION}" "${LATEST_LINK}"

# ---------------------- DONE -------------------------------
echo "============================================================"
echo "[SUCCESS] AFLOW ${VERSION} deployed successfully!"
echo
echo "To use it:"
echo "  module use ${DEFAULT_MODROOT}"
echo "  module load aflow/${VERSION}"
echo "  module load aflow/latest"
echo "============================================================"
