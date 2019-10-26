#Hacksmiths - Hack Your Future
import requests
from pprint import pprint
from pythonosc.udp_client import SimpleUDPClient

#user input
city = input('Enter your city: ')
#api query with my unique key
url = "http://api.openweathermap.org/data/2.5/weather?q={}&appid=8efa6cf7bbcc52be6b29d1c6d1b5e07e&units=metric".format(city)

res = requests.get(url)

data = res.json()

#this prints all of the .json data
#print(data)

#create variables for individual values
temp = data['main']['temp']

wind_speed = data['wind']['speed']


#print individual data variables
#print('Temperature: ', temp)
print('Wind Speed: ', wind_speed)

#OSC setup: https://python-osc.readthedocs.io/en/latest/client.html#example

ip = "127.0.1.1"
port = 12345

client = SimpleUDPClient(ip, port)
#send the wind data to processing program
client.send_message("/weather/wind", wind_speed)




