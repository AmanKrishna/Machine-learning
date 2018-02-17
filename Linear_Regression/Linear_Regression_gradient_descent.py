import csv

def get_csv():
    with open('housingVsTime.csv') as csvfile:
    
        readCSV = csv.reader(csvfile, delimiter=',') #Read CSV File
        
        #reading the first row
        row1 = next(readCSV)
        
        #reading the second row
        row2 = next(readCSV)

        dates = []  #List for storing the dates
        price = []  #List for storing the prices
        count = []  #List to maintain the relation between the list dates and prices
        i = -1
    
        for row in row2:
            i = i+1
            #removing the blank data entries
            if row!='':
                count.append(i)
                price.append(row)

        i = -1
    
        for row in row1:
            i = i +1
            #taking only those date entries which have been included in the list price[]
            if i in count:
                dates.append(row)

    dates = dates[6:]   #removing the unnecessary text entries
    price = price[6:]   #removing the unnecessary text entries

    modDates = []
    for i in dates:
        temp = int(i[0:4])
        temp2 = int(i[5:])
        modDates.append(temp+temp2) #storing date in a numerical form

    [p,q] = gradient_descent(modDates,price)
    print(p)
    print("\t")
    print(q)


def gradient_descent(modDates, price):
    m = len(price)

    #Assuming the relationship between the output and input to be linear
    #and of the form Y = X*P + Q

    p = 0   
    q = 0
    count = 0
    gradient_q = 0
    gradient_p = 0
    learning_rate = 0.001
    loop_count = 1000
    i = 0

    while(i<loop_count):
        while(count < m):
            x = int(modDates[count])/1000   #Reducing the input size
            y = int(price[count])/1000      #Reducing the input size
            
            gradient_q = gradient_q + (q + p*x - y)/m
            gradient_p = gradient_p + x*(p*x + q - y)/m
            count = count + 1
    
        p = (p - (learning_rate*gradient_p))    #new values of p
        q = (q - (learning_rate*gradient_q))    #new value of q
        
        i += 1
        count = 0
        gradient_p = gradient_q = 0     #resetting the gradient
        #print(str(p)+"\t"+str(q)) #to view the change in the values of p and q

    return(p,q)

def error(p,q,modDates,price):  #error calculation for each point
    count=0
    error = 0
    while(count<m):
        x = int(modDates[count])/1000
        y = int(price[count])/1000
        estimated_price = x*initial_p + initial_q
        error = estimated_price - y
        count += 1
        print(error)
        print("\n")

get_csv()
