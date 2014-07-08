

"""
Demonstration module for quadratic interpolation.
Update this docstring to describe your code.
Modified by: ** Virginia Yung **
"""


import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import solve

def quad_interp(xi,yi):
    """
    Quadratic interpolation.  Compute the coefficients of the polynomial
    interpolating the points (xi[i],yi[i]) for i = 0,1,2.
    Returns c, an array containing the coefficients of
    p(x) = c[0] + c[1]*x + c[2]*x**2.

    """

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have length 3"
    assert len(xi)==3 and len(yi)==3, error_message

    # Set up linear system to interpolate through data points:

    # Data Points:
    print "xi = ",xi
    print "yi = ",yi
    
    A = np.array([[1., xi[0], xi[0]**2], [1., xi[1], xi[1]**2], [1., xi[2], xi[2]**2]])
    b = yi
    print "A=",A
    # A = np.vstack([np.ones(3),xi, xi**2]).T
    ## np.vstack takes its argument a list of numpy arrays and stacks them
    ## vertically into a matrix    
	

    # Solve the System
    c = solve(A,b)
    
    print "The Polynomial Coefficients Are:"
    print c
    return c

# plot the resulting polynomial:
 
def plot_quad(xi,yi):
    """
    Takes two numpy arrays xi and yi of length 3, calls quad_interp
    to compute c, and plots both the interpolation polynomial and the
    data points, and saves the resulting figure as quadratic.png
    """
    c= quad_interp(xi,yi)
    x = np.linspace(xi.min() -1, xi.max() +1, 1000)
    y =  c[0] + c[1]*x + c[2]*x**2
    
    plt.figure(1)		# open plot figure window
    plt.clf()		# clear figure
    plt.plot(x,y,'b-')	# connect points with a blue line

    # Add data points (Polynomial should go through all three points!)
    plt. plot(xi,yi, 'ro')	# plot as red circles
    plt. ylim(-2,8)

    plt.title("Data points and interpolation polynomial")
    plt.savefig('quadratic.png')	# Save figure as .png file



def test_quad1():
    """
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2.])
    yi = np.array([ 1., -1.,  7.])
    c = quad_interp(xi,yi)
    c_true = np.array([-1.,  0.,  2.])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_quad2():
    """
    Test Code, no return value or exception if test runs properly.
    """
    xi = np.array([-1., 1., 2.])
    yi = np.array([ 0., 4., 3.])
    c= quad_interp(xi,yi)
    c_true = np.array([ 3., 2., -1.])
    print "c=       ", c
    print "c_true = ", c_true
    #test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def cubic_interp(xi,yi):
    """
    cubic interpolation.  Compute the coefficients of the polynomial
    interpolating the points (xi[i],yi[i]) for i = 0,1,2.
    Returns c, an array containing the coefficients of
    p(x) = c[0] + c[1]*x + c[2]*x**2 + c[3]*x**3

    """

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have length 4"
    assert len(xi)==4 and len(yi)==4, error_message

    # Set up linear system to interpolate through data points:

    # Data Points:
    print "xi = ",xi
    print "yi = ",yi
    
    
    b = yi
    A = np.vstack([np.ones(4),xi, xi**2, xi**3]).T
    print "A=",A
    ## np.vstack takes its argument a list of numpy arrays and stacks them
    ## vertically into a matrix    
	

    # Solve the System
    c = solve(A,b)
    
    print "The Polynomial Coefficients Are:"
    print c
    return c

        
    
# plot the resulting polynomial:
 
def plot_cubic(xi,yi):
    """
    Takes two numpy arrays xi and yi of length 4, calls cubic_interp
    to compute c, and plots both the interpolation polynomial and the
    data points, and saves the resulting figure as cubic.png
    """
    c= cubic_interp(xi,yi)
    x = np.linspace(xi.min() -1, xi.max() +1, 1000)
    y =  c[0] + c[1]*x + c[2]*x**2 + c[3]*x**3
    
    plt.figure(1)		# open plot figure window
    plt.clf()		# clear figure
    plt.plot(x,y,'b-')	# connect points with a blue line

    # Add data points (Polynomial should go through all three points!)
    plt. plot(xi,yi, 'ro')	# plot as red circles
    plt. ylim(-2,8)

    plt.title("Data points and interpolation polynomial")
    plt.savefig('cubic.png')	# Save figure as .png file   
    

def test_cubic():
    """
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2., 3.])
    yi = np.array([ 1., -1.,  7., 5.])
    c = cubic_interp(xi,yi)
    c_true = np.array([-1.,  2.,  3., -1.])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)
 


def poly_interp(xi,yi): #generalize the above functions to accept arrays xi, yi of any length n
    n = len (xi)

    # check inputs and print error message if not valid:

    error_message = "xi and yi should have type numpy.ndarray"
    assert (type(xi) is np.ndarray) and (type(yi) is np.ndarray), error_message

    error_message = "xi and yi should have same length"
    assert len(xi)==n and len(yi)==n, error_message

    # Set up linear system to interpolate through data points:

    # Data Points:
    print "xi = ", xi
    print "yi = ", yi
    
    
    b = yi
    #A= np.ones(len(n))
    A = np.column_stack([ xi**(i) for i in range (n)])
    print "A=", A
    ## np.vstack takes its argument a list of numpy arrays and stacks them
    ## vertically into a matrix    
	

    # Solve the System
    c = solve(A,b)
    
    print "The Polynomial Coefficients are:"
    print c
    return c

        
def test_poly1():
    """
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  3.,  5., -2.])
    yi = np.array([ 1., -1.,  7., 14.])
    c = poly_interp(xi,yi)
    c_true = np.array([-5.5, -3.75, 2.5, -.25])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)

def test_poly2():
    """
    Test code, no return value or exception if test runs properly.
    """
    xi = np.array([-1.,  0.,  2., 3., 4.])
    yi = np.array([ 1., -1.,  7., 5., 2.])
    c = poly_interp(xi,yi)
    c_true = np.array([-1, 3.65,  3.275, -2.1, .275])
    print "c =      ", c
    print "c_true = ", c_true
    # test that all elements have small error:
    assert np.allclose(c, c_true), \
        "Incorrect result, c = %s, Expected: c = %s" % (c,c_true)
    
        
def plot_poly(xi,yi):
    c= poly_interp(xi,yi)
    n = len(c)
    x = np.linspace(xi.min() -1, xi.max() +1, 1000)
    y =  c[n-1]
    for j in range (n-1, 0, -1):
        y = y*x + c[j-1]
    
    plt.figure(1)		# open plot figure window
    plt.clf()		# clear figure
    plt.plot(x,y,'b-')	# connect points with a blue line

	# Add data points (Polynomial should go through all three points!)
    plt. plot(xi,yi, 'ro')	# plot as red circles
    plt. ylim(-10,20)

    plt.title("Data points and interpolation polynomial")
    plt.savefig('poly.png')	# Save figure as .png file  
    
    
        
if __name__=="__main__":
    # "main program"
    # the code below is executed only if the module is executed at the command line,
    #    $ python demo2.py
    # or run from within Python, e.g. in IPython with
    #    In[ ]:  run demo2
    print "Running test..."
    if len(xi) ==3 and len(yi)==3:
        test_quad1()
        test_quad2()
    elif len(xi)==4 and len(yi)==4:
        test_cubic()
        test_poly1()
    elif len(xi)==5 and len(yi)==5:
        test_poly2()

       
