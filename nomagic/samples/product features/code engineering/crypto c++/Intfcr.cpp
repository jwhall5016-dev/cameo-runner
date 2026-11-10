#include "Cntlr.h"
#include "Intfcr.h"
void Interfacer::SetOwner(Controller *c)
{
	owner = c;
}
void Interfacer::Ok()
{
	owner->Encrypt(ReadAll());
}
void Interfacer::Cancel()
{
	owner->Decrypt(ReadAll());
}
void Interfacer::Display(char *text)
{
	Clear();
	Insert(0,0,text);
}
