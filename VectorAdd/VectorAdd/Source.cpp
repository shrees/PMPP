//#include <cuda.h>
#include "std_lib_facilities.h"

int main() {
	cout << "Hello, World!\n;"
	return 0;
}


/* void vecAdd(float* A, float* B, float* C, int n) {
	int size = n * sizeof(float);
	float *A_d, *B_d, *C_d;

	//Allocate device memmory for A, B and C
	//Copy A and B to device memory

	//Kernel launch code to have the device to perform actual vector additions

	//Copy C from the device memory
	//Free device vectors
} */