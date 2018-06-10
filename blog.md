

# First Look: Siri Shortcuts

### Introduction

The common impression is that Siri does not compare with Alexa and Google Voice.  Siri seems stuck in the past compared to its rivals.  Voice assistants are OK for general information like Wikipedia or weather or sports, but they lag when it comes to *personal* information.  

WWDC 2018, with one of the most enthusiastic presenters in memory, changes all that.

![](blogImages/1.presentation.jpeg)

### 25 Extensions and Counting

Every year Apple comes up with new ways for apps to integrate themselves within the operating system.  There are now 25 different extensions you can add to an app to keep it from getting marooned on the home screen.  From Spotlight search, to Apple Watch extensions, to local notifications.  Over the last couple of years, Apple has gradually opened up Siri to developers.  At first the list of voice intents was quite restrictive.  Now apps can generate custom intents to handle just about any kind of user interaction.

![](blogImages/AddingExtension.jpeg)

### A Problem Never Solved Well by Notifications

Until now, the best way to interact with users outside the app was 

You can't carry an Alexa with you.  There's nothing like the menagerie of iOS apps on Alexa.  CapTech's enterprise customers have invested in iOS.  Now they can 

This is part of the ongoing effort to keep apps from getting marooned on the home screen.  The challenge is to integrate application functionality into the operating system of the device.  Siri shortcuts offer

This is our first impression after a single weekend exploring Siri Shortcuts. 

### Sample App

You will find our [sample app](https://github.com/CapTechMobile/SiriBanker) on GitHub.  


### User Initiati


 



### Intents


### User Activity

One new feature is suggested activities via Siri Shortcuts. 
These shortcuts are presented to the user at a time the system considers to be relevant, or when the user searches for a keyword in spotlight search.

In our banking app, we created a shortcut for accessing a user's checking account. When the user completes the action normally by visiting their Checking Account Details view, the app 
creates an NSUserActivity which defines the action, and donates it to the system. Donations like these are tracked internally on the device, and used to suggest the shortcut to the user at an appropriate time.
For example, if a customer of your bank is constantly revisiting their checking account balance at noon every other Friday, Siri and the system will learn this behavior and suggest the action to the user on subsequent Fridays via the lock screen.

Alternatively, if the user searches in spotlight for the phrase or keywords associated with the NSUserActivity, a suggestion will appear in the search results that will navigate the user to the appropriate screen. A screenshot of this functionality is below.
![](blogImages/checkingSpotlightSuggestion.png)

You will have to implement the AppDelegate function `application(_ application: continue userActivity: restorationHandler: ) -> Bool` to handle the user selecting those shortcuts.


### Conclusion and Recommendations


- Shortcuts are an answer to Google assistant, Alexa
- Designed to leverage machine learning to make siri smarter and give developers a way to better integrate their apps into the OS
- Its clear that apple wants your app to be much more than just an icon on the homescreen. Apps now should strive to be seamlessly woven into the device experience
- By using @available tags, you can begin implementing this functionality now, and avoid disrupting current user experiece for users who have not upgraded
- Most will upgrade tho: By Christmas 2018, enerprises can expect that 70% of their customers ...
- Building for this experiece now will put an enterprise ahead of the game and can create an experience that edges out other apps in your space.



//////////////


You can implment it now.  By Christmas 2018, enterprises can expect that 70% of their customers will be running iOS 12.  A year from now, that percentage will be close to 90%.  With the `@Available` tag, our customers can deploy code that 


Siri vs. Alexa

Common knowledge is that Amazon’s Alexa and Google Voice are more powerful than Siri.

But you can’t carry a dot around in your pocket.  There’s no battery.

What makes powerful is that 

Ongoing effort to keep apps from getting forgotten on your home screen.

Sort of a substitute for notifications.

ultra enthusiastic.  jet packs on his shoes.  

70 % of your users are going to be on by the end of the year.

You can use the `@available(iOS 12.0, watchOS 5.0, *)`

To make it work with old users.  So there’s no need to wait.

Missing Intent Title

Siri Shortcuts vs notifications.   

project setup.

 
### Random notes
iOS 12 Only
It may take a year to get your intents up to speed.

There is no reason why you can’t build it in now for the fall.

Missing Title

There’s a banking up there.  Figure out what’s wrong and help us with a PR.

Missing Title

Key steps:
* Entitlments
* App Group
* Turn on Debugging
* 

Where does it go.
  (img)

