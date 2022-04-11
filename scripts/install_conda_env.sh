#!/bin/bash
set -e  # Stop on error

SH_SCRIPT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

echo "$(date): Installing pipeline's Conda environments..."

conda create -n encode-chip-seq-pipeline --file ${SH_SCRIPT_DIR}/requirements.txt \
  --override-channels -c bioconda -c defaults -y

conda create -n encode-chip-seq-pipeline-macs2 --file ${SH_SCRIPT_DIR}/requirements.macs2.txt \
  --override-channels -c bioconda -c defaults -y

conda create -n encode-chip-seq-pipeline-spp --file ${SH_SCRIPT_DIR}/requirements.spp.txt \
  --override-channels -c r -c bioconda -c defaults -y

# adhoc fix for the following issues:
# - https://github.com/ENCODE-DCC/chip-seq-pipeline2/issues/259
# - https://github.com/ENCODE-DCC/chip-seq-pipeline2/issues/265
# force-install readline 6.2, ncurses 5.9 from conda-forge (ignoring dependencies)
conda install -n encode-chip-seq-pipeline-spp --no-deps --no-update-deps -y \
  readline==6.2 ncurses==5.9 -c conda-forge

echo "$(date): Done successfully."

bash ${SH_SCRIPT_DIR}/update_conda_env.sh
