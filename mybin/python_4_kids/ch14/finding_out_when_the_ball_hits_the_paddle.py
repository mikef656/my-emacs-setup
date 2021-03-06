#!/usr/bin/python3
# based on chapter 14 of Python for Kids
#  "finding out when the ball hits the paddle p210"
from tkinter import *
import random
import time

from playsound import playsound

TEXT_COLOR = 'green'
    
tk = Tk()
tk.title("Game")
tk.resizable(0, 0)
tk.wm_attributes("-topmost", 1)
canvas = Canvas(tk, width=500, height=400, bd=0, highlightthickness=0)
canvas.pack()
tk.update()
playsound('C:/Users/family/Downloads/Kid_Laugh.mp3',False)

class Ball:
    def __init__(self,canvas,paddle,color):
      self.canvas = canvas
      self.paddle = paddle
      self.id = canvas.create_oval(10,10,25,25, fill = color)
      self.canvas.move(self.id,245,100)
      starts = [-3,-2,-1,1,2,3]
      random.shuffle(starts)
      self.x = starts[0]
      self.y = -3
      print(" __init__ fn setting x starting position to be",self.x)
      self.canvas_height = self.canvas.winfo_height()
      self.canvas_width  = self.canvas.winfo_width()
      self.hit_paddle_count = 0
      self.paddle_count_handle = canvas.create_text(180,20,text=str(0),font=('Courier',8),fill=TEXT_COLOR)

    def hit_paddle(self,pos):
        paddle_pos = self.canvas.coords(self.paddle.id)
        if pos[2] >= paddle_pos[0] and pos[0] <= paddle_pos[2]:
            if pos[3] >= paddle_pos[1] and pos[3] <= paddle_pos[3]:
                #https://pypi.org/project/playsound/1.2.1/
                # the 2nd arg causes the playsound not to block
                playsound('C:/Users/family/Downloads/Pew_Pew.mp3',False)
                return True
        return False
    
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
          #ball hits bottom
          self.y = -3
          #playsound('C:/Users/family/Downloads/Cow_Moo.mp3',False)
          #playsound('C:/Users/family/Downloads/mburger.mp3',False)
          #playsound('C:/Users/family/Downloads/swvader01.mp3',False)
          #playsound('C:/Users/family/Downloads/poop2mch.mp3',False)
          #playsound('C:/Users/family/Downloads/aallrighty.mp3',False)
          playsound('C:/Users/family/Downloads/blaster-firing.mp3',False)
          #
          print("**Canvas height = ",self.canvas_height)
          print("**setting y = -3")
          print("        x =",self.x)
          print("        x = %d base 10" % self.x)
      if self.hit_paddle(pos) == True:
          self.y = -3
          self.hit_paddle_count = self.hit_paddle_count +1
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

paddle = Paddle(canvas,'dark green')    
ball = Ball(canvas, paddle, 'navy blue')

while 1:
    ball.draw()
    paddle.draw()
    print("-------- drew the ball -----------")
    tk.update_idletasks()
    tk.update()
    #------------------------------------------------------------------------
    # Add this line to update the text on the screen dynamically
    #------------------------------------------------------------------------    
    canvas.itemconfigure(ball.paddle_count_handle ,text="Hit Paddle Score = {}".format(ball.hit_paddle_count),font=('Courier',20),)    
    time.sleep(0.001)






