#include "Crypter.h"
char *Crypter::Encrypt(char *text)
{
	char *str;
	int i, layer, row, col;
	str = new char[80];
	for (i=0; i<=79; i = i+1) str[i] = ' '; //blank out
	strcpy(str,text); //length of text must be less than 81
	str[strlen(text)] = ' '; //remove the terminator
	//put text into codeTable
	i = 0;
	for (layer = 0; layer <= 2; layer = layer+1)
		for (row = 0; row <= 3; row = row+1)
			for (col = 0; col <= 3; col = col+1) {
				codeTable[layer][row][col] = str[i];
				i = i+1;
			}
	
	//extract text from codeTable in the encrypted format
	i = 0;
	for (col = 0; col <= 3; col = col+1)
		for (layer = 2; layer >=0; layer = layer-1)
			for (row = 0; row <= 3; row = row+1) {
				str[i] = codeTable[layer][row][col];
				i = i+1;
			}
	str[i] = '\0'; //terminate the string
	return str;
}
char *Crypter::Decrypt(char *text)
{
	char *str;
	int i, layer, row, col;
	str = new char[80];	
	for (i=0; i<=79; i = i+1) str[i] = ' '; //blank out
	strcpy(str,text); //length of text must be less than 81
	str[strlen(text)] = ' '; //remove the terminator
	//put the (encrypted) text into codeTable
	i = 0;
	for (col = 0; col <= 3; col = col+1)
		for (layer = 2; layer >=0; layer = layer-1)
			for (row = 0; row <= 3; row = row+1) {
				codeTable[layer][row][col] = str[i];
				i = i+1;
			}
	
	//extract text from codeTable in the original,
	//decrypted format
	i = 0;
	for (layer = 0; layer <= 2; layer = layer+1)
		for (row = 0; row <= 3; row = row+1)
			for (col = 0; col <= 3; col = col+1) {
				str[i] = codeTable[layer][row][col];
				i = i+1;
			}
	str[i] = '\0'; //terminate the string
	return str;
}
