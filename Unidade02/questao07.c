#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>

int main(int argc, char const *argv[])
{
	
	if (argc < 2)
	{
		printf("Digite na forma: %s <n><número de dias>\n",argv[0] );
		return 1;
	}

	setuid(0);
	char buf[100];
	sprintf(buf, "bash questao07.sh %s", argv[1]);
	system(buf);
	return 0;
}
