print ("My first Python code!")

def someFunction(a, b):
 print(a+b)

someFunction(12,451)  


# example of opening file, using with

with open("./temp.txt", "r") as f:
    for x in f:
        print (x)
