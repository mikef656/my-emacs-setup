#!/usr/bin/python3
# based on chapter 13 of Python for Kids 194
#  "Creating thte game canvas,196 Creating the ball class"
from tkinter import *
import random
import time


tk = Tk()
tk.title("Game")
tk.resizable(0, 0)
tk.wm_attributes("-topmost", 1)
canvas = Canvas(tk, width=500, height=400, bd=0, highlightthickness=0)
canvas.pack()
tk.update()

class Ball:
    def __init__(self,canvas,color):
      self.canvas = canvas
      self.id = canvas.create_oval(10,10,25,25, fill = color)
      self.canvas.move(self.id,245,100)

    def draw(self):
      pass
    
ball = Ball(canvas, 'red')

while 1:
    tk.update_idletasks()
    tk.update()
    time.sleep(0.01)






