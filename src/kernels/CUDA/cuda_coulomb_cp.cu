#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include "cuda_coulomb_cp.h"
#define CHECK(call) { const cudaError_t error = call; if (error != cudaSuccess) {printf("Error:%s:%d, ", __FILE__, __LINE__); printf("code:%d, reason: %s\n" , error, cudaGetErrorString(error)); exit(1); }}

// CUDA Kernel for  Coulomb Cluster-Particle interaction

__global__ void Coulomb_CP_Lagrange (int batches, int interp_points, double *d_source_x, double *d_source_y, double *d_source_z, double *d_cluster_x, double *d_cluster_y, double *d_cluster_z, double *d_cluster_q, double *d_s_charge, double *d_potential){

          int i=threadIdx.x + blockDim.x * blockIdx.x;
          int j=blockDim.x * gridDim.x;
          int p=0;
          double dx, dy,dz,r2,tp;

                for( int k=i; k<interp_points; k +=j){
                     p=i-((floorf(i/(batches)))*(batches));
                     dx= d_cluster_x[k]-d_source_x[p];
                     dy= d_cluster_y[k]-d_source_y[p];
                     dz= d_cluster_z[k]-d_source_z[p];

                      r2=(dx*dx)+(dy*dy)+(dz*dz);
                      d_potential+=d_s_charge(p)/sqrt(r2);



  }
 }



void K_CUDA_Coulomb_CP_Lagrange(int batches, int interp_points, double *source_x, double *source_y, double *source_z, double *cluster_x, double *cluster_y, double *cluster_z, double *cluster_q, double *s_charge, double *potential) {

       double *d_source_x,*d_source_y,*d_source_z,*d_cluster_x,*d_cluster_y,*d_cluster_z,*d_cluster_q,*d_s_charge,*d_potential;

       cudaMalloc((void **) &d_source_x,batches * interp_points * sizeof(double));
       cudaMalloc((void **) &d_source_y,batches * interp_points * sizeof(double));
       cudaMalloc((void **) &d_source_z,batches * interp_points * sizeof(double));
       cudaMalloc((void **) &d_cluster_x,interp_points * sizeof(double));
       cudaMalloc((void **) &d_cluster_y,interp_points * sizeof(double));
       cudaMalloc((void **) &d_cluster_z,interp_points * sizeof(double));
       cudaMalloc((void **) &d_cluster_q,interp_points * sizeof(double));
       cudaMalloc((void **) &d_s_charge,batches * interp_points * sizeof(double));
       cudaMalloc((void **) &d_potential,batches * interp_points * sizeof(double));
       cudaMemcpy(d_source_x,source_x, batches* interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_source_y,source_y, batches* interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_source_z,source_z, batches* interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_cluster_x,cluster_x, interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_cluster_y,cluster_y, interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_cluster_z,cluster_z, interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_cluster_q,cluster_q, interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_s_charge,s_charge, batches * interp_points * sizeof(double),cudaMemcpyHostToDevice);
       cudaMemcpy(d_potential,0.0, batches * interp_points * sizeof(double),cudaMemcpyHostToDevice);


         Coulomb_CP_Lagrange<<<1,32>>>(batches,interp_points,d_source_x,d_source_y,d_source_z,d_cluster_x,d_cluster_y, d_cluster_z,d_cluster_q,d_s_charge, d_potential);
        cudaDeviceSynchronize();
        cudaMemcpy(potential,d_potential, batches * interp_points *sizeof(double),cudaMemcpyDeviceToHost);
        cudaFree(d_source_x);
        cudaFree(d_source_y);
        cudaFree(d_source_z);
        cudaFree(d_cluster_x);
        cudaFree(d_cluster_y);
        cudaFree(d_cluster_z);
        cudaFree(d_cluster_q);
        cudaFree(d_s_charge);
        cudaFree(d_potential);

        return;

}
