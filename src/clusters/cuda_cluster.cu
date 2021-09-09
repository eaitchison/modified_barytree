#include <cuda.h>
#include <cuda_runtime.h>

#include "cuda_cluster.h"


__global__ void clust_int(double *clusterX, double *clusterY, double *clusterZ, double *d_tt,double *d_nodeX,\
                          double *d_nodeY, double *d_nodeZ,double h_xb,double h_yb, double h_zb, double x0, \
                          double y0, double z0, int interpDegreeLim, int interpolationDegree, \
                          int interpolationPointsPerCluster, int startingIndexInClustersArray){


               int i=threadIdx.x + blockDim.x * blockIdx.x;
               for ( int o=i;o<interpDegreeLim; o++){
                    d_tt[o]=cos(o * M_PI / interpolationDegree);
                    d_nodeX[o]=x0 + (d_tt[o] + 1.0)/2.0 * h_xb;
                    d_nodeY[o]=y0 + (d_tt[o] + 1.0)/2.0 * h_yb;
                    d_nodeZ[o]=z0 + (d_tt[o] + 1.0)/2.0 * h_zb;
                  }
               for ( j=i;j<interpolationPointsPerCluster;j++){
                   int k1 = j%(interpolationDegree+1);
                   int kk = (j-k1)/(interpolationDegree+1);
                   int k2 = kk%(interpolationDegree+1);
                   kk=kk-k2;
                   int k3 = kk/ (interpolationDegree+1);
                   clusterX[startingIndexInClustersArray +j]=d_nodeX[k1];
                   clusterY[startingIndexInClustersArray +j]=d_nodeY[k2];
                   clusterZ[startingIndexInClustersArray +j]=d_nodeZ[k3];
                  }
  }




void cluster_interp(double *clusterX, double *clusterY, double *clusterZ, \
                          double h_xb,double h_yb, double h_zb, double x0, \
                          double y0, double z0, int interpDegreeLim, int interpolationDegree, \
                          int interpolationPointsPerCluster, int startingIndexInClustersArray){

    double *d_tt, *d_nodeX, *d_nodeY, *d_nodeZ, *d_clusterX,*d_clusterY,*d_clusterZ;
    double d_xb,d_yb,d_zb,h_xb,h_yb,h_zb,d_x0,d_y0,d_z0;
    cudaMalloc((void **) &d_tt, interpDegreeLim * sizeof(double));
    cudaMalloc((void **) &d_nodeX, interpDegreeLim * sizeof(double));
    cudaMalloc((void **) &d_nodeY, interpDegreeLim * sizeof(double));
    cudaMalloc((void **) &d_nodeZ, interpDegreeLim * sizeof(double));
    cudaMalloc((void **) &d_clusterX, interpolationPoinstsPerCluster * sizeof(double));
    cudaMalloc((void **) &d_clusterY, interpolationPointsPerCluster * sizeof(double));
    cudaMalloc((void **) &d_clusterZ, interpolationPointsPerCluster * sizeof(double));
    cudaMemcpy(d_tt,0.0, interpDegreeLim * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_nodeX,0.0, interpDegreeLim * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_nodeY,0.0, interpDegreeLim * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_nodeZ,0.0, interpDegreeLim * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_clusterX,clusterX, interpolationPointsPerCluster * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_clusterY,clusterY, interpolationPointsPerCluster * sizeof(double),cudaMemcpyHostToDevice);
    cudaMemcpy(d_clusterZ,clusterZ, interpolationPointsPerCluster * sizeof(double),cudaMemcpyHostToDevice);
    clust_int<<<1, 32>>(d_clusterX,d_clusterY,d_clusterZ,d_tt,d_nodeX,d_nodeY,d_nodeZ,h_xb,h_yb,h_zb,x0, \
                        y0,z0,interpDegreeLim,interpolationDegree,interpolationPointsPerCluster, \
                        startingIndexInClustersArray)
    cudaDeviceSynchronize();
    cudaMemcpy(clusterX,d_clusterX,interpolationPointsPerCluster * sizeof(double),cudaMemcpyDeviceToHost);
    cudaMemcpy(clusterY,d_clusterY,interpolationPointsPerCluster * sizeof(double),cudaMemcpyDeviceToHost);
    cudaMemcpy(clusterZ,d_clusterZ,interpolationPointsPerCluster * sizeof(double),cudaMemcpyDeviceToHost);
    cudaFree(d_tt);
    cudaFree(d_nodeX);
    cudaFree(d_nodeY);
    cudaFree(d_nodeZ);
    cudaFree(d_clusterX);
    cudaFree(d_clusterY);
    cudaFree(d_clusterZ);
    return; 
} 
