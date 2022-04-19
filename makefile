gcc_Sopt = -lc -m64 -c -g
all: lab7.zip readrec

lab7.zip: main.s readlines.s printlines.s
	zip lab7.zip main.s readlines.s printlines.s

readrec: main.o readlines.o printlines.o
	gcc main.o readlines.o printlines.o -o readrec 

main.o: main.s
	gcc $(gcc_Sopt) main.s
readlines.o: readlines.s
	gcc $(gcc_Sopt) readlines.s
printlines.o: printlines.s
	gcc $(gcc_Sopt) printlines.s

clean:
	rm -rf *.o readrec lab7.zip



