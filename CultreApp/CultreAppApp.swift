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
    @State private var showCountryGrid = false
    @State private var showCountryFaves = false
    @State private var countries: [Countries] = []
    @State private var itemFavesbool: [Bool] = []
    @State private var isGridView = false
    var body: some View{
        NavigationStack{
            VStack{
                
                HStack {
                    Image(systemName: showCountryGrid ? "line.3.horizontal" : "square.grid.2x2")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .onTapGesture {
                            showCountryGrid.toggle()
                            
                            
                        }
                    
                    Spacer()
                    Text("الدول").font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    Spacer()
                    
                    Image(systemName:  showCountryFaves ? "heart.fill" : "heart")
                        .foregroundColor(showCountryFaves ? .red : .black)
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .onTapGesture {
                            showCountryFaves.toggle()
                            
                        }
                }
                
                .padding(.bottom, 10)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                if !showCountryGrid{
                    CountryListView(countries: $countries, itemFavesbool: $itemFavesbool)
                }else{
                    CountryGridView(countries: $countries, itemFavesbool: $itemFavesbool)
                }
                
            }
        } .onAppear {
            loadCountriesAndFavorites()
        }
    }

    func loadCountriesAndFavorites() {
        countries = loadCountries()

        itemFavesbool = countries.map { $0.counrtryIsFaves }
        

        for country in countries {
            print("Loaded country: \(country.counrtryName), favorite status: \(country.counrtryIsFaves)")
        }
    }
}






    

