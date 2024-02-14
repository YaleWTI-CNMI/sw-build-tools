#!/bin/bash

# dependency for building gaussian splatting
module_list="\
PyTorch//2.3.0a0-foss-2022b-CUDA-12.2.2
torchvision/0.18.0a0-foss-2022b-CUDA-12.2.2
assimp/5.2.5-GCCcore-12.2.0
glew/2.2.0-GCCcore-12.2.0-egl
GLFW/3.3.8-GCCcore-12.2.0
Boost/1.81.0-GCC-12.2.0
OpenCV/4.5.5-foss-2022b-contrib
libGLU/9.0.2-GCCcore-12.2.0
Eigen/3.4.0-GCCcore-12.2.0
Embree/3.13.4
GTK3/3.24.35-GCCcore-12.2.0
tbb/2021.10.0-GCCcore-12.2.0"

for module in ${module_list}; do
  module load $module
done

# if GS_ROOT is set, then gaussian splatting will be built into that directory
# otherwist, GS_ROOT will be the current directory.
GS_ROOT=${GS_ROOT:=$(pwd)}

# if NUM_CORES is set, then built gaussian splatting with $NUM_CORES
# otherwise, build it with default number of cores
NUM_CORES=${NUM_CORES:=4}

# create a virtual environment for gaussian-splatting
cd ${GS_ROOT}
virtualenv gs_venv --system-site-packages
source gs_venv/bin/activate
pip install plyfile tqdm

set -x
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
cd gaussian-splatting 
pip install submodules/simple-knn
pip install submodules/diff-gaussian-rasterization
cd SIBR_viewers
cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release -G Ninja
cmake --build build -j${NUM_CORES} --target install

# create an environment setup file which needs be sourced before using this installation of Gaussian Splatting
cd ${GS_ROOT}
touch gs_env.sh
echo "source ${GS_ROOT}/gs_venv/bin/activate" >> gs_env.sh
echo "export PATH=${GS_ROOT}/gaussian-splatting/SIBR_viewers/install/bin:\$PATH" >> gs_env.sh
for module in ${module_list}; do
  echo "module load $module" >> gs_env.sh
done
