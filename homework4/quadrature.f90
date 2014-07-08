! yungv_uwhpsc/homework4/quadrature.f90

module quadrature

contains

real(kind=8) function trapezoid (f,a,b,n)
    implicit none
    real(kind=8), intent(in):: a, b
    real(kind=8):: h
    integer:: j,i
    integer, intent(in):: n
    real(kind=8), dimension(1:n):: xj, fj
    real(kind=8):: trap_sum
    real(kind=8), external:: f

    h = (b-a)/(n-1)
    trap_sum = 0.d0
    do i=1,n
        xj(i)= a + (i-1)*h
        fj(i)=f(xj(i))
        trap_sum = trap_sum+fj(i)
        enddo
    trapezoid = h*trap_sum - 0.5*h*(fj(1) + fj(n))
    

end function trapezoid



subroutine error_table(f, a, b, nvals, int_true)
    ! Prints out the error table
   
    
    implicit none

    integer, dimension(:), intent(in):: nvals
    integer:: i, n
    real(kind=8), intent(in):: a, b
    real(kind=8), external::f
    real(kind=8):: int_true
    real(kind=8):: int_trap
    real(kind=8):: error, last_error, ratio
    

    print *, "    n          trapezoid          error          ratio"

    last_error = 0.d0

    do i= 1, size(nvals)
        n= nvals(i)
        int_trap= trapezoid(f, a, b, n)
        error = abs(int_trap - int_true)
        ratio = last_error / error
        last_error = error !for next n
        print 11, n, int_trap, error, ratio
11      format(i8, es22.14, es13.3, es13.3)
        enddo
        



   
end subroutine error_table

end module quadrature
