#!/bin/bash

_tool_chain="foss-2022b"
_cuda_ver="CUDA-12.2.2"
_sw_ver="2.3.0a0"
_sw_name="PyTorch"

# modules for building PyTorch-CUDA
module load foss/2022b 
module load Python/3.10.8-GCCcore-12.2.0 
module load CMake/3.24.3-GCCcore-12.2.0
module load Ninja/1.11.1-GCCcore-12.2.0
module load PyYAML/6.0-GCCcore-12.2.0
module load SciPy-bundle/2023.02-gfbf-2022b
module load cuDNN/8.9.2.26-CUDA-12.2.2 
module load magma/2.7.2-foss-2022b-CUDA-12.2.2 
module load GMP/6.2.1-GCCcore-12.2.0

MANUAL_ROOT="/gpfs/radev/apps/avx512/manual"
_install_dir="$MANUAL_ROOT/software/${_sw_name}/${_sw_ver}-${_tool_chain}-${_cuda_ver}"

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
git submodule sync
git submodule update --init --recursive


# create a patch file for test/cpp/api/CMakeLists.txt 
_patch_file='test_cpp_api_CMakeLists.txt'
cat << _EOF > ${_patch_file}
--- test/cpp/api/CMakeLists.txt.orig	2024-02-06 14:04:52.236077900 -0500
+++ test/cpp/api/CMakeLists.txt	2024-02-06 14:04:10.546292777 -0500
@@ -83,6 +83,7 @@
   target_compile_options_if_supported(test_api "-Wno-maybe-uninitialized")
   # gcc gives nonsensical warnings about variadic.h
   target_compile_options_if_supported(test_api "-Wno-unused-but-set-parameter")
+  target_compile_options_if_supported(test_api "-Wno-error=nonnull")
 endif()

 if(INSTALL_TEST)
_EOF

# apply the patch file
patch -i ${_patch_file} "test/cpp/api/CMakeLists.txt"

export TORCH_CUDA_ARCH_LIST="8.0;8.6;9.0" 

python setup.py build --cmake-only
python setup.py install --prefix=${_install_dir}

cd ..

# create a module file
MODULE_FILE="${_sw_ver}-${_tool_chain}-${_cuda_ver}.lua"
MODULE_HOME=${MANUAL_ROOT}/modules/${_sw_name}
[ -f ${MODULE_FILE} ] && mkdir -p ${MODULE_HOME}  && cp ${MODULE_FILE} ${MODULE_HOME} || echo "${MODULE_FILE} not found"

