#ifndef __INTFCR_H
#define __INTFCR_H
class Controller; //forward reference
class Interfacer: public EditWin {
public:
	void Ok( );
	void Cancel( );
	void Display( char * text );
	void SetOwner( Controller * c );
private:
	Controller * owner;
};
#endif
