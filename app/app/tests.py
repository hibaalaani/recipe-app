from django.test import SimpleTestCase
from app import calc
     # noqa   
class CalcTest(SimpleTestCase):
    def test_add_numbers(self):
        """Test adding two numbers together"""
        res = calc.add(5,6)
        self.assertEqual(res , 11)
        
    def test_sub_numbers(self):
        """Test the sub""" 
        res = calc.sub(10,15)
        self.assertEqual(res,5)   