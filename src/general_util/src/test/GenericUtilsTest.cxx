#include <iostream>
#include <string>
#include <regex>
#include <stdexcept>
#include "GenericUtilsTest.h"
// Include the header of the class being tested
#include "general_util/generic_utils.h"
// Use just one file to handle test and runner code 
#include <cppunit/ui/text/TestRunner.h>
#include <cppunit/extensions/TestFactoryRegistry.h>

#include "config.h"

// Register the test suite
CPPUNIT_TEST_SUITE_REGISTRATION(GenericUtilsTest);

// Just one place to update if the string needs changed...
const std::string TEST_NAME = "TEST_APP_NAME";

/*
Confirm :
  Creator string gets update with tool/version
  Updated Creator (with current description/version) gets returned as is.
  Updated Creator with old version , gets updated with current version.
*/


void GenericUtilsTest::setUp() {
    // Initialize resources before each test method
}

void GenericUtilsTest::tearDown() {
    // Release resources after each test method
}

// Confirm starting with a app_name (TEST_APP_NAME) , the returned string contains the ScienceTools/CMakeLIsts.txt project values
void GenericUtilsTest::testUpdatedCreatorString() {
    std::string creator_version =  GenericUtils::creator_banner(TEST_NAME);
    std::ostringstream  test_creator_string;
    test_creator_string << TEST_NAME << " " << PROJECT_DESCRIPTION << " " << PROJECT_VERSION;
    CPPUNIT_ASSERT_EQUAL(creator_version, test_creator_string.str());

/*
    std::ostringstream message_stream;
    if (creator_version.find(PROJECT_VERSION) == std::string::npos) {
       message_stream << "Did not find latest version string:  " << PROJECT_VERSION << " in string " << creator_version;
       CPPUNIT_FAIL(message_stream.str());
    }
    if (creator_version.find(PROJECT_DESCRIPTION) == std::string::npos) {
       message_stream << "Did not find latest description string:  " << PROJECT_DESCRIPTION << " in string " << creator_version;
       CPPUNIT_FAIL(message_stream.str());
    }
*/

}

// Verify if the latest description/version already exists in the CREATOR string, if the function gets called again, it still returns the same string back.
void GenericUtilsTest::testReturnsCurrentCreatorString() {
    std::string full_creator_version =  GenericUtils::creator_banner(TEST_NAME);
    std::string second_call_creator_version =  GenericUtils::creator_banner(full_creator_version);
    CPPUNIT_ASSERT_EQUAL(full_creator_version, second_call_creator_version);
}

// If the CREATOR string has an older version number, confirm that only the version number gets updated.
void GenericUtilsTest::testUpdatedCreatorStringWithNewVersion() {
    std::ostringstream test_old_version;
    test_old_version << TEST_NAME << " " << PROJECT_DESCRIPTION << " " << "1.0.0";
    std::string old_creator_version = test_old_version.str();
    std::string creator_version =  GenericUtils::creator_banner(TEST_NAME);
    CPPUNIT_ASSERT(old_creator_version != creator_version);

    // Assert version has been updated with PROJECT_VERSION
    if (creator_version.find(PROJECT_VERSION) == std::string::npos) {
       std::ostringstream message_stream;
       message_stream << "Did not find latest version string:  " << PROJECT_VERSION << " in string " << creator_version;       
       CPPUNIT_FAIL(message_stream.str());
    }
}

void GenericUtilsTest::testUpdateDescriptionInCreatorString() {
    std::ostringstream test_old_version;
    test_old_version << TEST_NAME << " " << "test description" << " " << PROJECT_VERSION;
    std::string old_creator_version = test_old_version.str();
    std::string creator_version =  GenericUtils::creator_banner(TEST_NAME);
    CPPUNIT_ASSERT(old_creator_version != creator_version);

    // Assert version has been updated with PROJECT_DESCRIPTION
    if (creator_version.find(PROJECT_DESCRIPTION) == std::string::npos) {
       std::ostringstream message_stream;
       message_stream << "Did not find latest description string:  " << PROJECT_DESCRIPTION << " in string " << creator_version;
       CPPUNIT_FAIL(message_stream.str());
    }
}



int main(int argc, char** argv) {
    CppUnit::TextUi::TestRunner runner;
    // Get the test suite from the registry and add it to the runner
    runner.addTest(CppUnit::TestFactoryRegistry::getRegistry().makeTest());
    return runner.run();
}

