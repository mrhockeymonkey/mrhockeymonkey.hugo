---
title: "Using The Modulus Operator"
description: "description"
categories: ["powershell"]
date: 2015-10-28
tags: ["none"]
---


You can use the Modulus Operator '%' in a few ways that can be very helpful depending on what you are trying to achive. Modulus can be thought of as a remainder when one number divides another. For instance 5 Mod 3 is 2 and 5 Mod 6 is 5.

[powershell] #5 Divided by 3 leaves a remainder of 2
5 % 3
2

#5 Divided by 6 leaves a remainder of 5
5 % 6
5
[/powershell]

<strong>Find Multiples of x</strong>
To find multiples of a given number you can simply find all numbers in an array that have a remainder of 0 when divided by x

[powershell] $arr = {Array](1..100)
#Find all multiples of 3
$arr | ?{$_ % 3 -eq 0}
[/powershell]

<strong>Find every xth item</strong>
When not working with numbers you can also use % to find every 2nd, 3rd, ... xth item in an array by using $i as a counter. Bare in mind 0 is the first element of an array which can become confusing in this example

[powershell] #Get the first value and every xth value thereafter
$arr = 'one','two','three','four','five','six','seven','eight','nine','ten'
$i = 0
$x = 2
While ($i -lt $arr.Length){
    if(($i % $x) -eq 0){
        $arr[$i]
    }
    $i++
}

one
three
five
seven
nine

[/powershell]
