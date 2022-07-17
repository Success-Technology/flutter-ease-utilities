<img src="https://www.rudtek.com/wp-content/uploads/2019/12/rudtek-services_wordpress-plugin-development.svg" alt="Plug In">

# Flutter Ease Utilities [ Developer Tool ]
This is a flutter package to provide development cycle fast. This is a complete instruction for applying this package. By using this package , you can save your time and complex impletation of flutter accessibilities.

# Category
- [Notification Utility](#notification-utility)
- [File Utility](#file-utility)
- [UI Snippet Utility](#ui-snippet-utility)
- [Navigation Utility](#navigation-utility)

## Setting Up
- Method - 1

Add dependency to your _**Current Flutter Project**_.
```
dependencies:
  flutter:
    sdk: flutter
  flutter_ease_utilities:
   git:
      url: https://github.com/Success-Technology/flutter-ease-utilities.git
      ref: main
```
This method alive package integrating from original package source

- Method - 2

\- Firstly, create new folder inside your root directory of _**Current Flutter Project**_ with the this name 'packages'.

\- Clone this repository to this `packages` folder.

```
git clone https://github.com/Success-Technology/flutter-ease-utilities.git
```
This command will clone a whole copy of flutter-ease-utilities package inside your root project directory.Then , one last thing to do is to add local package integration in your pubspecs.yaml.
```
dependencies:
  flutter:
    sdk: flutter
  flutter-ease-utilities:
      path : ./packages/flutter-ease-utilities
 ```
 
 **Your are now ready to apply the package**

## Notification Utility 
This is a kind of utility to make easy notify user with lesser line of codes. `NotificationServices` is a main top-layer abstraction class for all implementations.
Everything works with static related style.








