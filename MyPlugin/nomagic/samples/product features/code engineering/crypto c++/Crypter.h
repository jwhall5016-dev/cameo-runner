class Crypter {
public:
	char * Encrypt( char * text );
    char * Decrypt( char * text );
    
private:
	char codeTable[3][4][4];
};