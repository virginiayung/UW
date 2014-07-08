
module functions

    use omp_lib
    implicit none
    integer :: fevals(0:7), gevals(0:7)
    integer :: ny
    real(kind=8) :: c,d
    save

contains

real(kind=8) function f(x)
        implicit none
        real(kind=8), intent(in) :: x
        real(kind=8) :: yj, dy
        integer :: j
        integer thread_num

        ! keep track of number of function evaluations by
        ! each thread:
        thread_num = 0   ! serial mode
        !$ thread_num = omp_get_thread_num()
        fevals(thread_num) = fevals(thread_num) + 1

        
        dy= (d-c)/(ny-1)
        f = 0.5d0*(g(x,c)+g(x,d)) !endpoint contributer
        
        do j=2,ny-1
            yj = c + (j-1)*dy
            f = f + g(x,yj)
            enddo

        f = dy * f

end function f

real(kind=8) function g(x,y)

        implicit none
        real(kind=8),intent(in) :: x,y
        integer thread_num

        !keep track of number of function evaluations by each thread:
        thread_num = 0 ! serial mode
        !$ thread_num = omp_get_thread_num()
        gevals(thread_num) = gevals(thread_num) + 1

        g = sin (x+y)
end function g

end module functions
