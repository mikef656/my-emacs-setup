#!/usr/bin/python3
# based on chapter 12 of Python for Kids page184 - 186 "Creating Basic Animation"
import time
from tkinter import *

tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
canvas.create_polygon(10,10,10,60,50,35)

for y in range(0,2):
  print("Outer loop index =",y)
  for x in range(0,60):
    canvas.move(1,5,5)
    tk.update()
    time.sleep(0.05)


  for x in range(0,60):
    canvas.move(1,-5,-5)
    tk.update()
    time.sleep(0.05)

