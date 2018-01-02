import re

# f = open("colorrect.py","r")
f = open("c:/Users/family/AppData/Roaming/stuff/Verilog/School_Verilog_Project/div_top.v","r")
string_to_test = f.read()

# guide
# re::search returns the first match object
# re:findall returns a list of matching strings
# re:finditer returns an iterator containing match objects

y = re.findall('.*rand.*',string_to_test)

# \w matches word, 
# re.DOTALLL causes . to match newlines



# ^(\s*(\w+)\s+#)|(^\s*(\w+)\s+\w+\s*\()
z = re.finditer('random',string_to_test)

#re.M
#re.S
#my_regex = re.compile('^\s*(\w+)\s+\w+\s*\(',re.M|re.S)
#my_regex = re.compile('^\s*(\w+)\s+\w+\s*\()',re.M|re.S)
# this one is close
# my_regex = re.compile('^(\s*(\w+)\s+#)|(^\s*(\w+)\s+\w+\s*\()',re.M|re.S)
my_regex = re.compile('^\s*(\w+)\s+#|^\s*(\w+)\s+\w+\s*\(',re.M|re.S)

z = my_regex.finditer(string_to_test)

string_with_newlines = """something
someotherthing"""

# y = .match('some', string_with_newlines)

#print(z)

#print(next(z))


mylist = []

# Iterate over an interable
# The position returned by .start() seems one based in the string_to_test
# Add 1 to this position to get to the equivalant emacs point
for element in z:
  # print('group 0:', element.group(0), 'group1:',element.group(1), 'group2:',element.group(2),'group3',element.group(3), 'start0:', element.start(0), 'start1:', element.start(1), 'start2:', element.start(2), 'start3:', element.start(3))
  #print('group1:',element.group(1), 'group2:',element.group(2), 'start1:', element.start(1), 'start2:', element.start(2))
  if element.start(1) != -1:
    mylist.append(element.start(1))
  if element.start(2) != -1:
    mylist.append(element.start(2))
    #print('element not -1')
#-------------------------------------------------------------------------------
# How to add 1 to each member of a list
# https://stackoverflow.com/questions/9304408/how-to-add-an-integer-to-each-element-in-a-list
#-------------------------------------------------------------------------------
mylist_plus1 = [x+1 for x in mylist]
#print(mylist_plus1)
print(" ".join(str(x) for x in mylist_plus1))  



#-------------------------------------------------------------------------------
# This is how to read in a command line argement
#-------------------------------------------------------------------------------
import sys

# print ('Number of arguments:', len(sys.argv), 'arguments.')
# print ('Argument List:', str(sys.argv))
# print ('First Argument:', str(sys.argv[1]))
#  
# f = open(str(sys.argv[1]),"r")
# string_to_test = f.read()
# #print(string_to_test)

