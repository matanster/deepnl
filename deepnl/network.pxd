
cimport numpy as np
from extractors cimport *

# ctypedef np.ndarray[FLOAT_t, ndim=1] np.ndarray[FLOAT_t,ndim=1]
# ctypedef np.ndarray[FLOAT_t, ndim=2] np.ndarray[FLOAT_t,ndim=2]
# ctypedef np.ndarray[INT_t, ndim=1] np.ndarray[INT_t,ndim=1]
# ctypedef np.ndarray[INT_t, ndim=2] np.ndarray[INT_t,ndim=2]

cdef float adaEps

cdef class Variables(object):
    """Visible and hidden variables.
    Unique to thread"""
    
    cdef public np.ndarray input, hidden, output

cdef class Parameters(object):
    """
    Network parameters: weights and biases.
    Shared by threads.
    """

    cdef public np.ndarray hidden_weights, hidden_bias
    cdef public np.ndarray output_weights, output_bias

cdef class Gradients(Parameters):

    # gradients for input variables
    cdef public np.ndarray input

cdef class Network(Parameters):
    
    # sizes (public for loading)
    cdef public int input_size, hidden_size, output_size
    
    # data for statistics during training. 
    cdef public float error
    
    # function to save periodically
    cdef public object saver

    cdef variables(self, int slen=*)
    cdef gradients(self, int slen=*)

    cpdef run(self, Variables vars)

    cdef float backpropagate(self, int y, Variables vars, Gradients grads)

    cpdef update(self, Gradients grads, float learning_rate,
                 Gradients ada=*)

