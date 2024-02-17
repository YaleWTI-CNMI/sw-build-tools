#!/bin/bash

_tool_chain="foss-2022b"
_cuda_ver="CUDA-12.2.2"
_pytorch_ver="2.3.0a0"
_sw_ver="0.18.0a0"
_sw_name="torchvision"

set -x
module load PyTorch/${_pytorch_ver}-${_tool_chain}-${_cuda_ver}
module load Pillow-SIMD/9.5.0-GCCcore-12.2.0
module load sympy/1.12-gfbf-2022b
module load networkx/3.0-gfbf-2022b
module load FFmpeg/4.3.2-GCCcore-12.2.0


MANUAL_ROOT="/gpfs/radev/apps/avx512/manual"
_install_dir="$MANUAL_ROOT/software/${_sw_name}/${_sw_ver}-${_tool_chain}-${_cuda_ver}"

#git clone https://github.com/pytorch/vision

cd vision

export TORCH_CUDA_ARCH_LIST="8.0;8.6;9.0" 

cp ../setup.py.patch .
patch -i setup.py.patch setup.py
# libnvcuvid.so is in /lib64
export TORCHVISION_LIBRARY=/lib64
export TORCHVISION_INCLUDE=/home/pl543/workspace/Video_Codec_Interface_12.1.14/Interface
#python -m pip install --prefix=${_install_dir}  --no-deps  --ignore-installed  --no-index  --no-build-isolation .
pip install --prefix=${_install_dir} --no-deps --ignore-installed --no-index --no-build-isolation --verbose .

cd ..

# create a module file
MODULE_FILE="${_sw_ver}-${_tool_chain}-${_cuda_ver}.lua"
MODULE_HOME=${MANUAL_ROOT}/modules/${_sw_name}
[ -f ${MODULE_FILE} ] && mkdir -p ${MODULE_HOME}  && cp ${MODULE_FILE} ${MODULE_HOME} || echo "${MODULE_FILE} not found"


