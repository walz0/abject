"C:\Users\aidan\gbdk\bin\lcc.exe" -Wa-l -Wl-m -Wl-j -c -o sprites.o sprites/*
"C:\Users\aidan\gbdk\bin\lcc.exe" -Wa-l -Wl-m -Wl-j -c -o main.o main.c
"C:\Users\aidan\gbdk\bin\lcc.exe" -Wa-l -Wl-m -Wl-j -Wl-yp0x143=0x80 -o main.gb *.o