import asyncio
from bs4 import BeautifulSoup
from selenium import webdriver
import pandas as pd
import datetime, re, time, itertools, smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

import firebase_admin
from firebase_admin import credentials, firestore

async def backend ():
    cred = credentials.Certificate("firebasekey.json")
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    doc_ref = db.collection('users').stream()
    for user in doc_ref:
        # print(user.to_dict())
        # print(user.id)
        flights = db.collection('users').document(user.id).collection('flights').stream()

        for f in flights:
            From = f.get('from')
            To = f.get('to')
            print(str(From)+"-"+str(To))
            # run(str)
        # flights = user.collection('flights').stream()

def run(cities):
    #Define parameters
    start_date = datetime.datetime(2021,12,13)
    days_range = 2
    trip_length, min_length, max_length = 7, 6, 12
    price_goal = 900

    #Get list of dates to go over in the loop
    start = pd.date_range(start_date, periods=days_range).to_pydatetime().tolist()
    end = pd.date_range(start_date + datetime.timedelta(days=trip_length), periods=days_range).to_pydatetime().tolist()

    #Get all combinations of dates
    all_dates = list(itertools.product(start,end))

    #Remove incoherent dates and dates that dont respect conditions
    departing=[]
    returning=[]
    for i in range(len(all_dates)):
        if (([x[1] for x in all_dates][i] - [x[0] for x in all_dates][i]).days > min_length) & \
        (([x[1] for x in all_dates][i] - [x[0] for x in all_dates][i]).days < max_length):
                
            departing.append(([x[0] for x in all_dates][i]).strftime('%Y-%m-%d'))
            returning.append(([x[1] for x in all_dates][i]).strftime('%Y-%m-%d'))
        else:
            None
    
    #Cleaning dates to make them usable in loop
    for i in range(len(departing)):
        departing[i]=re.sub(' 00:00:00', '', departing[i])
        returning[i]=re.sub(' 00:00:00', '', returning[i])
        
    #Scraping data for all cities
    data=[]

    for i in range(len(departing)):

        page ='https://www.ca.kayak.com/flights/' + cities + '/' + departing[i]+ '/' + returning[i] +'?sort=bestflight_a' 
        op = webdriver.ChromeOptions()
        # op.add_argument('headless')
        driver = webdriver.Chrome('./chromedriver.exe', options=op)
        driver.get(page)  
        time.sleep(15)
        soup = BeautifulSoup(driver.page_source, 'html.parser')

        my_table = soup.find(class_=['price option-text'])
        
        try:
            print("YOYOYO ", my_table.get_text())
            data.append(my_table.get_text())
            data[i]=int(re.sub('[^0-9]','', data[i]))
            
            # if data[i]<price_goal:
            #Email info
            sender = '999dragonmaster999@gmail.com'
            password = '999dragonmast3rEEE'
            port = 465
            receive = sender
            
            #Email content
            msg = MIMEMultipart()
            msg['From'] = sender
            msg['To'] = receive
            msg['Subject'] = 'Great deal on tickets found'

            body = 'Go here to see the great deal:' + re.sub('https://www.', '', page)
            msg.attach(MIMEText(body,'plain'))
            text = msg.as_string()

            #Sending email
            context = ssl.create_default_context()
            with smtplib.SMTP_SSL('smtp.gmail.com', port=port, context=context) as server:
                server.login(sender, password)
                server.sendmail(sender, receive, text)
                        
        except:
            data.append('No flights found')
        
        if i == 1:
            break

    print(data)

    driver.quit()

if __name__ == "__main__":
    asyncio.run(backend())