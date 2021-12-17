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
For example from a selected book go to one of the pov characters, from there navigate to the character's spouse, then go to the house for which this spouse has an allegiance to and so on...

## Architecture
The application is separated into three layers: data, domain and view.
Between these layers Resolver helps with injecting the necessary classes.
To integrate Resolver into the project I used Swift Package Manager.
The project is properly structured into folders in Xcode,
however when I tried to use physical grouping instead of logical ones, Xcode was unable to find them.
Therefore I stuck with logical grouping only.
### Data
Firstly here are the classes that interact with the API with network calls. 
For these I used UrlSession to get the data and escaping callbacks to return the results. 
This class only contains implementation to the endpoints that the API provides.

Also there is another class that is responsible for handling the communication with Core Data.
This provides an interface for inserting and fetching objects from the database.

### Domain
For the model of the domain I decided to use the classes that are generated from the Core Data models.
Mapping functions are also exported to their separate files where they extend the object that is being mapped to another.
An interactor is also here which fulfills the purpose of fetching the data from the lower layer.
If the required objects cannot be found in the database then it requests from the API and saves them the database to speed up future requests.

### View
The views are separated into their own groups, each having their own model.
These models contain only the necessary information for that view to display.
The mapping is exported into extension classes.
The elements on the views are adaptive, meaning they are constrained based of the edges of the screen so the user interface changes depending on screen sizes.
