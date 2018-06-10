# SiriBanker

SiriBanker is a mocked banking app designed to expose functionality via iOS 12's new Siri Shortcuts.


## Features

- Transfer money from one account to another
- Siri will provide a shortcut to view your checking account information
- Transfer money via voice command to siri

## Architecture

SiriBanker persists all data via a local json file. The app features a tab bar for global navigation between an AccountsSummary screen and a Transfers screen.
SiriBanker is split into three parts. A `SiriBankerKit` framework houses all the data and business logic for the app. 
The main app uses this business logic to render it's views. A `Shared` folder contains the majority of the Siri-specific logic, to be accessible across the app.

## Siri Shortcut Features

SiriBanker takes advantage of a number of the iOS 12 siri shortcuts.

### Suggested Activities

Currently, SiriBanker provides a shortcut for accessing your checking account when you search in spotlight. 
When a user visits the details view of their checking account, the app creates an NSUserActivity defining the action and donates it to the system.
These donations are tracked, and used to suggest the shortcut to the user at an appropriate time. For example, if your banking customer is constantly checking their
checking account balance at noon every other Friday, Siri and the system should learn this behavior and suggest the action to the user on subsequent Fridays. 
Alternatively, if the user searches in spotlight for the word checking, a suggestion will appear that will navigate the user to the appropriate screen.

### Voice Commands

SiriBanker does not currently support voice commands, but will in the future. 
A class needs to be created to conform to the `ViewAccountIntentHandling` protocol, which will tell siri what to do to return the correct response. 

