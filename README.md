**Requirements**

Processing 3.0 with Oscp5 addon (libraries - search)

Python 3.5 with python-osc library (pip3 install python-osc)

**To Run**
To begin with, open 'boxArray.pde'(make sure MSAbox.pde is included in the sketch also) in Processing. Move the mouse around on the screen a bit. Then open the python program, 'weatherAPI.py'; in the command line enter: 

python3 weatherAPI.py

Then...

**What does it do?**

You will be prompted to enter a city. Type in any city of your choice, you'll then see the wind speed printed to your terminal window, and if you move your mouse around in the Processing window again you should see that the tail of the boxes is now moving across the screen. Run the program again, enter another city, see what happens!

The animation built in processing (with the help of Memo Atken's tutorial: http://www.memo.tv/works/) - moving the mouse aound the screen animates some 
3D boxes with a tail effect. Messages from weatherAPI.py (openweathermap.org) are sent via OSC to the processing program to control the behaviour of the tail's 'wind' effect.
