#1. You are given time in 12-hour format.convert it to 24-hour format.
#Input: 08:55:48 PM Output: 20:55:48

def convert24(str1):
    if str1[-2:] == "AM" and str1[:2] == "12":
        return "00" + str1[2:-2]
    elif str1[-2:] == "AM":
        return str1[:-2]
    elif str1[-2:]=="PM" and str1[:2]=="12":
        return str1[:-2]
    else:
        return str(int(str1[:2])+12)+str1[2:8]
if __name__ == "__main__":
    str1 = str(input())
    print(convert24(str1))

# 2. John and Sean went to a shop to buy chocolates. John doesn't buy the 
# chocolates that Sean does. Consider there are N no. of chocolates & 
# they have Rs.M . Given the list of prices of chocolates, choose the ones
# that will cost all the money they have(assuming there are 2 chocolates
# that cost the total of M). Considering 1-based indexing, print which 2 chocolates
# they bought.
# Input: 6 (N)
#        12(M)

#        1 5 7 12 16 23 (Price of N chocolates)
# Output: 2 3 

#function
exact_sum = []
def func(M,N):
    items_to_buy = True
    while items_to_buy:
        i=0
        n=1
        for i in range(0,len(N)):
            #print(i)
            for n in range(1, len(N)):
                #print(n)
                if N[i] + N[n]== M:
                    exact_sum.extend([i+1,n+1])
                    #print(exact_sum)
                    n+=1
                    i+=1
                #else:
                    #print("not working, God knows why!!")
        items_to_buy = False
    print(set(exact_sum))

if __name__ == "__main__":    
    #get M 
    M = int(input("Total Rs. you have on you: "))
    #get N
    # creating an empty list
    lst = []  
    # number of elemetns as input
    n = int(input("Enter number of elements : "))  
    # iterating till the range
    for i in range(0, n):
        ele = int(input())  
        lst.append(ele) # adding the element      
    #print(lst)

func(M,lst)

# 3. Sam and John decoded to have a competition. They wrote 'N' no. of tests.
# For whoever scores more will be given 1 point. If both scored the same marks,
# no point is awarded. Sam's marks are entered 1st followed by John's.
# Calculate who got how many points. The output should display tehir names and
# no. of points each got followed by who won the competition.

# Input: 5(N)
#        45 78 33 97 13 (Sam's Marks)
#        66 89 23 97 54 (John's Marks)

# Output: Sam 1
#         John 3
#         John won the competition

#function
def func2(S,J):
    i=0
    s=0
    j=0
    if len(S)==len(J):
        for i in range(0,len(S)):
            if S[i] > J[i]:
                s+=1
            elif J[i] > S[i]:
                j+=1
            #else:
                #print("Draw! No points rewarded")
            i+=1
    else:
        print("No. of tests not equal!")
        
    print("Sam: ",s)
    print("John: ",j)
    if s>j:
        print("Sam won the competition")
    elif j>s:
        print("John won the competition")
    else:
        print("DRAW!")

if __name__ == "__main__":
    #Sam list
    # creating an empty list
    lst1 = []  
    # number of elemetns as input
    n1 = int(input("Enter number of elements : ")) 
    # iterating till the range
    for r in range(0, n1):
        ele1 = int(input())
    
        lst1.append(ele1) # adding the element     
    print(lst1)

    #John list
    # creating an empty list
    lst2 = [] 
    # number of elemetns as input
    n2 = int(input("Enter number of elements : "))  
    # iterating till the range
    for q in range(0, n2):
        ele2 = int(input())
    
        lst2.append(ele2) # adding the element     
    print(lst2)

func2(lst1,lst2)

