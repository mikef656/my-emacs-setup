#!/usr/bin/python3
# based on chapter 12 of Python for Kids 189
# Added changing different colors and an outline based on key bindings (arrows)
#  "More ways to use the identifier"
import time
from tkinter import *
tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
mytriangle = canvas.create_polygon(10,10,10,60,50,35,fill='red')
def movetriangle(event):
    if event.keysym == 'Up':
        print("up")
        canvas.itemconfig(mytriangle,outline='red')
        canvas.itemconfig(mytriangle,fill='blue')
        canvas.move(mytriangle,0,-3)
    elif event.keysym == 'Down':
        print("down")
        canvas.itemconfig(mytriangle,fill='green')
        canvas.move(mytriangle,0,3)
    elif event.keysym == 'Left':
        print("left")
        canvas.itemconfig(mytriangle,fill='yellow')
        canvas.move(mytriangle,-3,0)
    else:
        canvas.itemconfig(mytriangle,fill='orange')
        canvas.move(mytriangle,3,0)
        print("right")
        
canvas.bind_all('<KeyPress-Up>',movetriangle)
canvas.bind_all('<KeyPress-Down>',movetriangle)
canvas.bind_all('<KeyPress-Left>',movetriangle)
canvas.bind_all('<KeyPress-Right>',movetriangle)






