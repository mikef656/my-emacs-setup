# based on chapter 12 of Python for Kids page173 "Drawing a lot of Rectangles"
from tkinter import *
import random
tk = Tk()
canvas = Canvas(tk, width=500, height=500)
canvas.pack()
canvas.pack()

#canvas.create_rectangle(10,10,300,50)
def random_rect(width,height):
    x1 = random.randrange(width)
    y1 = random.randrange(height)
    x2 = x1 + random.randrange(width)
    y2 = y1 + random.randrange(height)
    canvas.create_rectangle(x1,y1,x2,y2)

for x in range(0,100):
    random_rect(400,400)
