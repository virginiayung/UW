! homework3/functions.f90

module functions

contains

!functions for sqrt
real(kind=8) function f_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x

    f_sqrt = x**2 - 4.d0

end function f_sqrt


real(kind=8) function fprime_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x
    
    fprime_sqrt = 2.d0 * x

end function fprime_sqrt


!function for intersections
real(kind=8) function f_intersections(x)
    implicit none
    real(kind=8), intent(in) :: x
    real(kind=8), parameter :: pi= acos(-1.d0)

    f_intersections = x*cos(pi*x) - 1.d0 + 0.6d0*x**2

end function f_intersections


real(kind=8) function fprime_intersections(x)
    implicit none
    real(kind=8), intent(in) :: x
    real(kind=8), parameter :: pi= acos(-1.d0)
    
    fprime_intersections = cos(pi*x) - pi*x*sin(pi*x) + 1.2d0*x

end function fprime_intersections

end module functions
