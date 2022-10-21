class Rectangle:
	def __init__(self, width, height):
		self.width = width
		self.height = height
	
	def __str__(self):
		return f"Rectangle(width={self.width}, height={self.height})"

	def set_width(self,width):
		self.width = width

	def set_height(self,height):
		self.height = height
	
	def get_area(self):
		area = self.width * self.height
		return area

	def get_perimeter(self):
		perimeter = 2 * self.width + 2 * self.height
		return perimeter
	
	def get_diagonal(self):
		diagonal = (self.width ** 2 + self.height ** 2) ** .5
		return diagonal

	def get_picture(self):
		format = ""
		if self.width >= 50 or self.height >= 50:
			return  "Too big for picture."
		else:
			for i in range(self.height):
				format += "*" * self.width + "\n"
			return format

	def get_amount_inside(self,shape):
		fieldwidth = self.width
		fieldheight = self.height
		sectwidth = shape.width
		sectheight = shape.height
		countwidth = 0
		countheight = 0
		if fieldheight > sectheight:
			countheight = fieldheight // sectheight
		if fieldwidth > sectwidth:
			countwidth = fieldwidth // sectwidth
		return countwidth * countheight

class Square(Rectangle):
	def __init__(self, side):
		self.side = side
		self.width = self.height = self.side

	def __str__(self):
		return f"Square(side={self.side})"

	def set_side(self, side):
		self.side = side
		self.width = self.height = self.side

	def set_width(self, side):
		self.side = side
		self.width = self.height = self.side
	
	def sef_height(self, side):
		self.side = side
		self.width = self.height = self.side
