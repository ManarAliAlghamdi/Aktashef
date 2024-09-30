import SwiftUI

struct Joudy: View {
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
