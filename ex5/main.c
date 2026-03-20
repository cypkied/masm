#include <stdio.h>

double wariancja(double tablica_dane[], unsigned int n);

int main()
{
	double tab[4] = { 2.0f, 3.0f, 6.0f, 7.0f };
	unsigned int n = 4;
	
	printf("%f\n", wariancja(tab, n));

	return 0;
}