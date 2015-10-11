#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>
#include <math.h>
using namespace std;

__global__ void vecAddKernel(float *A, float *B, float *C, int n) {
	int i = threadIdx.x + blockDim.x * blockIdx.x;
	if (i < n)
		C[i] = A[i] + B[i];
}

__host__ void vecAdd(float* A, float* B, float* C, int n) {
	int size = n*sizeof(float);
	float *d_A, *d_B, *d_C;

	//Allocate device(GPU) memory for A,B, C
	cudaMalloc((void **) &d_A, size);
	cudaMalloc((void **) &d_B, size);
	cudaMalloc((void **) &d_C, size);

	//Copy A, B to device memory
	cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

	//Kernel launch code to have the device to perform actual vector addition
	//cout << "Attempting to launch the kernel" << "\n";
	vecAddKernel <<< ceil(n / 256.0), 256 >>> (d_A, d_B, d_C, n);

	//Copy C from the device memory
	cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

	//print values
	cout << ceil(*A) << "\n";
	cout << ceil(*B) << "\n";
	cout << ceil(*C) << "\n";
	system("pause");

	//Free device vectors
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
}

int main() {
	int N;
	cout << "Provide value for the length of the vector to be processed:";
	cin >> N;

	//Allocate input vectors h_A, h_b, h_C
	float* h_A = (float*)malloc(N * sizeof(float));
	float* h_B = (float*)malloc(N * sizeof(float));
	float* h_C = (float*)malloc(N * sizeof(float));
	vecAdd(h_A, h_B, h_C, N);
	free(h_A);
	free(h_B);
	free(h_C);
}

