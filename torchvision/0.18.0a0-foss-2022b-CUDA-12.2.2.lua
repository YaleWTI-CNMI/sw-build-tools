help([==[

Description
===========
Datasets, Transforms and Models specific to Computer Vision


More information
================
 - Homepage: https://github.com/pytorch/vision
]==])

whatis([==[Description:  Datasets, Transforms and Models specific to Computer Vision]==])
whatis([==[Homepage: https://github.com/pytorch/vision]==])
whatis([==[URL: https://github.com/pytorch/vision]==])

local root = "/gpfs/radev/apps/avx512/software/torchvision/0.18.0a0-foss-2022b-CUDA-12.2.2"

conflict("torchvision")

depends_on("foss/2022b")
depends_on("Python/3.10.8-GCCcore-12.2.0")
depends_on("Pillow-SIMD/9.5.0-GCCcore-12.2.0")
depends_on("PyTorch/2.3.0a0-foss-2022b-CUDA-12.2.2")
depends_on("FFmpeg/4.3.2-GCCcore-12.2.0")
depends_on("sympy/1.12-gfbf-2022b")
depends_on("networkx/3.0-gfbf-2022b")

prepend_path("CMAKE_PREFIX_PATH", root)
setenv("EBROOTTORCHVISION", root)
setenv("EBVERSIONTORCHVISION", "0.18.0a0")

prepend_path("PYTHONPATH", pathJoin(root, "lib/python3.10/site-packages"))
add_property("arch", "gpu")
