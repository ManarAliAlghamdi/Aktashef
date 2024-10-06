//import SwiftUI
//
//struct ContentView: View {
//    @State private var countries: [Countries] = []  // Holds the list of countries
//    @State private var itemFavesbool: [Bool] = []   // Holds the favorite status for each country
//    @State private var isGridView = false  // Tracks whether the grid view is active
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                // Button to toggle between ListView and GridView
//                Button(action: {
//                    isGridView.toggle()  // Switch between list and grid view
//                }) {
//                    Text(isGridView ? "Switch to List View" : "Switch to Grid View")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//
//                // Display the view based on the toggle state (list or grid)
//                if isGridView {
////                    CountryGridView(countries: $countries, itemFavesbool: $itemFavesbool)
//                } else {
//                    CountryListView(countries: $countries, itemFavesbool: $itemFavesbool)
//                }
//            }
//        }
////        .onAppear {
////            loadCountriesAndFavorites()  // Load the data when the view appears
////        }
//    }
//
////    // Function to load the countries and favorite statuses from JSON
////    func loadCountriesAndFavorites() {
////        countries = loadCountries()  // Load countries from JSON
////        
////        // Initialize favorite status based on the data from the JSON file
////        itemFavesbool = countries.map { $0.counrtryIsFaves }
////        
////        // Debugging logs to check what data is loaded
////        for country in countries {
////            print("Loaded country: \(country.counrtryName), favorite status: \(country.counrtryIsFaves)")
////        }
////    }
////}
//
//
//
//
//
