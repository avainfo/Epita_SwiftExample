# TestProject - Swift Course at EPITA

This project was created as part of a Swift programming course at EPITA to teach students key concepts in SwiftUI, CoreLocation, and networking in iOS development.

## Overview

The TestProject app demonstrates the following concepts:

1. Dynamic UI with SwiftUI:
- Animations using SwiftUI's withAnimation.
- Geometry management with GeometryReader.
- Customizing views with properties like cornerRadius, foregroundStyle, etc.
2. Location Handling with CoreLocation:
- Using the CLLocationManager class to fetch the user's current location.
- Reacting to changes in authorization status.
3. Networking:
- Fetching and decoding JSON data from a REST API using URLSession.

## Project Structure

1. ContentView.swift
This is the main view of the app where the user interacts with:
- A dynamic button that changes size, background color, and font color upon being pressed.
- Location data (latitude and longitude) displayed in real-time if permission is granted.
- A placeholder for location permission status updates.
2. LocationManager.swift
A reusable class responsible for:
- Managing location updates via the CLLocationManager class.
- Publishing the latitude, longitude, and authorization status to be used in SwiftUI views.
- Requesting location permissions and reacting to status changes.
3. TestProjectApp.swift
The entry point of the app. It initializes the ContentView in the main window of the application.

## Key Features

### 1. Dynamic Button
The button reacts to user interaction with a smooth animation:

  `Before Press`: Button is blue with red font.<br>
  `After Press`: Button shrinks, turns red, and the font becomes blue.<br>

Code snippet for button animation:

```swift
Button("Click this") {
    withAnimation(.bouncy) {
        width = pressed ? 200 : geo.size.width / 4
        background = pressed ? .blue : .red
        fontColor = pressed ? .red : .blue
        pressed.toggle()
    }
}
```
### 2. Real-Time Location Updates
The app uses CoreLocation to:
- Fetch the user's current latitude and longitude.
- Handle permission requests for accessing location data.
- Update the UI dynamically based on the user's location.
### 3. REST API Integration
The fetchPosts method fetches data from a public API:
- Decodes the JSON response into a list of Todo items.
- Uses URLSession for asynchronous network calls.

```swift
func fetchPosts() {
    guard
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
    else { return }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data {
            if let decodedPosts = try? JSONDecoder().decode(
                [Todo].self, from: data)
            {
                print(decodedPosts)
                DispatchQueue.main.async {
                    self.todos = decodedPosts
                }
            }
        }
    }.resume()
}
```

## Running the App

### Prerequisites
- Xcode 14 or later.
- iOS 15 or later for deployment.
- A physical iOS device or simulator.
### Setup
1. Clone the repository.
2. Open Info.plist and add the following key for location permissions:
```
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to display your current position.</string>
```
3. Run the app on a simulator or device. If using a simulator:
    - Go to Features > Location and choose a custom or pre-defined location.

## Learning Objectives

Students will learn:
1. How to build responsive UI using SwiftUI.
2. How to handle CoreLocation for fetching user location and managing permissions.
3. How to integrate REST APIs in Swift apps using URLSession.
4. How to use @State, @StateObject, and @Published to manage state in SwiftUI.

## Example Usage

When the app launches:
- The button appears on the screen and can be pressed for an animation effect.
- Location permission is requested:
  - If granted, the app displays the user's latitude and longitude.
  - If denied, the app shows the current authorization status.
- Students can experiment with the fetchPosts method to load data from the API.

## Author

_Created by [**Antonin DO SOUTO**](github.com/avainfo) for the Swift Programming Course at [EPITA](epita.fr)._
