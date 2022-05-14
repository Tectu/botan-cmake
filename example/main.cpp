#include <iostream>


//#include "botan_all.h"

int main() {
    std::cout << "Hello, World!" << std::endl;

#if 0
    std::string password = "1234";
    std::string hash = "alsjfaklsfjlkasjf2";

    return Botan::argon2_check_pwhash(
            password.data(),
            password.size(),
            std::string{hash}
    );
#endif

    return 0;
}
