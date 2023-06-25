#!/usr/bin/env python3
import torch

# OSX
# PyTorch GPU: torch.device("mps") is analogous to torch.device("cuda")
if __name__ == '__main__':
    print("torch.backends.mps.is_available() ", torch.backends.mps.is_available())  # MacOS version is 12.3+
    print("torch.backends.mps.is_built()     ", torch.backends.mps.is_built())      # PyTorch built with MPS
    print("torch.cuda.is_available()         ", torch.cuda.is_available())

    if torch.cuda.is_available():
        print("torch.cuda.device_count()     ", torch.cuda.device_count())
        print("torch.cuda.get_device_name(0) ", torch.cuda.get_device_name(0))
        print('Memory Usage:')
        print('Allocated:', round(torch.cuda.memory_allocated(0)/1024**3,1), 'GB')
        print('Cached:   ', round(torch.cuda.memory_reserved(0) /1024**3,1), 'GB')


    # Cross-Platform CUDA, MPS or CPU
    device = torch.device("cuda" if torch.cuda.is_available()         else
                          "mps"  if torch.backends.mps.is_available() else
                          "cpu")
    print("\ndevice =", device)
    x = torch.tensor([1.0, 2.0, 3.0], device=device)
    y = torch.tensor([4.0, 5.0, 6.0], device=device)
    z = x + y
    print(f"{x} + {y} == {z}")