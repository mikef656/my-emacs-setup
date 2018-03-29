#!/usr/bin/python3
# based on chapter 14 of Python for Kids 208
#  "making the paddle move p208"
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
      starts = [-3,-2,-1,1,2,3]
      random.shuffle(starts)
      self.x = starts[0]
      self.y = -3
      print(" __init__ fn setting x starting position to be",self.x)
      self.canvas_height = self.canvas.winfo_height()
      self.canvas_width  = self.canvas.winfo_width()

    def draw(self):
      self.canvas.move(self.id,self.x,self.y)
      pos = self.canvas.coords(self.id)
      print("  Ball Left   = ",pos[0])
      print("  Ball Top    = ",pos[1])
      print("  Ball Right  = ",pos[2])
      print("  Ball Bottom = ",pos[3])
      print("----------------------------------\n")
      if pos[1] <= 0:
          self.y = 3
          print("---------------------")
          print("**setting y =3")
          print("        x = %d base 10" % self.x)
          print("---------------------\n")
      if pos[3] >= self.canvas_height:
          self.y = -3
          print("**Canvas height = ",self.canvas_height)
          print("**setting y = -3")
          print("        x =",self.x)
          print("        x = %d base 10" % self.x)
      if pos[0] <= 0:
          self.x = 3
          print("**Setting x = 3")
          print("        y = %d base 10" % self.y)
      if pos[2] >= self.canvas_width:
          print("**Canvas width = ",self.canvas_width)
          self.x = -3
          print("**Setting x = -3")
          print("        y = %d base 10" % self.y)

class Paddle:
    def __init__(self,canvas,color):
      self.canvas = canvas
      self.id = canvas.create_rectangle(0,0,100,10, fill = color)
      self.canvas.move(self.id,200,300)
      self.x = 0
      self.canvas_width = self.canvas.winfo_width()
      self.canvas.bind_all('<KeyPress-Left>',self.turn_left)
      self.canvas.bind_all('<KeyPress-Right>',self.turn_right)

    def draw(self):
        self.canvas.move(self.id,self.x,0)
        pos = self.canvas.coords(self.id)
        if pos[0] <=0:
            self.x = 0
        elif pos[2] >= self.canvas_width:
            self.x = 0

    def turn_left(self,evt):
        self.x = -5

    def turn_right(self,evt):
        self.x = 5

paddle = Paddle(canvas,'blue')    
ball = Ball(canvas, 'red')

while 1:
    ball.draw()
    paddle.draw()
    print("-------- drew the ball -----------")
    tk.update_idletasks()
    tk.update()
    time.sleep(0.1)






