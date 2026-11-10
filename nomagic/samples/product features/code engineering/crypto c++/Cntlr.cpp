#include "Cntlr.h"
Controller::Controller()
{
	inf.Init(50,50,600,300);
	inf.SetOkLabel("Encrypt");
	inf.SetCancelLabel("Decrypt");
	inf.SetOwner(this);
}
void Controller::Start()
{
	mh.Start();
}
void Controller::Encrypt(char *text)
{
	char encryptedText[80];
	strcpy(encryptedText, cp.Encrypt(text));
	inf.Display(encryptedText);
}
void Controller::Decrypt(char *text)
{
	char originalText[80];
	strcpy(originalText, cp.Decrypt(text));
	inf.Display(originalText);
}
