---
title: "Controlling LEDs with RPi.GPIO"
description: "description"
categories: ["raspberrypi"]
date: 2017-02--08
tags: ["none"]
---

The purpose of this exercise is to become familiar with using RPi.GPIO python module to control LEDs using the Raspbery Pi GPIO. For this I have installed Raspbian and run the following to setup the environment.

[plain]

$ sudo apt-get update
$ sudo apt-get install python3
$ sudo apt-get install python3-pip
$ sudo apt-get install git
$ sudo pip3 install RPi.GPIO
$ git clone https://github.com/mrhockeymonkey/DotPunch.git

[/plain]

I am using a male to male connector to expose the GPIO pins without removing my RPi from the case. this presents a bit of confusion as means the connection for pin 1 now appears on the right hand side if looking at the cable connection head on.

<strong>Static LED</strong>

First of all I want to create a basic circuit that lights up a single LED. To do this I connect the 3v (P1) and GRND (P6) to my breadboard's live and neutral bus respectively. I then connect an LED with built in resistor to the live and neutral bus accordingly and the LED is now on.

<a href="http://scottsan.co.uk/wp-content/uploads/2017/02/Static_On_LED.jpg"><img class="wp-image-472 size-medium aligncenter" src="http://scottsan.co.uk/wp-content/uploads/2017/02/Static_On_LED-265x300.jpg" alt="Static_On_LED" width="265" height="300" /></a>

<strong>Blinking LED</strong>

Now with the same setup I can start controlling the LED using RPi.GPIO. The script for this is pretty simple. Key points to note for this script are that you must tell the module how you will refer to the pins by using GPIO.setmode() and you must also setup each pin you wish to use as either input or output using GPIO.setup()

[python]

import RPi.GPIO as GPIO
import time

# function to blink led with interval 1 second
def blink(pin):
   GPIO.output(pin, True)
   time.sleep(1)
   GPIO.output(pin, False)
   time.sleep(1)

# use the board pin numbering to refer to pins
GPIO.setmode(GPIO.BOARD)

# declare pin 7 to be used for output
GPIO.setup(7, GPIO.OUT)

# blink the led 10 times
for i in range(0,10):
   blink(7)

[/python]

&nbsp;

<strong>Controlling Multiple LEDs</strong>

For a bit of fun I have also made a more complex circuit consisting of three LEDs. Each has its own connection to a GPIO pin (Red = Pin7, Yellow=Pin13, Green=Pin15) and then each terminates to GRND.

<a href="http://scottsan.co.uk/wp-content/uploads/2017/02/led_traffic_light.jpg"><img class="aligncenter wp-image-479 size-medium" src="http://scottsan.co.uk/wp-content/uploads/2017/02/led_traffic_light-300x225.jpg" alt="led_traffic_light" width="300" height="225" /></a>

To control these I wrote a python script to prompt for user input and illuminate the colour LED they specify.

<a href="https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/LedColourSelect.py">https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/LedColourSelect.py</a>

&nbsp;