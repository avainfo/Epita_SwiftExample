//
//  LocationManager.swift
//  TestProject
//
//  Created by Antonin DO SOUTO on 18/01/2025.
//

import SwiftUI
import CoreLocation

// Define a LocationManager class to handle location-related tasks
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Create an instance of CLLocationManager to manage location updates
    private var locationManager = CLLocationManager()
    
    // Published properties to allow reactive updates in SwiftUI views
    @Published var latitude: Double? = nil // The user's current latitude
    @Published var longitude: Double? = nil // The user's current longitude
    @Published var status: CLAuthorizationStatus? = nil // The current authorization status
    
    // Initialize the LocationManager
    override init() {
        super.init()
        // Set the delegate to self to handle location events
        locationManager.delegate = self
        // Set the desired accuracy to the best available
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Request permission to access location data while the app is in use
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Start updating the user's location
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // Delegate method triggered when the location manager receives new location data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Safely unwrap the last location from the array
        guard let location = locations.last else { return }
        // Update the latitude and longitude on the main thread for UI updates
        DispatchQueue.main.async {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
    
    // Delegate method triggered when the location authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Update the authorization status on the main thread
        DispatchQueue.main.async {
            self.status = manager.authorizationStatus
        }
        // If the app is authorized to access location data, start updating the location
        if manager.authorizationStatus == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }
}
