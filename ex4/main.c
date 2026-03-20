#include <stdio.h>

extern int szukaj_max(int x, int y, int z);
extern int szukaj4_max(int a, int b, int c, int d);
extern void liczba_przeciwna(int* n);
extern void odejmij_jeden(int** a);
extern void przestaw(int* tab, int n);
extern int mediana(int* tab, int n);
extern void bezwzglednij(int* tab, int n);

int main()
{
	int n = 4;
	int tab[] = {-12, -48, 3, 270, 2 };
	
	bezwzglednij(tab, n);
	for (int i = 0; i < n - 1; i++)
	{
		przestaw(tab, n - i);
	}
	int x = mediana(tab, n);
	printf_s("%i\n", x);
	

	return 0;
}