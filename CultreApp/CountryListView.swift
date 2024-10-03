import SwiftUI


struct CountryListView: View {
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
                // Check the original index from `items` to get the correct favorite status
                let originalIndex = items.firstIndex(where: { $0.name == item.name })!
                return itemFavesbool[originalIndex] ? item : nil
            }
        } else {
            return searchedItems
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                // Search Bar
                TextField("على وين رايح؟ ..", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal)
                //            }
                
                // ListViewBuilder
                List {
                    ForEach(filteredItems.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            NavigationLink(destination:ContryContent_UK())
                            { 
                                
                                
                                
                                ZStack(alignment: .bottomTrailing) {
                                    Image(filteredItems[index].imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipped()
                                        .cornerRadius(20)
                                    
                                    Color.black
                                        .opacity(0.4)
                                        .cornerRadius(20)
                                    
                                    HStack {
                                        // Find the original index from the `items` list to manage favorites properly
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
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(10)
                                    }
                                }
                                .frame(height: 150)
                            }
                            
                        }
                        
                        .frame(height: 150)
                    }.navigationBarBackButtonHidden(true)
                    
                }
                
            }
            .listStyle(PlainListStyle())
        }}
    
    
}

                                  #Preview {
                                      CountryListView(showCountryFaves: .constant(false))
                                  }

