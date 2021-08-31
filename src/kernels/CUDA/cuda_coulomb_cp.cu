#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>
#include <cuda_runtime.h>
#define CHECK(call) { const cudaError_t error = call; if (error != cudaSuccess) {printf("Error:%s:%d, ", __FILE__, __LINE__); printf("code:%d, reason: %s\n" , error, cudaGetErrorString(error)); exit(1); }}

// CUDA Kernel for  Coulomb Cluster-Particle interaction

__global__ void K_CUDA_Coulomb_CP_Lagrange (int batches, int interp_points, double *source_x, double *source_y, double *source_z, double *cluster_x, double *cluster_y, double *cluster_z, double *cluster_q, double *s_charge, double *potential){

          int i=threadIdx.x + blockDim.x * blockIdx.x;
          int j=blockDim.x * gridDim.x;
          int p=0;
          double dx, dy,dz,r2,tp;

                for( int k=i; k<interp_points; k +=j){
                     p=i-((floorf(i/(batches)))*(batches));
                     dx= cluster_x[i]-source_x[p];
                     dy= cluster_y[i]-source_y[p];
                     dz= cluster_z[i]-source_z[p];

                      r2=(dx*dx)+(dy*dy)+(dz*dz);
                      tp=+=s_charge(p)/sqrt(r2);



  }
 }

