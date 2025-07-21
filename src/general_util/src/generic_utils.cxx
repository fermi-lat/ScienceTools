#include "general_util/generic_utils.h"
#include <string>
#include <sstream>
#include <iostream>
#include "config.h"

std::string GenericUtils::creator_banner(const std::string  creator)  {
    // preset to existing creator string, will return this string if it's already been updated with tool/same version
    std::string creator_string = creator;
    // New version of creator string
    std::ostringstream creator_version;

    if (creator.find(PROJECT_VERSION) == std::string::npos) {
       creator_version << creator << " " << PROJECT_DESCRIPTION << " " << PROJECT_VERSION;
       creator_string = creator_version.str();
       std::cout << "Creator banner set to " << creator_string << std::endl; 
    }
    return creator_string;
}
