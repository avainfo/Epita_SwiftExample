//
//  ContentView.swift
//  TestProject
//
//  Created by Antonin DO SOUTO on 11/01/2025.
//

import CoreLocation
import SwiftUI

struct Todo: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}

struct ContentView: View {
    @State private var todos: [Todo] = []
    @State private var test: String = ""
    @State private var width: Double = 200;
    @State private var background: Color = .blue;
    @State private var fontColor: Color = .red;
    @State private var pressed = false;
    // Calling LocationManager
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(spacing: 20) {
                Button("Click this") {
                    // Animation of the width, the background and the font color
                    withAnimation(.bouncy) {
                        width = pressed ? 200 : geo.size.width / 4;
                        background = pressed ? .blue : .red;
                        fontColor = pressed ? .red : .blue;
                        pressed = !pressed;
                    }
                    
                }
                .safeAreaPadding()
                .frame(width: width, height: geo.size.width / 3)
                .cornerRadius(15)
                .background(background)
                .font(.system(size: 15))
                .foregroundStyle(fontColor)
                if let latitude = locationManager.latitude,
                   let longitude = locationManager.longitude {
                    Text("Latitude: \(latitude)")
                    Text("Longitude: \(longitude)")
                } else {
                    Text("Waiting for location data...")
                }
                
                // Display the current authorization status
                if let status = locationManager.status {
                    Text("Authorization Status: \(status.rawValue)")
                } else {
                    Text("Checking authorization status...")
                }
            }
            .padding()
            .onAppear {
                // Start updating the user's location when the view appears
                locationManager.startUpdatingLocation()
            }
        }
    }
    
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
}

#Preview {
    ContentView()
}
