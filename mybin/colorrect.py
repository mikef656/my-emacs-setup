#!/usr/bin/python3
# based on chapter 12 of Python for Kids page174 "Setting The Color"
print("got here")
from tkinter import *
import random
tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()

#canvas.create_rectangle(10,10,300,50)
def random_rect(width,height,fill_color):
    x1 = random.randrange(width)
    y1 = random.randrange(height)
    x2 = x1 + random.randrange(width)
    y2 = y1 + random.randrange(height)
    canvas.create_rectangle(x1,y1,x2,y2, fill = fill_color )

random_rect(400,400, 'green')
random_rect(400,400, 'red')
random_rect(400,400, 'blue')
random_rect(400,400, 'orange')
random_rect(400,400, 'yellow')
random_rect(400,400, 'pink')
random_rect(400,400, 'purple')
random_rect(400,400, 'violet')
random_rect(400,400, 'magenta')
random_rect(400,400, 'cyan')
