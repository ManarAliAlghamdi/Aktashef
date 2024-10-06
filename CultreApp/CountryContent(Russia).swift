//
//  CountryContent(Russia).swift
//  CultreApp
//
//  Created by Fai Alharthi on 03/04/1446 AH.
//

import SwiftUI

struct CountryContent_Russia_: View {
    @State private var selectedTab: String? = nil
    @State var categories: [String] = ["نبذة", "الأكل", "كلمات", "أماكن", "انتبه تسويها", "عاداتهم"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                Image("russia") // Corrected image string
                    .resizable()
                    .cornerRadius(10)
                    .frame(height: UIScreen.main.bounds.height * 0.22)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
                
                Text("روسيا")
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
                
                ScrollView {
                    Spacer()
                    if let selectedTab = selectedTab {
                        Text(contentForTab(selectedTab))
                            .font(.title3)
                            .foregroundColor(.brown)
                            .padding()
                            .multilineTextAlignment(.trailing) // Right-align the text
                            .frame(alignment: .trailing)
                            .padding(.trailing, 10)
                    } else {
                        Text("وش حاب تعرف عن روسيا؟")
                            .foregroundColor(.brown)
                            .padding()
                            .multilineTextAlignment(.trailing) // Right-align the text
                    }
                }
                Spacer()
            }
        }
    }
    
    // Function to return content for each tab
    func contentForTab(_ tab: String) -> String {
        switch tab {
        case "نبذة":
            return "بريطانيا هي دولة أوروبية..."
        case "الأكل":
            return "الطعام البريطاني التقليدي يشمل الفيش آند شيبس..."
        case "كلمات":
            return "في بريطانيا، يستخدمون كلمات مختلفة مثل: Loo تعني حمام..."
        case "أماكن":
            return "لندن هي عاصمة بريطانيا وفيها معالم مثل برج لندن..."
        case "انتبه تسويها":
            return "لا تنسَ الوقوف في الطابور وانتظار دورك..."
        case "عاداتهم":
            return "من عاداتهم شرب الشاي في الساعة الخامسة..."
        default:
            return "محتوى غير متاح"
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
    CountryContent_Russia_()
}
