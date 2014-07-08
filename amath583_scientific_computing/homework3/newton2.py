"""
module newton
Estimate the zero of f(x) using Newton's method. 
Input:
      f:  the function to find a root of
      fp: function returning the derivative f'
      x0: the initial guess
      debug: logical, prints iterations if debug= False.
Returns:
      the estimate x satisfying f(x)=0 (assumes Newton converged!) 
      the number of iterations iters
"""


import numpy as np
import matplotlib.pyplot as plt


def solve(fvals, x0, debug=False):
   
    #module parameters:
    maxiter = 20
    tol = 1e-14

    # initial guess
    x = x0
    iters = 0

    if debug:
        print "Initial guess: x = %22.15e" %(x)

    for k in range(maxiter):  
        
        # compute Newton increment x:
        delta_x = fvals(x)[0] / fvals(x)[1]

        if abs(fvals(x)[0]) < tol:
            break
        else:
            # update x:
            x = x - delta_x

        if debug:
            print "After %s iterations, x = %22.15e" %(k+1,x)
            
    # number of iterations taken:
    iters = k
  
    return x, iters


def fvals_sqrt(x):

    """
    Return f(x) and f'(x) for applying Newton to find a square root.
    """

    f = x**2 - 4.
    fp = 2. *x
    return f, fp


def test1(debug_solve=False):
    """
    Test Newton iteration for the square root with different initial
    conditions."
    """

    from numpy import sqrt
    for x0 in [1., 2., 100.]:
        print " "  # blank line
        x, iters = solve(fvals_sqrt, x0, debug=debug_solve)
        print "solve returns x = %22.15e after %i iterations " % (x,iters)
        fx, fpx = fvals_sqrt (x)
        print "the value of f(x) is %22.15e" % fx
        assert abs(x-2.) < 1e-14, "*** Unexpected result: x = %22.15e" % x




