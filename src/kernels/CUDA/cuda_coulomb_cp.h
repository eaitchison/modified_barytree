#ifndef K_CUDA_COULOMB_CP_H
#define K_CUDA_COULOMB_CP_H

#include "../../run_params/struct_run_params.h"



void  K_CUDA_Coulomb_CP_Lagrange(int batches, int interp_points, double *source_x, double *source_y, double *source_z, double *cluster_x, double *cluster_y, double *cluster_z, double *cluster_q, double *s_charge, double *potential);

#endif 
