import re

def arithmetic_arranger(problems,flag=False):
  #init some variabels
  first =""
  second = ""
  lines = ""
  sumx = ""

  if len(problems) > 5:
      return "Error: Too many problems."
  for problem in problems:
    if re.search("^[0-9]+\s[+-]\s[0-9]+$",problem):
      if(re.search("[/]",problem) or re.search("[*]",problem)):
        return "Error: Operatror Must be '+' or '-'."

      #collect data from one single item in list
      num1,operator,num2 = collector(problem)
      if len(num1) >= 5 or len(num2) >= 5:
        return "Error: Numbers cannot be more than four digits."
      
      # calculate this itme 
      if (operator == "+"):
        segma = str(int(num1) + int(num2))
      elif (operator == "-"):
        segma = str(int(num1) - int(num2))

      # print this item with right format
      length = max(len(num1),len(num2)) + 2
      top = str(num1).rjust(length)
      bottom = operator + str(num2).rjust(length-1)
      line = length * "-"
      res = str(segma).rjust(length)

      if problem == problems[-1]:
        first += top 
        second += bottom 
        lines += line 
        sumx += res 
        break

      tap = "    "
      first += top + tap
      second += bottom + tap
      lines += line +tap
      sumx += res + tap
    elif(re.search("[/]",problem) or re.search("[*]",problem)):
        return "Error: Operator must be '+' or '-'."
    else:
      return "Error: Numbers must only contain digits."
    
    

  if flag:
    string =f"{first}\n{second}\n{lines}\n{sumx}"
  else:
    string = f"{first}\n{second}\n{lines}"
  
  return string


def collector(arr):
    num1 = arr.split(" ")[0]
    operator = arr.split(" ")[1]
    num2 = arr.split(" ")[2]
    return num1, operator, num2