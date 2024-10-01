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
            
        }
        }
    }

struct Nav: View{
    @State private var showCountryGrid = false
    var body: some View{
        VStack{
            HStack {
                Image(systemName: showCountryGrid ? "line.3.horizontal" : "square.grid.2x2")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .onTapGesture {
                        showCountryGrid.toggle()
                        
                    }
                
                Spacer()
                Image(systemName: "heart")
                    .font(.system(size: 25))
                    .foregroundColor(.red)
                    .onTapGesture {
                        print("heart clicked!")
                    }
            }
            .padding(.bottom, 10)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            
            
                
                if showCountryGrid {
                    CountryGridView()
                } else {
                    CountryListView()
                }
        }
    }
}
