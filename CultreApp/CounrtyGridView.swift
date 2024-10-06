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
        GridItem(.flexible(), spacing: 10),  // Ensure consistent spacing between columns
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(text: $searchText)

                LazyVGrid(columns: columns, spacing: 10) {  // Add spacing between rows
                    ForEach(filteredItems.indices, id: \.self) { index in
                        if let originalIndex = countries.firstIndex(where: { $0.counrtryId == filteredItems[index].counrtryId }) {
                            ZStack(alignment: .bottom) {
                                NavigationLink(destination: CountryDetailWithTabsView(country: filteredItems[index])) {
                                    Image(filteredItems[index].counrtryImageName)
                                        .resizable()
                                        .frame(width: 180, height: 120)  // Ensure the image size fits the grid
                                        .clipped()
                                        .cornerRadius(15)
                                        .overlay(
                                            Color.black
                                                .opacity(0.4)
                                                .cornerRadius(15)
                                        )
                                }

                                HStack {
                                    Image(systemName: itemFavesbool[originalIndex] ? "heart.fill" : "heart")
                                        .foregroundColor(itemFavesbool[originalIndex] ? .red : .white)
                                        .font(.title)
                                        .padding(8)
                                        .onTapGesture {
                                            toggleFavoriteStatus(for: filteredItems[index], index: originalIndex)
                                            itemFavesbool[originalIndex].toggle()  // Update the favorite status based on the original index
                                        }
                                    Spacer()
                                    Text(filteredItems[index].counrtryName)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(8)
                                }
                            }
                            .frame(height: 150)  // Ensure a consistent height for grid items
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .padding(5)  // Add padding to each grid item to avoid overlap
                        }
                    }
                }
                .padding(.horizontal, 10)  // Add padding around the entire grid
            }
        }
    }

    func toggleFavoriteStatus(for country: Countries, index: Int) {
        print("Before toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")
        countries[index].counrtryIsFaves.toggle()
        itemFavesbool[index].toggle()  // Update the favorite status locally
        print("After toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")

        if let originalIndex = countries.firstIndex(where: { $0.counrtryId == country.counrtryId }) {
            countries[originalIndex] = country  // Update the country in the list
        }

        saveCountriesToJSON(countries: countries)  // Save the updated data back to JSON
    }
}
