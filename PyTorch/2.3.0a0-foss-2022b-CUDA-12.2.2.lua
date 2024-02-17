help([==[
Description
===========
Tensors and Dynamic neural networks in Python with strong GPU acceleration.
PyTorch is a deep learning framework that puts Python first.

More information
================
 - Homepage: https://pytorch.org/
]==])

whatis([==[Description: Tensors and Dynamic neural networks in Python with strong GPU acceleration.
PyTorch is a deep learning framework that puts Python first.]==])
whatis([==[Homepage: https://pytorch.org/]==])
whatis([==[URL: https://pytorch.org/]==])

local pytorch_ver = "2.3.0a0"
local cuda_ver = "12.2.2"
local tool_chain = "foss-2022b"
local root = "/gpfs/radev/apps/avx512/manual/software/PyTorch/2.3.0a0-foss-2022b-CUDA-12.2.2"

conflict("PyTorch")

depends_on("foss/2022b")
depends_on("Python/3.10.8-GCCcore-12.2.0")
depends_on("CMake/3.24.3-GCCcore-12.2.0")
depends_on("Ninja/1.11.1-GCCcore-12.2.0")
depends_on("PyYAML/6.0-GCCcore-12.2.0")
depends_on("SciPy-bundle/2023.02-gfbf-2022b")
depends_on("cuDNN/8.9.2.26-CUDA-12.2.2")
depends_on("magma/2.7.2-foss-2022b-CUDA-12.2.2")
depends_on("GMP/6.2.1-GCCcore-12.2.0")

prepend_path("CMAKE_PREFIX_PATH", pathJoin(root, "lib/python3.10/site-packages/torch"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib/python3.10/site-packages/torch/lib"))
prepend_path("PATH", pathJoin(root, "bin"))
setenv("TORCH_CUDA_ARCH_LIST", "8.0;8.6;9.0")
setenv("EBROOTPYTORCH", root)
setenv("EBVERSIONPYTORCH", pytorch_ver)

prepend_path("PYTHONPATH", pathJoin(root, "lib/python3.10/site-packages"))

add_property("arch", "gpu")
