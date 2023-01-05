import unittest
# import requests

from app import Square, Cub

# class Test(unittest.TestCase):

#     def test1(self):
#         resp = requests.get("http://127.0.0.1:5000/")
#         self.assertEqual(resp.status_code, 200)
#         print("test1: OK")
    
#     def test2(self):
#         resp = requests.get("http://127.0.0.1:5000/")
#         self.assertEqual(resp.status_code, 200)
#         print("test3: OK")

#     def test3(self):
#         resp = requests.get("http://127.0.0.1:5000/show_building/1")
#         self.assertEqual(resp.status_code, 200)
#         print("test4: OK")
    
#     def test4(self):
#         resp = requests.get("http://127.0.0.1:5000/show_building/1")
#         self.assertEqual(resp.status_code, 200)
#         print("test4: OK")

class TestSquare(unittest.TestCase):
    
    def test_area(self):
        self.assertEqual(Square(7,4).area, 28)
        print("test_area: OK")

class TestCub(unittest.TestCase):
    
    def test_volume(self):
        self.assertEqual(Cub(7,4,3).volume, 84)
        print("test_volume: OK")

       


if __name__ == '__main__':
    # tester = Test()
    # tester.test1()
    # tester.test2()
    # tester.test3()
    # tester.test4()

    tester1 = TestSquare()
    tester1.test_area()

    tester2 = TestCub()
    tester2.test_volume()
    