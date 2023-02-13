# Neo_News

1) 3rd Party Framework used
Almofire
Charts
SwiftyJSON

2) Package Manager used
Cocoapod

3) Xcode version
14.2

4) Min deployment target
iOS 15

5) Used language
Swift

6) Design pattern
MVVM


Usage:  
1) when you launch the app, first screen will launch with two textfields ‘Enter start date’ and ‘Enter end date’ and ‘Submit’ button. Submit button will be disabled initially, once user enters both the field dates it will enable.
2) Once user click submit button, we will fire the Neo stat api with required parameters, by the time we get response, UI will be shown with activity indicator.
3) Once we get the response, will update Chart view with number of asteroids per day, like first blue circle (which will bottom left of the screen, if it is in portrait) shows first selected date asteroid count (count will be shown if you go all the way up from that blue circle) like wise it will show for other dates
