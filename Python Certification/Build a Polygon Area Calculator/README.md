# Build a Polygon Area Calculator

In this project, you will use object-oriented programming to create a `Rectangle` class and a `Square` class. The `Square` class should be a subclass of `Rectangle` and inherit its methods and attributes.

**Objective:** Fulfill the user stories below and get all the tests to pass to complete the lab.

**User Stories:**

1.  You should create a `Rectangle` class.
2.  When a `Rectangle` object is created, it should be initialized with `width` and `height` attributes. The class should also contain the following methods:

    -   `set_width`: Sets the width of the rectangle.
    -   `set_height`: Sets the height of the rectangle.
    -   `get_area`: Returns area (\\( \\text{width} \\times \\text{height} \\)).
    -   `get_perimeter`: Returns perimeter \\( 2(\\text{width} + \\text{height}) \\).
    -   `get_diagonal`: Returns diagonal \\( \\sqrt{\\text{width}^2 + \\text{height}^2} \\).
    -   `get_picture`: Returns a string that represents the shape using lines of `*`. The number of lines should be equal to the height and the number of `*` in each line should be equal to the width. There should be a new line (`\n`) at the end of each line. If the width or height is larger than `50`, this should return the string: `Too big for picture.`.
    -   `get_amount_inside`: Takes another shape (square or rectangle) as an argument. Returns the number of times the passed in shape could fit inside the shape (with no rotations). For instance, a rectangle with a width of `4` and a height of `8` could fit in two squares with sides of `4`.

3.  If an instance of a `Rectangle` is represented as a string, it should look like: `Rectangle(width=5, height=10)`.
4.  You should create a `Square` class that subclasses `Rectangle`.
5.  When a `Square` object is created, it should be initialized with a single side length. The `__init__` method should store the side length in both the `width` and `height` attributes from the `Rectangle` class.
6.  The `Square` class should contain the following methods:

    -   `set_width`: Overrides the `set_width` method from the `Rectangle` class. It should set the width and height to the side length.
    -   `set_height`: Overrides the `set_height` method from the `Rectangle` class. It should set the width and height to the side length.
    -   `set_side`: Sets the height and width of the square equal to the side length.

7.  The `Square` class should be able to access the `Rectangle` class methods.
8.  If an instance of a `Square` is represented as a string, it should look like: `Square(side=9)`.

## Usage example

Example Code

    rect = Rectangle(10, 5)
    print(rect.get_area())
    rect.set_height(3)
    print(rect.get_perimeter())
    print(rect)
    print(rect.get_picture())

    sq = Square(9)
    print(sq.get_area())
    sq.set_side(4)
    print(sq.get_diagonal())
    print(sq)
    print(sq.get_picture())

    rect.set_height(8)
    rect.set_width(16)
    print(rect.get_amount_inside(sq))

That code should return:

Example Code

    50
    26
    Rectangle(width=10, height=3)
    **********
    **********
    **********

    81
    5.656854249492381
    Square(side=4)
    ****
    ****
    ****
    ****

    8
