import os
from datetime import datetime
import unittest
from update_template_creator.py import update_creator_line, update_creator_in_templates

class TestMyScript(unittest.TestCase):

    def rename_file_with_date(filename: str) -> str:
        """
        Renames a file by appending the current date in mmddyy format before the extension.

        Args:
            filename (str): The original filename (e.g., "sample.tpl").

        Returns:
            str: The new filename (e.g., "sample.tpl.071725") or None if the file doesn't exist.
        """
        if not os.path.exists(filename):
            print(f"Error: File '{filename}' not found.")
            return None

        # Get the current date in mmddyy format
        current_date = datetime.now().strftime("%m%d%y")

        # Split the filename into base and extension
        base_name, extension = os.path.splitext(filename)

        # Create the new filename
        new_filename = f"{base_name}.{extension}.{current_date}"

        try:
            os.rename(filename, new_filename)
            print(f"File '{filename}' renamed to '{new_filename}' successfully.")
            return new_filename
        except OSError as e:
            print(f"Error renaming file: {e}")
            return None

    @classmethod
    def setUpClass(cls):
        # cls.shared_resource = random.randint(1, 100)
        cls.original_test_file = "./creator_sample.tpl"        
        cls.test_template = rename_file_with_date(cls.original_test_file)
        cls.TEST_NAME = "TEST_APP_NAME"
        cls.project_description = os.environ.get('PY_PROJECT_DESCRIPTION')
        cls.project_version = os.environ.get('PY_PROJECT_VERSION')

    @classmethod
    def tearDownClass(cls):
        if os.path.exists(cls.test_template):
           try:
              os.remove(cls.test_template)
              print(f"File '{cls.test_template}' deleted successfully.")
           except PermissionError:
              print(f"Permission denied to delete the file '{file_to_delete}'.")
           except Exception as e:
              print(f"An unexpected error occurred: {e}")
        else:
           print(f"File '{file_to_delete}' does not exist.")

    # def update_creator_line(filename, description, version):
    def testUpdatedCreatorString(self):
        ### cls.test_template    
        creator_version = update_creator_line(cls.test_template, self.project_description, self.project_version) 
        test_creator_string = f"{cls.TEST_NAME} {cls.project_description} {cls.project_version}"
        self.assertEqual(creator_version, test_creator_string, f" Strings {creator_version} {test_creator_string} are expected to be equal" ) 
        # self.assertNotEqual(string1, string2, "Strings should not be equal")

        """
        std::string creator_version =  GenericUtils::creator_banner(TEST_NAME);
        std::ostringstream  test_creator_string;
        test_creator_string << TEST_NAME << " " << PROJECT_DESCRIPTION << " " << PROJECT_VERSION;
        CPPUNIT_ASSERT_EQUAL(creator_version, test_creator_string.str());
        """

    def testReturnsCurrentCreatorString(self):
        creator_version = update_creator_line(cls.test_template, self.project_description, self.project_version)


        """
        std::string full_creator_version =  GenericUtils::creator_banner(TEST_NAME);
        std::string second_call_creator_version =  GenericUtils::creator_banner(full_creator_version);
        CPPUNIT_ASSERT_EQUAL(full_creator_version, second_call_creator_version);
        """


    # def testUpdatedCreatorStringWithNewVersion(self):
    # def testUpdateDescriptionInCreatorString(self):
    # def update_creator_in_templates(paths_file, description, version ):

    # self.assertEqual(subtract_numbers(0, 5), -5)

if __name__ == "__main__":
    unittest.main()

