#ifndef __CNTLR_H
#define __CNTLR_H
#include "Crypter.h"
#include "Intfcr.h"
class Controller {
public:
	Controller();
	void Encrypt(char *text);
	void Decrypt(char *text);
	void Start();
private:
	Crypter 	cp;
	Interfacer	inf;
	MessageHandler 	mh;
};
#endif
