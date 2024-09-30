import SwiftUI

//struct nav: View {
//    @State private var showCountryGrid = true
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                if showCountryGrid {
//                    CountryGridView()
//                        .transition(.opacity)
//                    CountryListView()
//                        .transition(.slide).hidden()// Apply transition effect
//                } else {
//                    CountryListView()
//                        .transition(.slide)
//                    CountryGridView()
//                        .transition(.opacity).hidden()// Apply a different transition effect
//                }
//            }
//    }
//}

struct CountryListView: View {
    
    @State private var searchText = ""
    @State private var itemFavesbool = [Bool](repeating: false, count: 3)
    @State private var navigateToGridView = false // State to control navigation
    
    let items = [
        Locations(name: "بريطانيا", imageName: "britain"),
        Locations(name: "روسيا", imageName: "russia"),
        Locations(name: "اليابان", imageName: "japan"),
    ]
    
    var filteredItems: [Locations] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack{
            // Search Bar
            TextField("على وين رايح؟ ..", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
        }
        HStack {
            
            
            
            // List View
            List {
                ForEach(filteredItems.indices, id: \.self) { index in
                    GeometryReader { geometry in
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
                                Image(systemName: itemFavesbool[index] ? "heart.fill" : "heart")
                                    .foregroundColor(itemFavesbool[index] ? .red : .white)
                                    .font(.title)
                                    .padding(10)
                                    .onTapGesture {
                                        itemFavesbool[index].toggle()
                                        print("\(filteredItems[index].name) favorite status changed to \(itemFavesbool[index])")
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
                    .frame(height: 150)
                }
            }
            .listStyle(PlainListStyle())
            
            .background(
                NavigationLink(destination: CountryGridView(), isActive: $navigateToGridView) {
                    EmptyView() // Invisible link that activates navigation
                }
            )
        }
    }
    
}


#Preview {
    CountryListView()
}
