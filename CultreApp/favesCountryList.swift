import SwiftUI
struct FavesCounrtyListView: View {
    @State private var searchText = ""
    @State private var itemFavesbool = [Bool](repeating: true, count: 2)
    //يستخدم للليست تبع المدن اللي داخله بالمفضله
    let items = [
        Locations(name: "بريطانيا", imageName: "britain"),
        Locations(name: "روسيا", imageName: "russia")
    ]
//للشرط عشان البحث
    var filteredItems: [Locations] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 25))
                    .onTapGesture {
                        print("Grid clicked!")
                    }
                Spacer()
                Image(systemName: "heart.fill")
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
/*هذا يخلي البحث من جهة اليمين*/                .multilineTextAlignment(.trailing)
                .padding(.horizontal)

            // ListViewBulider of items
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

/*يخلي الصوره على سواد*/                           Color.black
                                .opacity(0.4)
/*شكل الصوره يكون مقوس*/         .cornerRadius(20)

                            
                            HStack {
 //يستخدم للشرط اذا مو من المفضل يصير القلب مو احمر
 Image(systemName: itemFavesbool[index] ? "heart.fill" : "heart")
                                    .foregroundColor(itemFavesbool[index] ? .red : .white)
                                 /*حجم القلب*/   .font(.title)
                                /*يستخدم ياخذ مساحات من كل جهه*/    .padding(10)
                                
                                    .onTapGesture {
                                        itemFavesbool[index].toggle()
 /*تنطبع هذي الجمله لما اشيل القلب */ print("test")
                                    }
/*سبيس للقلب */                       Spacer()
                                
                                Text(filteredItems[index].name)
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
    }
}
#Preview {
    FavesCounrtyListView()
}
