IBCellFlipSegue
===============

*IBCellFlipSegue* is a simple custom segue meant to replicate the behavior of the buttons in the new version of the [Expedia Hotels & Flights](https://itunes.apple.com/us/app/expedia-hotels-flights/id427916203?mt=8) app. Currently, the segue is in it's very early stages of development, and it was created as a simple personal project which I have decided to share.

Requirements
---------------

The use of *IBCellFlipSegue* requires:

*  Xcode 4.4+
*  ARC Support
*  iOS 5.0+

Installation
---------------

To setup *IBCellFlipSegue* in your project, simply follow these steps:

1.  Clone the *IBCellFlipSegue* repository, either as a submodule or into a folder on your computer.
2.  Add *IBCellFlipSegue* folder into your project.
3.  In your project's settings, select the project's target and under Build Phases add `QuartzCode.framework` to *Link Binary With Libraries*.
4.  Import *IBCellFlipSegue* where you need it in your project by adding `#import IBCellFlipSegue.h` to the header file.

How To Use
---------------

To use the *IBCellFlipSegue*, follow these simple steps:

1.  Inside your app's storyboard file, create a custom segue between the views you want to transition.
2.  Using the Attributes Inspector, the the Segue Class field to `IBCellFlipSegue`.
3.  **Optional:** In case the source view controller (the view controller you are transitioning from) has more than one segue, give the segue an identifier.
4.  In the source view controller's implementation file (.m) implement the `prepareForSegue:sender:` method of the view controller.
5.  Convert the segue to an *IBCellFlipSegue* like so:

        IBCellFlipSegue *cellFlipSegue = (IBCellFlipSegue *)segue;

6.  Set the segues `selectedCell` property to the button/cell that should be flipped.
7.  **Optional:** Set the direction/type of the flip by settings the segue's `flipAxis` property to one of the following: `FlipAxisHorizontal`, `FlipAxisVertical`, `FlipAxisDiagonal`.
8.  Make beautiful transitions!
