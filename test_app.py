from app import add

def test_add():
    assert add(2, 3) == 5

def test_add_again():
    assert add(-7, 3) == -4

def test_add_once_again():
    assert add(3, 3) == 6
