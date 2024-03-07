#!/bin/bash

_PREFIX="${TG_PATH:-$(pwd)}"

module load Ninja 
module load PyTorch/2.1.2-foss-2022b-CUDA-12.1.1
pip install --prefix=${_PREFIX} pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.1.2+cu121.html
pip install --prefix=${_PREFIX} torch_geometric

# generate a env.sh file which needs to be sourced every time when running torch_geometric in a new session

echo "module load PyTorch/2.1.2-foss-2022b-CUDA-12.1.1
export PYTHONPATH=${_PREFIX}/lib/python3.10/site-packages:\$PYTHONPATH
export PATH=${_PREFIX}/bin:\$PATH" > ${_PREFIX}/env.sh

echo "
Torch Geometric has been installed in ${_PREFIX}/lib/python3.10/site-packages.
Please run 

       source ${_PREFIX}/env.sh

before using this installation of Torch Geometric.

"
