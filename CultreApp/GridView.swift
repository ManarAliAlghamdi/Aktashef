import SwiftUI
// Data model for a country
struct Country: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    var isFavorite: Bool
}

struct Joudy: View {
    
       // Sample data for the grid
       @State private var countries = [
           Country(name: "بريطانيا", imageName: "uk", isFavorite: true),
           Country(name: "روسيا", imageName: "russia", isFavorite: false),
           Country(name: "سنغافوره", imageName: "singapore", isFavorite: false),
           Country(name: "امريكا", imageName: "usa", isFavorite: false),
           Country(name: "اليونان", imageName: "greece", isFavorite: false),
           Country(name: "اسبانيا", imageName: "spain", isFavorite: false),
           Country(name: "هولندا", imageName: "netherlands", isFavorite: false),
           Country(name: "النمسا", imageName: "austria", isFavorite: false)
       ]
       
       // Grid layout with 4 columns
       let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    
    var body: some View {
        NavigationView {
        VStack {
        Spacer()}.navigationBarItems(leading:
 HStack {
 Button(action: {
     // Action for list icon
     print("List icon tapped")}) {
    Image(systemName: "line.horizontal.3")
    .imageScale(.large)
    .foregroundColor(.black) // Change color if needed
     }

     // Adding space between icons
     Spacer().frame(width: 16)
         Button(action: {
          // Action for grid icon
       print("Grid icon tapped")})
            {Image(systemName: "square.grid.2x2").imageScale(.large)
                    .foregroundColor(.black) // Change color if needed
            }
                       }
    , trailing:
    Button(action: {
  // Action for favorite button
    print("Favorite button tapped")}) {
    Image(systemName: "heart").imageScale(.large).foregroundColor(.black)})}
        
    }// End of Body
}// End of View

#Preview {
    Joudy()
}
