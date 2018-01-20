#!/usr/bin/python3
# based on chapter 12 of Python for Kids page182 "Displaying images"
from tkinter import *
tk = Tk()
canvas = Canvas(tk, width=400, height=400)
canvas.pack()
my_image = PhotoImage(file='C:\\Users\\family\\Desktop\\stop.gif')
canvas.create_image(0,0, anchor=NW, image=my_image)
