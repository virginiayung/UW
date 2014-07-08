module mc_walk

    use mpi
    
    use random_util, only: init_random_seed
    implicit none
    integer:: nwalks
    save


contains

subroutine random_walk(i0,j0, max_steps, ub, iabort)

    !Take one random walk starting at (i0,j0) until we reach the boundary or
    !exceed max_steps steps.
    !Return the value at the boundary point reached, or nan if we failed.
 
    use problem_description, only: nx, ny, ax, ay, dx,dy, bx, by,uboundary
    implicit none
    integer, intent(in) :: i0, j0, max_steps
    real(kind=8), intent(out) :: ub
    integer, intent(out) :: iabort
    integer :: i, j
    real(kind=8) :: xb, yb
    real(kind=8), allocatable :: r(:)
    integer :: istep
    logical :: debug

    debug = .true.


    !starting point:
    i = i0
    j = j0

    !generate as many random numbers as we could possibly need
    !for this walk, since this is much faster than generating one at a time:
    allocate (r(max_steps))
    call random_number (r)

    !if(debug) then
    !   print '("+++ generated r: ")', r
    !    endif
    

    do istep=1, max_steps
       
        !Take the next random step with equal probability in each
        ! direction:

        if (r(istep) < 0.25) then
            i = i-1   ! step left
        else if  (r(istep) < 0.5) then 
            i = i+1   ! step right
        else if (r(istep) < 0.75) then 
            j = j-1   ! step down
        else
            j = j+1   ! step up
        end if


        ! check if we hit the boundary:
        if (i*j*(nx+1-i)*(ny+1-j) == 0) then
            xb = ax + i*dx
            yb = ay + j*dy
            ub = uboundary(xb, yb)
            iabort =0
            exit
            !if (debug) then
            !   print '("Hit boundary at ", es15.9,es15.9, " after",i8," steps, ub = ",es24.16)',&
            !           xb,yb,istep,ub
            !    endif
 
            endif
        

        enddo

        if (istep==max_steps) then
            if (debug) then 
                print '("Did not hit boundary after ", i8, "steps")', max_steps
                endif
            iabort =1
            endif
        nwalks= nwalks+1
        
end subroutine random_walk


subroutine many_walks(i0, j0, max_steps, n_mc,u_mc, n_success)

    implicit none
    integer, intent(in) :: i0, j0, max_steps, n_mc
    real(kind=8) :: ub
    real(kind=8), intent(out):: u_mc
    integer, intent(out):: n_success
    real(kind=8) :: ub_sum
    integer :: i, j, k, iabort, jj, proc_num,num_procs,ierr
    integer :: numsent, sender
    integer, dimension(MPI_STATUS_SIZE) :: status
    logical :: debug

    debug =.true.

  
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPi_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)
   
    ub_sum = 0.d0   ! to accumulate boundary values reached from all walks
    n_success = 0    ! to keep track of how many walks reached boundary
    
    call MPI_BCAST(n_mc, 1, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)

!------------------------------------------------------------------
! Code for Master
!---------------------------------------------------------------------------
    if (proc_num ==0)then
        numsent =0 
        ! send the first bath out to get all workers working
       do k=1, min(num_procs-1,n_mc)
            call MPI_SEND(MPI_BOTTOM,0, MPI_DOUBLE_PRECISION, k, 1,&
                          MPI_COMM_WORLD, ierr)
            numsent=numsent+1

            enddo

       do k=1, n_mc
           call MPI_RECV(ub, 1, MPI_DOUBLE_PRECISION, MPI_ANY_SOURCE,&
                       MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
           sender = status (MPI_SOURCE)
           iabort = status(MPI_TAG)

            if (iabort == 0) then 
            ! use this result unless walk didn't reach boundary
            ub_sum = ub_sum + ub
            n_success = n_success + 1
            endif
            
            u_mc = ub_sum / n_success   ! average over successful walks
  

        if (numsent< n_mc)then
            ! still more work to, tag= 1 will be sent to workers

            call MPI_SEND(MPI_BOTTOM,0, MPI_DOUBLE_PRECISION,&
                          sender,1, MPI_COMM_WORLD, ierr)
            numsent= numsent+1
           
             !print *, "numsent= ", numsent

             else
             ! send an empty message with tag =0 to indicate this worker is
             ! done:
             call MPI_SEND(MPI_BOTTOM,0, MPI_DOUBLE_PRECISION,sender,0,&
                            MPI_COMM_WORLD, ierr)
             endif

            enddo
        endif


        !---------------------------------------------------------------------
        ! code for workers (proc:1, 2,3...):
        !---------------------------------------------------------------------
 
        if (proc_num /= 0) then
            if (proc_num > n_mc ) go to 99    !no work expected

            do while (.true.)
              ! repeat until message with tag ==0 received

                call MPI_RECV(MPI_BOTTOM, 0, MPI_INTEGER, &
                              0, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)

                j = status(MPI_TAG)   ! tag=1 or tag=0

                !if (debug) then
                !    print '("+++ Process ",i4,"  received message with tag ",i6)', &
                !             proc_num, j       ! for debugging
                !    endif

            if (j ==0) go to 99         ! received done message

            call random_walk(i0, j0, max_steps,ub, iabort)

            call MPI_SEND(ub, 1, MPI_DOUBLE_PRECISION, &
                    0, iabort, MPI_COMM_WORLD, ierr)
            enddo

          endif
    99 continue ! might jump here if finish early


end subroutine many_walks


end module mc_walk