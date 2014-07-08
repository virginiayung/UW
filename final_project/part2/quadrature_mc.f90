
module quadrature_mc

contains

real(kind=8) function quad_mc(g, a, b, ndim, npoints)

    ! Input:
    !   g:  the function defining the integrand. g takes 2 arguments x and ndim, where
    !       x= an array of length ndim
    !   a:  arrays of lenfth ndim. lower limit of integration in each dim
    !   b:  arrays of lenfth ndim. upper limit of integration in each dim
    !   ndim: num of dim to integrate over
    !   npoints:  number of Monte Carlo samples
    ! Returns:
    !   the Monte Carlo approximation to the integral
     
    implicit none
    real(kind=8), dimension(ndim), intent(in) :: a,b
    real(kind=8), external :: g
    integer, intent(in) :: ndim, npoints
    integer:: n
    real(kind=8), allocatable :: r(:)
    real(kind=8) :: x(ndim), gsum

    

    ! Local variables:
    integer :: i
  
    n= ndim*npoints
    allocate(r(n))
    call random_number(r)

  
    do i=1,npoints
        x= a + [r((i-1)*ndim+1:i*ndim)*(b-a)]
        gsum = gsum + g(x,ndim)
        enddo

    quad_mc = (gsum*(2.d0)**ndim)/npoints


end function quad_mc

end module quadrature_mc

