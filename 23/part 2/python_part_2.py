#Apod

#Obtain the url for the API along with the key
base_url="https://api.nasa.gov/planetary/apod?api_key="

#obtain the remote IP address 
import socket
print(socket.gethostbyname('api.nasa.gov'))

key = "wF9vitro29cuXh9CkWVK6mcc2ioTPIhIKUbH5cRQ"
url = base_url+key

import requests
res = requests.get(url)

#the info in json dict
print(res.json())

#load the dict to a json file
import json
respond = json.loads(res.text)

#convert the dict to dataframe
import pandas as pd
dataframe = pd.DataFrame.from_dict(respond, orient='index')
dataframe = dataframe.T

#set index
dataframe = dataframe.set_index('copyright')

#add the remote IP 
ip = ['192.168.1.1']
dataframe = dataframe.assign(Remote_IP = ip)

#store the dataframe in an excel file
writer = pd.ExcelWriter('apod1.xlsx')
df2.to_excel(writer)
writer.save()
