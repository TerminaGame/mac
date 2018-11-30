# Termina for macOS
_The macOS version of Termina_

![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg)

![Termina for macOS on MacBook Pro](https://terminagame.github.io/assets/termina_macbook.png)

Termina is a fun single-user, level-based user dungeon game for macOS and Linux.

This repository provides the source code for the macOS version of the game and the project files needed via Xcode.

## Features
- [x] Infinite room generation from templates
- [x] Experience and level systems
- [x] Attack and heal system
- [x] Persistent data and import from Termina [Base](https://github.com/TerminaGame/base)
- [x] Inventory system
- [x] Platforming

## Downloads
Currently, there aren't any releases ready.

If you prefer testing builds, you may want to consider the [Termina for macOS Beta Program](https://terminagame.github.io/mac/tutoriel.html).

## Building from source
This project makes use of CocoaPods and the AppCenter framework to compile and run this game. These frameworks are usually used for the Beta Program and its analytic features.

1. Clone the project locally and ensure that you have installed CocoaPods (if you use Homebrew, type `brew install cocoapods` in a terminal).
2. In a terminal, type `pod install` to install the framework.
3. Open the _workspace_ in Xcode and change the developer signing to your own account.
4. Build and run the application. If you want to make a _release_ rather than a _debug_ version, change the scheme from 'Termina' to 'Termina (Release)'.