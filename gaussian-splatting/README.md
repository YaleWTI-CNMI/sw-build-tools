`build-gaussian-splatting.sh` builds Gaussian Splatting within a Python virtual environment named `gs_venv` in a directory specified in the environment variable `GS_ROOT` if it is set. If `GS_ROOT` is not set, then the script will build Gaussian Splatting in your current directory where the script is launched. 

The script downloads the latest code from the main branch of [Gaussian Splatting](https://github.com/graphdeco-inria/gaussian-splatting), and
loads all necessary dependancy packages already installed on the cluster. It builds the submodules `diff-gaussian-rasterization` and `simple-knn` into `gs_venv`
and builds `SIBR_viewers` in the subdirectory "SIBR_viewers/install". It generates an environment setup file `gs_env.sh` which must be sourced before you using
this build of Gaussian Splatting.

## How to use SIBR_viewer

SIBR_viewer requires a GPU to run. On cluster misha, we suggest you running it in a Open OnDemand Remote Desktop instance. Follow the steps below.

1. Launch a Remote Desktop in OOD.
2. Set up a Gaussian Splatting working environment in a bash terminal in Remote Desktop:
```bash
source /path/to/gs_env.sh
```
3. Launch a SIBR_viewers with ycr_vglrun to make use of the GPU. For eaxample: 
```bash
ycrc_vglrun SIBR_remoteGaussian_app
```

