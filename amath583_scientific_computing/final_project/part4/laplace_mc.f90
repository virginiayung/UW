! MAIN PROGRAM Part 4
program laplace_mc

    use mpi

    use mc_walk, only: random_walk, many_walks, nwalks
    use problem_description, only: nx, ny, dx, dy,ax, ay,bx,by,utrue,uboundary
    use random_util, only : init_random_seed

    implicit none
    real(kind=8) :: x0, y0
    real(kind=8) :: u_true, u_mc, error, ub
    real(kind=8) :: u_mc_total, u_sum_old, u_sum_new
    integer :: i, j, i0, j0,max_steps, n_mc, seed1 
    integer :: n_success, n_total
    integer :: n_proc, proc_num, num_procs, ierr, numsent
    integer, dimension(MPI_STATUS_SIZE) :: status
    integer :: iabort
    logical :: debug

    debug =.true.

            
    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPi_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

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
   

    seed1 = 12345                ! or set to 0 for random seed
    seed1 = seed1 + 97*proc_num  ! unique for each process
    call init_random_seed(seed1) 

    print *, "seed1 for random number generator:", seed1 

    ! maximum number of step in each before giving up:
    max_steps = 100*max(nx, ny)

    if (proc_num==0)then
       ! initial number of Monte-Carlo walks to take and sends them to each worker
       !print *, "True solution:  ", u_true
       n_mc = 10
       endif

     call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)
     error = abs((u_mc - u_true) / u_true)

     print 10, n_success, u_mc, error
10 format (i8,e24.15,e15.6)
     !start accumulating totals:
      u_mc_total = u_mc
      n_total = n_success
     !print*, "proc_num= ", proc_num

    do i=1,12
        call many_walks(i0, j0, max_steps, n_mc, u_mc, n_success)
        u_sum_old = u_mc_total * n_total
        u_sum_new = u_mc * n_success
        n_total = n_total + n_success
        if (proc_num==0)then
            u_mc_total = (u_sum_old + u_sum_new) / n_total
            error = abs((u_mc_total - u_true) / u_true)

            print 11, n_total, u_mc_total, error
11 format (i8,e24.15,e15.6)

            endif
         
        n_mc = 2*n_mc   ! double number of trials for next iteration
        !print*, "proc_num= ", proc_num
        
        enddo


    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for all process to print

    ! print the number of function evaluations by each thread:
    print '("walks by Process ",i2,": ",i13)',  proc_num, nwalks

    call MPI_BARRIER(MPI_COMM_WORLD,ierr) ! wait for all process to print

    call MPI_REDUCE(nwalks, n_total, 1, MPI_INTEGER, MPI_SUM, 0, &
                    MPI_COMM_WORLD, ierr)

    if (proc_num==0) then
        
        print '("Total walks performed by all processes: ",i10)', n_total
        print '("Final approximation to u(x0,y0):  ",es22.14)',u_mc_total
        endif

    call MPI_FINALIZE(ierr)

end program laplace_mc







    



        