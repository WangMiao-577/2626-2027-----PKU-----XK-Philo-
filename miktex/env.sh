# Source this file to use the workspace-local MiKTeX.
#   source /home/simson/latex/miktex/env.sh
MIKTEX_ROOT="/home/simson/latex/miktex"
export PATH="/home/simson/bin:${MIKTEX_ROOT}/usr/bin${PATH:+:$PATH}"
export LD_LIBRARY_PATH="${MIKTEX_ROOT}/usr/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
