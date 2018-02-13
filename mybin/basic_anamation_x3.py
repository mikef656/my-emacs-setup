#!/usr/bin/python3
# based on chapter 12 of Python for Kids page183 "Creating Basic Animation"
import time
from tkinter import *

tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
canvas.create_polygon(10,10,10,60,50,35)
for x in range(0,60):
  canvas.move(1,5,0)
  tk.update()
  time.sleep(0.05)

# Create a new Tk window object
tk_2 = Tk()
# figured out how set the size and position of the window here
# https://stackoverflow.com/questions/14910858/how-to-specify-where-a-tkinter-window-opens
tk_2.geometry('500x500+400+400')
canvus = Canvas(tk_2, width=400, height=400)
canvus.pack()
canvus.create_polygon(10,10,10,60,50,35)
for x in range(0,60):
  canvus.move(1,5,0)
  tk_2.update()
  time.sleep(0.05)

# Create a new Tk window object
tk_3 = Tk()
# figured out how set the size and position of the window here
# https://stackoverflow.com/questions/14910858/how-to-specify-where-a-tkinter-window-opens
tk_3.geometry('500x500+600+600')
canvus = Canvas(tk_3, width=400, height=400)
canvus.pack()
canvus.create_polygon(10,10,10,60,50,35)
for x in range(0,60):
  canvus.move(1,5,0)
  tk_3.update()
  time.sleep(0.05)
