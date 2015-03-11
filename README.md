# sonarApi_Test

# Sonar service

Sonar is a service to store and normalize information about places from different providers. At this point only 2 providers are supported:

  -Facebook
  
  -Foursquare
  
In the following example using Behat we can test those endpoints using REST requests.

# Installing the project

_Clone this repository: 

_Execute: $ curl http://getcomposer.org/installer | php

_Install Behat: $ php composer.phar install

# Running all the scenarios

_ $bin/behat

# Get a HTML Report

_ $ behat --format html --out report.html

