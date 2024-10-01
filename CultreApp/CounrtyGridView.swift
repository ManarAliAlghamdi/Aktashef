import SwiftUI

struct CountryGridView: View {
    @Binding var showCountryFaves: Bool

    @State private var searchText = ""
    @State private var itemFavesbool = [Bool](repeating: false, count: 3)
    
    let items = [
        Locations(name: "بريطانيا", imageName: "britain"),
        Locations(name: "روسيا", imageName: "russia"),
        Locations(name: "اليابان", imageName: "japan"),
    ]

    var filteredItems: [Locations] {
        let searchedItems = searchText.isEmpty ? items : items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }

        if showCountryFaves {
            return searchedItems.enumerated().compactMap { index, item in
                // Get the correct favorite status using the original index
                let originalIndex = items.firstIndex(where: { $0.name == item.name })!
                return itemFavesbool[originalIndex] ? item : nil
            }
        } else {
            return searchedItems
        }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            // Search Bar
            TextField("على وين رايح؟ ..", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
            // Grid layout for items
            ScrollView
            {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredItems.indices, id: \.self) { index in
                        ZStack(alignment: .bottom) {
                            GeometryReader { geometry in
                                Image(filteredItems[index].imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                                    .cornerRadius(20)
                                    .overlay(
                                        Color.black
                                            .opacity(0.4)
                                            .cornerRadius(20)
                                    )
                                
                                VStack {
                                    Spacer()
                                    HStack {
                                        // Find the original index to access the correct favorite status
                                        let originalIndex = items.firstIndex(where: { $0.name == filteredItems[index].name })!

                                        Image(systemName: itemFavesbool[originalIndex] ? "heart.fill" : "heart")
                                            .foregroundColor(itemFavesbool[originalIndex] ? .red : .white)
                                            .font(.title)
                                            .padding(10)
                                            .onTapGesture {
                                                itemFavesbool[originalIndex].toggle()
                                                print("\(filteredItems[index].name) favorite status changed to \(itemFavesbool[originalIndex])")
                                            }
                                        Spacer()
                                        
                                        Text(filteredItems[index].name)
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
                .padding()
            }
        }
    }
}

#Preview {
    CountryGridView(showCountryFaves: .constant(true))
}
