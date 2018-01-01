def hello():
    print('hello there')

def person(width,height):
    print('I am %s feet wide, %s feet high' %(width, height))

from tkinter import *
tk = Tk()
btn = Button(tk, text="click me",command=hello)
btn.pack()

person(height=3, width =4)
