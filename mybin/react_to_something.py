#!/usr/bin/python3
# based on chapter 12 of Python for Kids 186 "Making an object react to something"
import time
from tkinter import *

def movetriangle(event):
    canvas.move(1,5,0)

tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
canvas.create_polygon(10,10,10,60,50,35)

canvas.bind_all('<KeyPress-Return>',movetriangle)



