#include "general_util/generic_utils.h"
#include <string>
#include <sstream>
#include <iostream>
#include "config.h"

// Grabs PROJECT_DESCRIPTION and PROJECT_VERSION from ScienceTools/CMakeLists.txt Project tuple.
std::string GenericUtils::creator_banner(const std::string  creator)  {
    // preset to existing creator string, will return this string if it's already been updated with tool/same version
    std::string creator_string = creator;
    // Create new version of creator string
    std::ostringstream creator_version;

    // If the current version number or description isn't found, update the CREATOR string with the latest PROJECT_DESCRIPTION/PROJECT_VERSION.
    if (creator.find(PROJECT_VERSION) == std::string::npos && creator.find(PROJECT_DESCRIPTION) == std::string::npos) {
       creator_version << creator << " " << PROJECT_DESCRIPTION << " " << PROJECT_VERSION;
       creator_string = creator_version.str();
    }
    return creator_string;
}
