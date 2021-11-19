# App-of-Ice-and-Fire

This repository contains my homework assignment for the class named *iOS-based Software Development*. 

The project is an application that uses the [An API of Ice And Fire](https://anapioficeandfire.com/) API and shows it's contents to the user. 
This contains the data of the universe of Ice and Fire created by George R. R. Martin (by the way I have not read nor seen the series). 
From the API there are three types of information that are available: books, characters and houses. 
To display these separately the app has a tab bar at the bottom. 
The data from the api is paginated so the list is updated as the user scrolls. 
From these list screens by clicking on an element the user can navigate to a detailed screen of that data type. 
There are two types of information on these screens: default and reference style. 
Default information contains for example the date that the *character* was born (if it is known) or the publisher of a *book*. 
Reference style on the other hand contains links to another type of entity (book, character or house). 
These are cross-navigable throughout the application. 
For example from a selected book go to one of the pov characters, from there navigate to the characters spouse, then go to the house for which this spouse has an allegiance to and so on...

## Architecture
The application is separated into three layers: data, domain and view.

### Data
Firstly here are the classes that interact with the API with network calls. 
For these I used UrlSession to get the data and escaping callbacks to return the results. 
This class only contains implementation to the endpoints that the API provides.


### Domain

### View
