import SwiftUI

struct CountryListView: View {
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

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.bottom, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)

            ScrollView {
                LazyVStack(spacing: 16) {  // Add spacing between items for clarity
                    ForEach(filteredItems.indices, id: \.self) { filteredIndex in
                        let country = filteredItems[filteredIndex]
                        
                        // Find the correct index in the original countries array
                        if let originalIndex = countries.firstIndex(where: { $0.counrtryId == country.counrtryId }) {
                            NavigationLink(destination: CountryDetailWithTabsView(country: country)) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(country.counrtryImageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 150)  // Full width with padding
                                        .cornerRadius(20)
                                        .clipped()

                                    // Black overlay for text and icons
                                    Color.black.opacity(0.4)
                                        .cornerRadius(20)

                                    // Heart icon and country name
                                    HStack {
                                        Image(systemName: itemFavesbool[originalIndex] ? "heart.fill" : "heart")
                                            .foregroundColor(itemFavesbool[originalIndex] ? .red : .white)
                                            .font(.title)
                                            .padding(10)
                                            .onTapGesture {
                                                toggleFavoriteStatus(for: country, originalIndex: originalIndex)
                                                itemFavesbool[originalIndex].toggle()
                                            }
                                        Spacer()

                                        Text(country.counrtryName)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(10)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 32, height: 150)  // Ensure consistent item size
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)  // Padding around the entire scrollable list
            }
        }
    }

    // Updated function to toggle favorite status
    func toggleFavoriteStatus(for country: Countries, originalIndex: Int) {
        print("Before toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")
        countries[originalIndex].counrtryIsFaves.toggle()  // Toggle in the original array
        print("After toggling: \(country.counrtryName) favorite status: \(countries[originalIndex].counrtryIsFaves)")

        saveCountriesToJSON(countries: countries)  // Save the updated data back to JSON
    }
}
