#!/usr/bin/python3
# based on chapter 12 of Python for Kids 187-188
#  "Making an object react to something, 2nd part"
import time
from tkinter import *
tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
canvas.create_polygon(10,10,10,60,50,35)
def movetriangle(event):
    if event.keysym == 'Up':
        print("up")
        canvas.move(1,0,-3)
    elif event.keysym == 'Down':
        print("down")
        canvas.move(1,0,3)
    elif event.keysym == 'Left':
        print("left")
        canvas.move(1,-3,0)
    else:
        canvas.move(1,3,0)
        print("right")
        
canvas.bind_all('<KeyPress-Up>',movetriangle)
canvas.bind_all('<KeyPress-Down>',movetriangle)
canvas.bind_all('<KeyPress-Left>',movetriangle)
canvas.bind_all('<KeyPress-Right>',movetriangle)






