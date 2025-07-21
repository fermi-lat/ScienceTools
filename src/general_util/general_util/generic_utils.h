#pragma once // Ensures the header is included only once
#include <string>

class GenericUtils {
public:
    // method that will build the creator value used to put in the fits file HEADER section
    static std::string creator_banner(const std::string creator);
};
