# https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files
#
# loop over the file, use with
with open("./temp.txt", "r") as f:
    for x in f:
        # print (x.rstrip('\n'))
        print (x,end='')


# read the file into an array
with open('temp.txt') as f:
    lines = f.readlines()
print(lines)
