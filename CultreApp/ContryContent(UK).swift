//
//  ContryContent(UK).swift
//  CultreApp
//
//  Created by Fai Alharthi on 27/03/1446 AH.
//


import SwiftUI

struct ContryContent_UK: View {
    @State private var selectedTab: String? = nil
    @State var categories: [String] = ["نبذة", "الأكل", "كلمات", "أماكن", "انتبه تسويها", "عاداتهم"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                Image("london") // Corrected image string
                    .resizable()
                    .cornerRadius(10)
                    .frame(height: UIScreen.main.bounds.height * 0.22)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
                
                Text("بريطانيا")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.02, alignment: .trailing)
                    .padding()
                    .padding(.top, 100)
                    .bold()
                    .font(.largeTitle)
                    .italic()
                    .shadow(color: .black, radius: 3)
            }
            .padding() // End of ZStack
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.myGray)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.039)
                        .shadow(radius: 2)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 1) {
                            ForEach(categories, id: \.self) { cate in
                                ZStack {
                                    
                                    TabButton(title: cate, isSelected: selectedTab == cate) {
                                        selectedTab = cate
                                    }
                                }
                            }
                        }
 
                    }
                }
                
                ScrollView{
                    
                    // Display content
                    if let selectedTab = selectedTab {
                        Spacer()
                        Text("\(selectedTab)")
                            .font(.title3)
                            .foregroundColor(.brown)
                            .padding()
                            .frame(alignment: .trailing)
                            .padding(.trailing,10)
                        

                    } else {
                        Spacer()
                        Text(" وش حاب تعرف عن بريطانيا ؟")
                            .foregroundColor(.brown)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
    
    // Custom button component for the tabs
    struct TabButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Text(title)
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .background(isSelected ? Color("MyBrown") : Color("MyGray"))
                .cornerRadius(10)
                .foregroundColor(isSelected ? .white : .gray)
                .onTapGesture {
                    action() // Call the action when tapped
                }
        }
    }
}

#Preview {
    ContryContent_UK()
}

