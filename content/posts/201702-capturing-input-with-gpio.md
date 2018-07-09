---
title: "Capturing Input with RPi.GPIO"
description: "description"
categories: ["raspberrypi"]
date: 2017-02-10
tags: ["none"]
---

Now that we have experimented with LEDs I want to start capturing basic inputs from buttons using RPi.GPIO. The first question that came up is why do buttons have four pins when they only need two. The answer turns out to be to make them more versatile in making arrays. Articles I found on this went into detail a bit more than I wanted so i made a simple circuit to just test my buttons work the way i expect.

&nbsp;

<a href="http://scottsan.co.uk/wp-content/uploads/2017/02/button_led.jpg"><img class="wp-image-489 size-medium aligncenter" src="http://scottsan.co.uk/wp-content/uploads/2017/02/button_led-300x182.jpg" alt="button_led" width="300" height="182" /></a>

This worked nicely. Pressing the button lights up my LED.

To capture input using RPi.GPIO you will need to set your chosen pins up correctly. It is normal to use what is called a pull-up or pull-down resistor to set the default state of the input pin.

[python]

GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

[/python]

Luckily the raspberry pi allows us to do this in software so my circuit is fairly simple

<a href="http://scottsan.co.uk/wp-content/uploads/2017/02/button_input.jpg"><img class="wp-image-488 size-medium aligncenter" src="http://scottsan.co.uk/wp-content/uploads/2017/02/button_input-300x235.jpg" alt="button_input" width="300" height="235" /></a>

&nbsp;

<strong>Wait For Edge</strong>

An edge is a change event such as the rising or falling of current over a pin. If you know what input you are waiting for you can pause execution of your program to wait for it by using:

[python]

#Edge can be GPIO.RISING, GPIO.FALLING or GPIO.BOTH

GPIO.wait_for_edge(pin, edge, timeout=5000)

[/python]

<a href="https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/ButtonWaitForEdge.py">ButtonWaitForEdge.py</a>

&nbsp;

<strong>Polling</strong>

You can poll a pin at anytime using:

[python]

GPIO.input(pin)

[/python]

However doing this you may miss an input if your program is doing something else at the point in time the button is pressed. Below is a script that polls the state of pin 7 every half a second and prints if the button is pressed or not. Because I am polling, if i press the button too quickly the input is not picked up which is not ideal.

<a href="https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/ButtonPolling.py">ButtonPolling.py</a>

&nbsp;

<b>Interrupts - Event Detected &amp; Event Callback</b>

You can add listeners for events on pins to avoid missing inputs as you can with polling:

[python]

# setup an event listener

GPIO.add_event_detect(pin, GPIO.FALLING)



# check to see if any events have been recorded

GPIO.event_detected(pin)

[/python]

The good news about using this is that your program can continue to do other things and then when its ready check for events it may have missed. The downside is that multiple events are not captured so again you may miss the fact a button was pressed three times. This is where event callbacks come in handy:

[python]

# add an event listener AND an event callback

GPIO.add_event_detect(pin, GPIO.FALLING, bouncetime=200)

GPIO.add_event_callback(pin, somefunction)

[/python]

Using callbacks means that your program can run and at anytime an input is detected the callback function, in this cace somefunction(), will be triggered. This runs in a separate thread so as not to block the main program.

Note also the parameter "bouncetime". This is to solve in software the electrical problem of "Switch Bouncing". This can also be done with a resistor

Here are two examples:

<a href="https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/ButtonEventDetected.py">ButtonEventDetected.py</a>

<a href="https://github.com/mrhockeymonkey/PythonPlayground/blob/master/RaspberryPi/ButtonEventCallback.py">ButtonEventCalback.py</a>

&nbsp;