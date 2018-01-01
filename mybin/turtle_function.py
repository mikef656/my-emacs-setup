##python for kids page 153
import turtle

t =turtle.Pen()

def mycircle(red,green,blue):
    t.color(red,green,blue)
    t.begin_fill()
    t.circle(50)
    t.end_fill()

def mysquare(size):
    for x in range(1,5):
        t.forward(size)
        t.left(90)

def mysquare(size,filled):
    if filled == True:
        t.begin_fill()
    for x in range(1,5):
        t.forward(size)
        t.left(90)
    if filled == True:
        t.end_fill()

def myoctagon(size,filled):
    print("got here")
    if filled == True:
        t.begin_fill()
    for x in range(1,9):
        t.forward(size)
        t.left(45)
    if filled == True:
        t.end_fill()

def mystar(size,filled):
    if filled == True:
        t.begin_fill()
        print("begin filling")
    for x in range(1,19):
        t.forward(size)
        if x % 2 == 0:
            t.left(175)
        else:
            t.left(225)
    if filled == True:
        t.end_fill()
        print("End filling")
            

# star        
t.reset
t.color(.9,0.75,0)
mystar(120,True)
t.color(0,0,0)
mystar(120,False)

#draw octagon with border
#t.reset
t.color(1,1,1)
t.left(180)
t.forward(150)

t.color(.9,0.75,0)
myoctagon(120,True)
t.color(0,0,0)
myoctagon(120,False)

