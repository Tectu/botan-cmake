#include <iostream>

#include "botan_all.h"

int
main()
{
    std::string input_string = "1234";

    // SHA3-256
    Botan::SHA_3 sha3_256(256);
    std::cout << "SHA3-256: " << Botan::hex_encode(sha3_256.process(input_string)) << std::endl;

    // SHA3-512
    Botan::SHA_3 sha3_512(512);
    std::cout << "SHA3-512: " << Botan::hex_encode(sha3_512.process(input_string)) << std::endl;

    return 0;
}
