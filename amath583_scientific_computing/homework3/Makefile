# yungv_uwhpsc/homework3/Makefile

OBJECTS1 = functions.o newton.o test1.o
MODULES1 = functions.mod newton.mod

OBJECTS2 = functions.o newton.o intersections.o
MODULES2 = functions.mod newton.mod


FFLAGS = -g

.PHONY: test1 clean 
.PHONY: intersections clean 


test1: test1.exe
	./test1.exe

test1.exe: $(MODULES1) $(OBJECTS1)
	gfortran $(FFLAGS) $(OBJECTS1) -o test1.exe

intersections: intersections.exe
	./intersections.exe

intersections.exe: $(MODULES2) $(OBJECTS2)
	gfortran $(FFLAGS) $(OBJECTS2) -o intersections.exe


%.o : %.f90
	gfortran $(FFLAGS) -c  $< 

%.mod: %.f90
	gfortran $(FFLAGS) -c $<

clean:
	rm -f *.o *.exe *.mod

