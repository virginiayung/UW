! yungv_uwhpsc/homework3/am583/test_quartic.f90

program test_quartic

    use newton_583, only: solve,tol
    use functions, only: f_quartic, fprime_quartic, eps

    implicit none
    real(kind=8) :: x, x0, fx, xstar
    real(kind=8) :: eps_vals(3), tol_vals(3)
    integer :: iters, ieps, itol
	logical :: debug         ! set to .true. or .false.

    print *, "Test routine for computing zero of f"
    debug = .true.

    x0 = 0.4d01
    print 11, x
 11     format('Initial guess: x = ', e22.15)
    
    print *, '    epsilon        tol    iters          x                 f(x)       x-xstar'
    
    ! values to test as eps:
    eps_vals = (/ 0.100d-03, 0.100d-07, 0.100d-11/)
    
    do ieps = 1,3
        eps = eps_vals(ieps)
        
        ! values to test as tol:
        tol_vals = (/0.100d-04, 0.100d-09, 0.100d-13/)
        
        do itol = 1,3
            tol=tol_vals(itol)
            xstar= 1.d0 + (eps**(.25d0))
   
            print *, ' '  ! blank line
            call solve(f_quartic, fprime_quartic, x0, x, iters, debug)
 
            fx = f_quartic(x)
            print 12, eps, tol, iters, x, fx, x-xstar
12          format(2d13.3, i4, d24.15, 2d13.3)

        enddo
    enddo        
   

end program test_quartic
