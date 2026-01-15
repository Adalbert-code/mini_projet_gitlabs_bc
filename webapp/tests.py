import unittest
from app import app


class AppTestCase(unittest.TestCase):
    def test_root_text(self):
        tester = app.test_client(self)
        response = tester.get('/')
        assert b'Hello world!' in response.data


if __name__ == '__main__':
    unittest.main()
