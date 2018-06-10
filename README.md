# SiriBanker

SiriBanker is a mocked banking app designed to expose functionality via iOS 12's new Siri Shortcuts.


## Features

- Transfer money from one account to another
- Siri will provide a shortcut to view your checking account information
- Transfer money via voice command to siri

## Architecture

SiriBanker persists all data via a local json file. The app features a tab bar for global navigation between an AccountsSummary screen and a Transfers screen.

SiriBanker is split into three parts. A `SiriBankerKit` houses all the data and business logic for the app. A `Shared` folder


