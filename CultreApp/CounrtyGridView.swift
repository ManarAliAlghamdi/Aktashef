import SwiftUI

struct CountryGridView: View {
    
    @Binding var countries: [Countries]
    @Binding var itemFavesbool: [Bool]
    @Binding var sowFaves: Bool
    @State private var searchText = ""

    
    
    var filteredItems: [Countries] {
        if searchText.isEmpty {
            if sowFaves {
                return countries.filter { $0.counrtryIsFaves }
            } else {
                return countries
            }
        } else {
            if sowFaves {
                return countries.filter { $0.counrtryName.localizedCaseInsensitiveContains(searchText) && $0.counrtryIsFaves }
            } else {
                return countries.filter { $0.counrtryName.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }

    let columns = [
        GridItem(.flexible(), spacing: 5),  // Reduced spacing between columns
        GridItem(.flexible(), spacing: 5)
    ]

    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.bottom, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredItems.indices, id: \.self)
                        {
                            index in
                            ZStack(alignment: .bottom) {
                                GeometryReader { geometry in
                                    NavigationLink(destination: CountryDetailWithTabsView(country: filteredItems[index])) {
                                        
                                        Image(filteredItems[index].counrtryImageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                            .clipped()
                                            .cornerRadius(20)
                                            .overlay(
                                                Color.black
                                                    .opacity(0.4)
                                                    .cornerRadius(20)
                                            )}
                                    
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Image(systemName: itemFavesbool[index] ? "heart.fill" : "heart")
                                                .foregroundColor(itemFavesbool[index] ? .red : .white)
                                                .font(.title)
                                                .padding(10)
                                                .onTapGesture {
                                                    
                                                    toggleFavoriteStatus(for: filteredItems[index], index: index)
                                                    itemFavesbool[index].toggle()
                                                    
                                                }
                                            Spacer()
                                            
                                            
                                            Text(filteredItems[index].counrtryName)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding([.horizontal, .bottom], 10)
                                        }
                                    }
                                }
                                .frame(height: 150)
                            }
                            .frame(height: 150)
                        }
                    }
                    .padding(.horizontal, 5)  // Reduced padding around the entire grid
                }
            }
        }
    }
    func toggleFavoriteStatus(for country: Countries, index: Int) {
        print("Before toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")
        country.counrtryIsFaves.toggle()
        print("After toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")

        if let index = countries.firstIndex(where: { $0.counrtryId == country.counrtryId }) {
            countries[index] = country  // Update the country in the list
        }

        saveCountriesToJSON(countries: countries)  // Save the updated data back to JSON
    }
}