# 4. You are given no. of words followed by the list of words. 
# For each word, print the word, its length & number of its occurences.
# Input: 5(No. of words)
#        New Old Existing New New (list of words)
# Output: New 3 3        (word length occurences)
#         Old 3 1
#         Existing 8 1
if __name__ == "__main__":
    #create list
    # creating an empty list
    lst = [] 
    # number of elemetns as input
    n = int(input("Enter number of elements : "))  
    # iterating till the range
    for i in range(0, n):
        ele = str(input())  
        lst.append(ele) # adding the element      
    print(lst)

#function
def word_count(list_of_words):
    counts = dict()
    word_list = [word.capitalize() for word in list_of_words]
    word_list = [word.strip() for word in word_list]

    for word in word_list:
        if word in counts:
            counts[word] += 1
        else:
            counts[word] = 1

    #print(counts)
    keys = list(counts.keys())
    values = list(counts.values())
    for i in range(0,len(keys)):
        print(keys[i] ,len(keys[i]) ,values[i])
        
word_count(lst)

# 5. You are given a list of 'N' books and their details(no. of pages, 
# price and no. of chapters). Display the list of attributes and ask the user
# to select 1 attribute. You are required to sort the data based on the attribute 
# selected by the user and print the final resulting table.
# Input: 3(N)
#        500 250 22(Book1)  (No. of pages, price, no. of chapters)
#        148 55 10 (Book2)
#        207 199 31(Book3)
#        2 (Attribute)
# Output: 148 55 10 
#         207 199 31
#         500 250 22

import numpy as np
#get the book-attribute(R-C) matrix
N = int(input("Enter the number of books:"))
C = int(input("Enter the number of attributes:"))

def func4(N,C):
    # Initialize matrix
    matrix = []
    print("Enter the entries rowwise:")

    # For user input
    for i in range(N):          # A for loop for row entries
        a =[]
        for j in range(C):      # A for loop for column entries
             a.append(int(input()))
        matrix.append(a)

    # For printing the matrix
    for i in range(N):
        for j in range(C):
            print(matrix[i][j], end = " ")
        print()

#function to sort the matrix by a given attributes
def func5(matrix):
    a = np.array(matrix)
    i=int(input("Enter the attribute no. you want sort by: ")) - 1
    print(a[a[:,i].argsort()])
    

func4(N,C)
func5(matrix)




# 6. You are given a sentence containing alphabets, numbers, symbols&spaces.
# Your task is to sort the string in the following order and each separated by space:
# a. Symbols
# b. lowercase letters
# c. uppercase letters
# d. odd digits
# e. even digits
# f. no. of spaces

#Input: 131/265 is where I and Sam Live.
#Output: /. iswhereandamive ISL 1315 26 6
def func6(a_string):
    the_output_string = []
    #symbols
    res1 = list(filter(lambda c: not c.isalpha() and not c.isdigit(), a_string))
    syms = []
    for i in res1:
        if i!=' ' and i!='':
            syms.append(i)
    all_symbols = ''.join(syms)
    the_output_string.append(all_symbols)
    #lowercase_letters
    res2 = list(filter(lambda c: c.islower(), a_string))
    lower_alpha = ''.join(res2)
    the_output_string.append(lower_alpha)
    #uppercase letters
    res3 = list(filter(lambda c: c.isupper(), a_string))
    upper_alpha = ''.join(res3)
    the_output_string.append(upper_alpha)
    #digits
    res4 = list(filter(lambda c: c.isdigit(), a_string))
    #odddigits
    res6 = list(filter(lambda c: int(c)%2!=0, res4))
    odd_digits = ''.join(res6)
    the_output_string.append(odd_digits)
    #evendigits
    res5 = list(filter(lambda c: int(c)%2==0, res4))
    even_digits = ''.join(res5)
    the_output_string.append(even_digits)
    #no. of white spaces in the string
    n_whitespace = str(a_string.count(" "))
    the_output_string.append(n_whitespace)

    print(" ".join(str(x) for x in the_output_string))
    
if __name__ == "__main__":
    a_string = str(input("Enter the string: "))

func6(a_string)
