//
//  CultreAppApp.swift
//  CultreApp
//
//  Created by Manar Alghmadi on 27/03/1446 AH.
//

import SwiftUI

@main
struct CultreAppApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView()
            ChangeCounrtiesView()
            }
        
        }
    }

struct ChangeCounrtiesView: View{
    @Environment(\.colorScheme) var colorScheme  // Access the current color scheme (dark or light)

    @State private var showCountryGrid = false
    @State private var showCountryFaves = false
    @State private var countries: [Countries] = []
    @State private var itemFavesbool: [Bool] = []
    @State private var isGridView = false
    @State private var showSplash = true  // Start with splash screen visible

    var body: some View{
        ZStack {
            if showSplash {
                SplashScreenView()  // Splash screen view
                    .transition(.opacity)  // Fade in and fade out transition
            } else {
                NavigationStack {
                    VStack {
                        // Toggle between grid view and list view
                        HStack {
                            Image(systemName: showCountryGrid ? "list.bullet" : "square.grid.2x2")
                                .font(.system(size: 25))
                                .onTapGesture {
                                    showCountryGrid.toggle()
                                }
                            
                            Spacer()
                            
                            Text("الدول").font(.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                            
                            Spacer()
                            
                            Image(systemName: showCountryFaves ? "heart.fill" : "heart")
                                .foregroundColor(showCountryFaves ? .red : (colorScheme == .dark ? .white : .black))
                                .font(.system(size: 25))
                                .onTapGesture {
                                    showCountryFaves.toggle()
                                }
                        }
                        .padding(.leading, 25)
                        .padding(.trailing, 25)
                        
                        // Show either list view or grid view
                        if !showCountryGrid {
                            CountryListView(countries: $countries, itemFavesbool: $itemFavesbool, sowFaves: $showCountryFaves)
                        } else {
                            CountryGridView(countries: $countries, itemFavesbool: $itemFavesbool, sowFaves: $showCountryFaves)
                        }
                    }
                }
                .onAppear {
                    loadCountriesAndFavorites()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {  // Increase the delay for a smoother splash screen experience
                withAnimation(.easeInOut(duration: 1.0)) {
                    showSplash = false  // Hide the splash screen after the delay
                }
            }
        }
    }

    func loadCountriesAndFavorites() {
        countries = loadCountries()  // Your function to load countries
        itemFavesbool = countries.map { $0.counrtryIsFaves }  // Load the favorite statuses

        for country in countries {
            print("Loaded country: \(country.counrtryName), favorite status: \(country.counrtryIsFaves)")
        }
    }
}
