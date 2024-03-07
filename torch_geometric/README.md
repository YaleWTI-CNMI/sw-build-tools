PyG (PyTorch Geometric) is a library built upon PyTorch to easily write and train Graph Neural Networks (GNNs) for a wide range of applications related to structured data. We proivde a simple script to allow our users install PyG in their own directory. 

## How to use `build-pyg.sh`

The script looks for the environment variable `PYG_PATH`. If it is set, the script will install PyG into the directory specified by `PYG_PATH`. If it is not set, the script will install PyG under the current directory where the script is executed. 

```bash
export PYG_PATH=/path/to/install
./build-pyg.sh
```

When `build-pyg.sh` is finished, an environment setup file called env.sh will be generated in `PYG_PATH`. You need to run this command before using PyG in a new shell session:

```bash
source /path/to/install/env.sh
```
