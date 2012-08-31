cloudfoundry-chaos-monkey
=========================

Chaos Monkey style service for Cloud Foundry

Using Cloud Foundry Chaos Monkey
--------------------------------

First off, grab the Cloud Foundry Chaos Monkey gem

`gem install cfcm`

and then unleash the monkey! In this example, we'll use CFCM on an application named `myapp`, keeping between 2 and 5 instances. We want CFCM to have a 30% chance of adding or removing an instances every 10 seconds. Adding and removeing instances is known as "soft mode", that is, this is equvilant to doing "vmc instane [app] -1". There is a "hard mode" planned that is a bit more chaotic.

`cfcm soft [email] [password] myapp --min 2 --max 5 -p 30 -f 10`

It's as easy as that!