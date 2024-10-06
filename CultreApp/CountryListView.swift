import SwiftUI

struct CountryListView: View {
    @Binding var countries: [Countries]
    @Binding var itemFavesbool: [Bool]
    @State private var searchText = ""

    var filteredItems: [Countries] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.counrtryName.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(text: $searchText)

                LazyVStack(spacing: 20) {
                    ForEach(filteredItems.indices, id: \.self) { index in
                        if index < itemFavesbool.count {  // Ensure valid index
                            ZStack(alignment: .bottomTrailing) {
                                // Wrap the entire ZStack inside the NavigationLink
                                NavigationLink(destination: CountryDetailWithTabsView(country: filteredItems[index])) {
                                    ZStack {
                                        Image(filteredItems[index].counrtryImageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)  // Ensures images fill the frame proportionally
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 150)  // Fixed width and height for all images
                                            .clipped()  // Clip overflow to fit the frame
                                            .cornerRadius(20)

                                        Color.black
                                            .opacity(0.4)  // Dark overlay for better text visibility
                                            .cornerRadius(20)
                                    }
                                }

                                HStack {
                                    Image(systemName: itemFavesbool[index] ? "heart.fill" : "heart")
                                        .foregroundColor(itemFavesbool[index] ? .red : .white)
                                        .font(.title)
                                        .padding(10)
                                        .onTapGesture {
                                            toggleFavoriteStatus(for: filteredItems[index])
                                            itemFavesbool[index].toggle()  // Update the favorite status locally
                                        }
                                    Spacer()
                                    Text(filteredItems[index].counrtryName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                            }
                            .frame(height: 150)
                            .frame(width: 360)
                            .cornerRadius(20)  // Ensure consistent corner radius
                            .clipped()  // Clip any overflow
                        } else {
                            Text("Country not found or favorite status missing")
                                .font(.title)
                                .padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func toggleFavoriteStatus(for country: Countries) {
        print("Before toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")
        country.counrtryIsFaves.toggle()
        print("After toggling: \(country.counrtryName) favorite status: \(country.counrtryIsFaves)")

        if let index = countries.firstIndex(where: { $0.counrtryId == country.counrtryId }) {
            countries[index] = country  // Update the country in the list
        }

        saveCountriesToJSON(countries: countries)  // Save the updated data back to JSON
    }
}
