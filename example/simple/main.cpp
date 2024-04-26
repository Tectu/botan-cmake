#include <iostream>

#include "botan_all.h"

int
main()
{
    std::string input_string = "1234";

    // SHA3-256
    auto sha3_256 = Botan::HashFunction::create_or_throw("SHA-3(256)");
    std::cout << "SHA3-256: " << Botan::hex_encode(sha3_256->process(input_string)) << std::endl;

    // SHA3-512
    auto sha3_512 = Botan::HashFunction::create_or_throw("SHA-3(512)");
    std::cout << "SHA3-512: " << Botan::hex_encode(sha3_512->process(input_string)) << std::endl;

    return 0;
}
