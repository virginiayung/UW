
module quadrature2

    use omp_lib

contains

real(kind=8) function trapezoid(f, a, b, n)

    ! Estimate the integral of f(x) from a to b using the
    ! Trapezoid Rule with n points.

    ! Input:
    !   f:  the function to integrate
    !   a:  left endpoint
    !   b:  right endpoint
    !   n:  number of points to use
    ! Returns:
    !   the estimate of the integral
     
    implicit none
    real(kind=8), intent(in) :: a,b
    real(kind=8), external :: f
    integer, intent(in) :: n

    ! Local variables:
    integer :: j
    real(kind=8) :: h, trap_sum, xj

    h = (b-a)/(n-1)
    trap_sum = 0.5d0*(f(a) + f(b))  ! endpoint contributions
    
    !$omp parallel do private(xj) reduction(+ : trap_sum) 
    do j=2,n-1
        xj = a + (j-1)*h
        trap_sum = trap_sum + f(xj)
        enddo

    trapezoid = h * trap_sum

end function trapezoid


real(kind=8) function simpson(f, a, b, n)

    ! Estimate the integral of f(x) from a to b using the
    ! Simpson's Rule with n points.

    ! Input:
    !   f:  the function to integrate
    !   a:  left endpoint
    !   b:  right endpoint
    !   n:  number of points to use
    ! Returns:
    !   the estimate of the integral
     
    implicit none
    real(kind=8), intent(in) :: a,b
    real(kind=8), external :: f
    integer, intent(in) :: n
    integer:: nthreads

    ! Local variables:
    integer :: j
    real(kind=8) :: h, simp_sum_full,simp_sum_half, xj, xc

 
    !$ nthreads = 4   ! for openmp
    !$ call omp_set_num_threads(nthreads)

    h = (b-a)/(n-1)
    simp_sum_full = 0d0 ! initializing
    simp_sum_half = f(a + 0.5d0*h) ! initializing
    
    !$omp parallel do private(xj,xc) reduction(+ : simp_sum_half, simp_sum_full) 
    do j=2,n-1
        xj = a + (j-1)*h
        xc= (a + 0.5d0*h)+(j-1)*(b-a-h)/(n-2) 
        simp_sum_full = simp_sum_full + f(xj)
        simp_sum_half =  simp_sum_half + f(xc)

        enddo

    simpson = h/6d0 * ((2d0*simp_sum_full) + (4d0* simp_sum_half)+f(a)+f(b))

end function simpson


subroutine error_table(f,a,b,nvals,int_true,method)

    ! Compute and print out a table of errors when the quadrature
    ! rule specified by the input function method is applied for
    ! each value of n in the array nvals.

    implicit none
    real(kind=8), intent(in) :: a,b, int_true
    real(kind=8), external :: f, method
    integer, dimension(:), intent(in) :: nvals

    ! Local variables:
    integer :: j, n
    real(kind=8) :: ratio, last_error, error, int_approx

    print *, "      n         approximation        error       ratio"
    last_error = 0.d0   
    do j=1,size(nvals)
        n = nvals(j)
        int_approx = method(f,a,b,n)
        error = abs(int_approx - int_true)
        ratio = last_error / error
        last_error = error  ! for next n

        print 11, n, int_approx, error, ratio
 11     format(i8, es22.14, es13.3, es13.3)
        enddo

end subroutine error_table


end module quadrature2

