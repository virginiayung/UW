
program test

    use omp_lib

    use quadrature, only: trapezoid, error_table
    use functions, only: f, g, fevals, ny, gevals, c, d

    implicit none
    real(kind=8) :: a,b,int_true
    integer :: nvals(12)
    integer :: i, nthreads

    real(kind=8) :: t1, t2, elapsed_time
    integer(kind=8) :: tclock1, tclock2, clock_rate

    nthreads = 4      ! for serial mode
    !$ nthreads = 4   ! for openmp
    !$ call omp_set_num_threads(nthreads)
    print 100, nthreads
100 format("Using ",i2," threads")

    fevals = 0
    gevals = 0

    ny = 1000
    a = 0.d0
    b = 2.d0
    c = 1.d0
    d = 4.d0
    int_true = -sin(a+c)+sin(a+d)+sin(b+c)-sin(b+d)

    print 10, int_true
 10 format("true integral: ", es22.14)
    print *, " "  ! blank line

    ! values of n to test:   (larger values than before)
    do i=1,10
        nvals(i) = 5 * 2**(i-1)
        enddo

    ! time the call to error_table:
    call system_clock(tclock1)  
    call cpu_time(t1)
    call error_table(f, a, b, nvals, int_true, trapezoid)
    call cpu_time(t2)   
    call system_clock(tclock2, clock_rate)

    elapsed_time = float(tclock2 - tclock1) / float(clock_rate)
    print *, " "
    print 11, elapsed_time
 11 format("Elapsed time = ",f12.8, " seconds")

    print 12, t2-t1
 12 format("CPU time = ",f12.8, " seconds")

    
    ! print the number of function evaluations by each thread:
    do i=0,nthreads-1
        print 101,  i, fevals(i)
101     format("fevals by thread ",i2,": ",i13)
        enddo

    print 102, sum(fevals)
102 format("Total number of fevals: ",i10)

    ! print the number of function evaluations by each thread:
    do i=0,nthreads-1
        print 103,  i, gevals(i)
103     format("gevals by thread ",i2,": ",i13)
        enddo

    print 104, sum(gevals)
104 format("Total number of gevals: ",i10)

end program test
