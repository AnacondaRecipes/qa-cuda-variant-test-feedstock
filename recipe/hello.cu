// Minimal CUDA program for the QA CUDA-variant test feedstock.
// Compiling this with nvcc exercises the CUDA toolchain in the build env;
// running it (in the test phase) exercises an actual GPU on the worker.
#include <cstdio>
#include <cuda_runtime.h>

__global__ void hello_kernel() {
    printf("hello from CUDA thread %d\n", threadIdx.x);
}

int main() {
    int device_count = 0;
    cudaError_t err = cudaGetDeviceCount(&device_count);
    if (err != cudaSuccess) {
        printf("cudaGetDeviceCount failed: %s\n", cudaGetErrorString(err));
        return 1;
    }
    printf("CUDA devices visible: %d\n", device_count);

    hello_kernel<<<1, 4>>>();
    cudaDeviceSynchronize();
    return 0;
}
