module mc_walk


    
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
    integer :: i, j, k, iabort
   
    ub_sum = 0.d0   ! to accumulate boundary values reached from all walks
    n_success = 0    ! to keep track of how many walks reached boundary

    do k= 1,n_mc

        call random_walk(i0, j0, max_steps,ub,iabort)
        if (iabort == 0) then 
            ! use this result unless walk didn't reach boundary
            ub_sum = ub_sum + ub
            n_success = n_success + 1
            endif
        enddo

    u_mc = ub_sum / n_success   ! average over successful walks


end subroutine many_walks


end module mc_walk