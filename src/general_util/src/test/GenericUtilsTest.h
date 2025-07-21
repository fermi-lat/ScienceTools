#ifndef GENERICUTILS_TEST_H
#define GENERICUTILS_TEST_H

#include <cppunit/extensions/HelperMacros.h>

// Forward declaration of the class being tested (optional, but good practice)
class GenericUtils; 

class GenericUtilsTest : public CppUnit::TestFixture {
public:
    // Declare setup and teardown methods
    void setUp();
    void tearDown();

    // Declare test methods
    void testUpdatedCreatorString();
    void testReturnsCurrentCreatorString();
    void testUpdatedCreatorStringWithNewVersion();
    void testUpdateDescriptionInCreatorString();

    // Register the test suite
    CPPUNIT_TEST_SUITE(GenericUtilsTest);
    CPPUNIT_TEST(testUpdatedCreatorString);
    CPPUNIT_TEST(testReturnsCurrentCreatorString);
    CPPUNIT_TEST(testUpdatedCreatorStringWithNewVersion);
    CPPUNIT_TEST(testUpdateDescriptionInCreatorString);
    CPPUNIT_TEST_SUITE_END();
};

#endif // GENERICUTILS_TEST_H

