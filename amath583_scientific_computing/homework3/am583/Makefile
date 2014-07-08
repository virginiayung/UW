# yungv_uwhpsc/homework3/am583/Makefile

OBJECTS1 = functions.o newton.o test1.o
MODULES1 = functions.mod newton.mod

OBJECTS2 = functions.o newton.o intersections.o
MODULES2 = functions.mod newton.mod


OBJECTS3 = functions.o newton_583.o test_quartic.o
MODULES3 = functions.mod newton_583.mod

FFLAGS = -g

.PHONY: test1 clean 
.PHONY: intersections clean 
.PHONY: test_quartic clean 

test1: test1.exe
	./test1.exe

test1.exe: $(MODULES1) $(OBJECTS1)
	gfortran $(FFLAGS) $(OBJECTS1) -o test1.exe

intersections: intersections.exe
	./intersections.exe

intersections.exe: $(MODULES2) $(OBJECTS2)
	gfortran $(FFLAGS) $(OBJECTS2) -o intersections.exe

test_quartic: test_quartic.exe
	./test_quartic.exe

test_quartic.exe: $(MODULES3) $(OBJECTS3)
	gfortran $(FFLAGS) $(OBJECTS3) -o test_quartic.exe

%.o : %.f90
	gfortran $(FFLAGS) -c  $< 

%.mod: %.f90
	gfortran $(FFLAGS) -c $<

clean:
	rm -f *.o *.exe *.mod

