# OSX M1 GPU Installation 

## packages
- tensorflow       # linux/windows only - leave uninstalled for OSX M1
- tensorflow-macos # M1 CPU support
- tensorflow-metal # M1 GPU support

## pip --user
```
conda deactivate
```
```
pip uninstall      tensorflow-macos tensorflow-metal tensorflow 
pip install --user tensorflow-macos tensorflow-metal 
pip install -r requirements.txt
```

### Errors
> status: INTERNAL: platform is already registered with name: "METAL"
- TensorFlow metal plugin appears to be registering itself twice when installed under /opt/homebrew.
- If you install tensorflow-metal using pip in the system locations for brewed pythons, you might get the error about the METAL plugin having been already registered.
- To avoid this, install tensorflow-metal in your user directory library instead:

### Test Pytorch

Pytorch M1 GPU uses MPS (Metal Performance Shaders) backend rather than NVIDIA CUDA
```
$ ./test_pytorch.py 
torch.backends.mps.is_available()  True
torch.backends.mps.is_built()      True
torch.cuda.is_available()          False

device = mps
tensor([1., 2., 3.], device='mps:0') + tensor([4., 5., 6.], device='mps:0') == tensor([5., 7., 9.], device='mps:0')
```

### Test Tensorflow
```
../test_tensorflow.py 
Python               3.11.4 (main, Jun 15 2023, 07:55:38) [Clang 14.0.3 (clang-1403.0.22.14.1)]
Python Platform:     macOS-13.4.1-arm64-arm-64bit
Tensor Flow Version: 2.12.0
Keras Version:       2.12.0
len(tf.config.list_physical_devices('GPU'))  1
tf.config.list_physical_devices('GPU')       [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]

Calculation:
2023-06-25 14:50:07.730614: I metal_plugin/src/device/metal_device.cc:1154] Metal device set to: Apple M1 Max
2023-06-25 14:50:07.730642: I metal_plugin/src/device/metal_device.cc:296] systemMemory: 64.00 GB
2023-06-25 14:50:07.730650: I metal_plugin/src/device/metal_device.cc:313] maxCacheSize: 24.00 GB
2023-06-25 14:50:07.730725: I tensorflow/core/common_runtime/pluggable_device/pluggable_device_factory.cc:306] Could not identify NUMA node of platform GPU ID 0, defaulting to 0. Your kernel may not have been built with NUMA support.
2023-06-25 14:50:07.730760: I tensorflow/core/common_runtime/pluggable_device/pluggable_device_factory.cc:272] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 0 MB memory) -> physical PluggableDevice (device: 0, name: METAL, pci bus id: <undefined>)
input: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.735873: I tensorflow/core/common_runtime/placer.cc:114] input: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
_EagerConst: (_EagerConst): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.735881: I tensorflow/core/common_runtime/placer.cc:114] _EagerConst: (_EagerConst): /job:localhost/replica:0/task:0/device:GPU:0
output_RetVal: (_Retval): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.735885: I tensorflow/core/common_runtime/placer.cc:114] output_RetVal: (_Retval): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.739054: I tensorflow/core/common_runtime/eager/execute.cc:1525] Executing op _EagerConst in device /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.739604: I tensorflow/core/common_runtime/eager/execute.cc:1525] Executing op _EagerConst in device /job:localhost/replica:0/task:0/device:GPU:0
a: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.740580: I tensorflow/core/common_runtime/placer.cc:114] a: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
b: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.740585: I tensorflow/core/common_runtime/placer.cc:114] b: (_Arg): /job:localhost/replica:0/task:0/device:GPU:0
MatMul: (MatMul): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.740590: I tensorflow/core/common_runtime/placer.cc:114] MatMul: (MatMul): /job:localhost/replica:0/task:0/device:GPU:0
product_RetVal: (_Retval): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.740593: I tensorflow/core/common_runtime/placer.cc:114] product_RetVal: (_Retval): /job:localhost/replica:0/task:0/device:GPU:0
2023-06-25 14:50:07.740942: I tensorflow/core/common_runtime/eager/execute.cc:1525] Executing op MatMul in device /job:localhost/replica:0/task:0/device:GPU:0
[[1. 2. 3.]
 [4. 5. 6.]] * [[1. 2.]
 [3. 4.]
 [5. 6.]] == [[22. 28.]
 [49. 64.]]
```


## pip venv
```
conda deactivate
```
```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
```
../test_pytorch.py 
../test_tensorflow.py 
```

## conda
miniforge uses community conda-forge with support for aarch64/M1
- https://github.com/conda-forge/miniforge
- https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
- install into ~/.miniforge3
- Bash startup script: https://github.com/JamesMcGuigan/dotfiles/blob/master/.bash_conda


```
deactivate
conda deactivate
```
```
rm -rvf ~/.miniforge3/envs/metal
conda env create -n metal -f conda-apple-metal.yml
conda activate metal
```
```
../test_pytorch.py 
../test_tensorflow.py 
```

## DOCS
- https://stackoverflow.com/questions/72964800/what-is-the-proper-way-to-install-tensorflow-on-apple-m1-in-2022
- https://stackoverflow.com/questions/67912944/tensorflow-metal-plugin-already-registered-error/76550557#76550557
