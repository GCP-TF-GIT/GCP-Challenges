def getval(obj,key):
 for i in obj:
    if type(obj[i])==dict and key==i:
        for j in obj[i]:
            getval(obj[i],j)
    elif type(obj[i])==dict and key!=i:
        getval(obj[i],i)
    else:
        print(obj[i])
  
getval({"x":{"y":{"z":"a"}}},"x")
