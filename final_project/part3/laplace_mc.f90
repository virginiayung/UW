! MAIN PROGRAM
program laplace_mc


    use mc_walk, only: random_walk, many_walks, nwalks
    use problem_description, only: nx, ny, dx, dy,ax, ay,bx, by,utrue, uboundary
    use random_util, only : init_random_seed

    implicit none
    real(kind=8) :: x0, y0
    real(kind=8) :: u_true, u_mc, error
    real(kind=8) :: u_mc_total, u_sum_old, u_sum_new
    integer :: i, j, i0, j0,max_steps, n_mc, seed1 
    integer :: n_success, n_total



    !Try it out from a specific (x0,y0):
    x0 = 0.9
    y0 = 0.6
    nwalks = 0
    
    i0 = nint((x0-ax)/dx)
    j0 = nint((y0-ay)/dy)

    ! shift (x0,y0) to a grid point if it wasn't already:
    x0 = ax + i0*dx
    y0 = ay + j0*dy

    u_true = utrue(x0,y0)

    seed1 = 12345 ! or set to 0 for random seed
    call init_random_seed(seed1) 

    print *, "seed1 for random number generator:", seed1 

    ! maximum number of step in each before giving up:
    max_steps = 100*max(nx, ny)

    ! initial number of Monte-Carlo walks to take:
    n_mc = 10

    call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)

    error = abs((u_mc - u_true) / u_true)

    print 10, n_success, u_mc, error
10 format (i8,e24.15,e15.6)
    

    !start accumulating totals:
    u_mc_total = u_mc
    n_total = n_success

    do i=1,12
        call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)
        u_sum_old = u_mc_total * n_total
        u_sum_new = u_mc * n_success
        n_total = n_total + n_success
        u_mc_total = (u_sum_old + u_sum_new) / n_total
        error = abs((u_mc_total - u_true) / u_true)

print 11, n_total, u_mc_total, error
11 format (i8,e24.15,e15.6)

        n_mc = 2*n_mc   ! double number of trials for next iteration
        enddo

end program laplace_mc
        