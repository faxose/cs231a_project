/*===========================================================================*
* mindist.c
* Computes minimum Euclidean distance between pairs of a set of vectors
*
* Niru Maheswaranathan
* November 21, 2012
*===========================================================================*/

#include <mex.h>
#include <math.h>

/**
* Pairwise distance of a set of vectors.
*/
mxArray* mindistvec(const mxArray* data) {

    /* Initialize variables */
	const double* x = mxGetPr(data);

	int m = mxGetM(data);
	int n = mxGetN(data);

	mxArray* res;
	double* pr;

	int i,j,k;

    /* create Mx1 output vector */
	res = mxCreateDoubleMatrix(m, 1, mxREAL);
	pr =  mxGetPr(res);

	for (i = 0; i < m; i++) {
		/*double* p1 = pmat1 + i;*/
		/*double* p2 = pmat2 + i;*/
        double p1 = 0; //x[i];
        /*mexPrintf("Root (%1.0i):\n",i+1);*/
		double mindist = 100.0;

		for (j = 0; j < m; j++) {

            /*mexPrintf("\tPair (%1.0i):\n",j+1);*/
            double p2 = 0; //x[j];
            double curdist = 0;
            /*mexPrintf("p2 is: %4.2f\n",x[0]);*/

            if (i != j) {

                for (k = 0; k < n; k++) {
                    p1 = x[i+k*m];
                    p2 = x[j+k*m];
                    curdist += (p1 - p2)*(p1 - p2);
                    /*mexPrintf("\t\tdistance is %4.3f\n", curdist);*/
                }

                if (curdist < mindist) {
                    /*mexPrintf("\t\tNEW MINIMUM (%4.3f) = ",curdist);*/
                    mindist = curdist;
                    /*mexPrintf("(%4.3f)\n",mindist);*/
                }

            }
		}

		*(pr++) = sqrt(mindist);
	}
	return res;
}

/**
* Entry point.
*/
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {
    plhs[0] = mindistvec(prhs[0]);
}
