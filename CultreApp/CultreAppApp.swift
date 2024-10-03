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
                ChangeCounrtiesView()
            }
        }
    }


struct ChangeCounrtiesView: View{

    @State private var showCountryGrid = true
    @State private var showCountryFaves = false
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
                    CountryListView(showCountryFaves: $showCountryFaves)
                }else{
                    CountryGridView(showCountryFaves: $showCountryFaves)
                }
                
            }
        }
    }
}
