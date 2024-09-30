import SwiftUI
//
struct locations: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct Joudy: View {
    
    @State private var searchText = ""
    @State private var itemFavesbool = [Bool](repeating: false, count: 3)
    
let items = [
        locations(name: "بريطانيا", imageName: "britain"),
        locations(name: "روسيا", imageName: "russia"),
        locations(name: "اليابان", imageName: "japan"),]
    
var filteredItems: [locations] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            HStack {
    Image(systemName: "square.grid.2x2").font(.system(size: 25)).onTapGesture {
      print("Grid clicked!")}
                Spacer()
                Image(systemName: "heart")
                    .font(.system(size: 25))
                    .foregroundColor(.red)
                    .onTapGesture {
                        print("heart clicked!")
                    }
            }
            .padding(.bottom, 10)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            
            // Search Bar
            TextField("على وين رايح؟ ..", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)

            // ListViewBuilder of items
            List {
    ForEach(filteredItems.indices, id: \.self) { index in
                    GeometryReader { geometry in
ZStack(alignment: .bottomTrailing) {
    HStack{
        
        
        
        
        
    }
                            Image(filteredItems[index].imageName) // Use filteredItems here
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
                                        print("test")
                                    }
                                Spacer()
                                
                                Text(filteredItems[index].name) // Use filteredItems here
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                        }
                        .frame(height: 150)
                        .onTapGesture {
                            print("\(filteredItems[index].name) clicked")
                        }
                    }
                    .frame(height: 150)
                }
            }
            .listStyle(PlainListStyle())
        }
        
    }// End of Body
}// End of View

#Preview {
    Joudy()
}
