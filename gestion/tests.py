from django.test import TestCase


class SimpleTest(TestCase):
    def test_example(self):
        """A very simple test to make sure the test runner works."""
        self.assertEqual(1 + 1, 2)
