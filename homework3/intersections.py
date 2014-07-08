"""
solving g1(x)=g2(x) or equivalently solving for zeros of the 
function f(x)=g1(x)-g2(x) by using newton.solve
"""

import numpy as np
from pylab import *
interactive(True)
from newton2 import solve


#Graph to find intersections to use as x0
x = np.linspace(-10,10, 1000)
ylim(-3,3,0.01)

g1 = x*np.cos(np.pi*x)
g2= 1-0.6*x**2

plot(x,g1,'b-')
plot(x,g2,'r-')

title("Plot 2 Functions")
show()

def fvals_g1g2(x):

    """
    Return f(x) and f'(x) for applying Newton to find a square root.
    """

    f = x*np.cos(np.pi*x)-1. + 0.6*x**2.
    fp = np.cos(np.pi*x)- np.pi*x*np.sin(np.pi*x) + 1.2*x
    return f, fp


def test_intersections(debug_solve=False):
    """
    Test Newton iteration for the square root with different initial
    conditions."
    """

 
    for x0 in [-2., -1.6, -0.8, 1.4]:
        print " "  # blank line
        x, iters = solve(fvals_g1g2, x0, debug=debug_solve)
        print "With initial guess x0 = %22.15e ," %(x0)
        print "solve returns x = %22.15e after %i iterations " % (x,iters)
        fx, fpx = fvals_g1g2 (x)
        print "the value of f(x) is %22.15e" % fx
        xt=x
        y= xt*np.cos(np.pi*xt)
        x = np.linspace(-5,5, 1000)
        ylim(-3,3,0.01)

        g1 = x*np.cos(np.pi*x)
        g2= 1-0.6*x**2


        p1, = plot(x,g1,'b-',label= 'g1(x)')
        p2, = plot(x,g2,'r-',label= 'g2(x)')

        plot(xt,y, 'ko')

        legend([p1,p2],["g1","g2"])

        title("Plot 2 Functions with intersections")
        show()
        plt.savefig('intersections.png')