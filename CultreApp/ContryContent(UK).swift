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
                        Text("وش حاب تعرف عن بريطانيا؟")
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
            return "بريطانيا، اللي تُعرف أيضاً بالمملكة المتحدة، تتكون من أربع دول: إنجلترا، اسكتلندا، ويلز، وأيرلندا الشمالية. لندن هي العاصمة وتعتبر واحدة من أكبر المدن في العالم. \n عندهم تاريخ طويل وغني، بدءاً من العصور الوسطى إلى الثورة الصناعية. في بريطانيا غالباً معتدل وممطر، وهذا يجعل الطبيعةالمناخ  فيها خضراء وخلابة. \nالبريطانيين معروفين بأدبهم واهتمامهم بالثقافة، وتلقاهم يحبون الفنون والموسيقى. عندهم تقاليد عريقة، مثل احتفالات عيد الميلاد وعيد الفصح، والاحتفال بالزفاف الملكي، اللي يجذب انتباه العالم."
        case "الأكل":
            return ": Fish and Chips\nسمك مقلي مع بطاطس، هذا طبق مشهور مر عندهم.\n\n: Full English Breakfast\n فطورهم التقليدي، يتكون من بيض، بيكون، فاصوليا، ومشروم، وأحياناً سجق.\n\n: Sunday Roast\nفي العادة يقدم يوم الأحد، ويتكون من لحم مشوي مع بطاطس وخضار.\n\n: Tea and Biscuits \n الشاهي مع البسكويت يعتبر وجبة خفيفة مهمة عندهم، خصوصاً العصر."
        case "كلمات":
            return ": Cheers\n يعني شكراً، بس يستخدمونها حتى عشان يقولون وداعاً.\n\n: Mate \n تعني يا صاحبي أو يا خوي، تستخدم بشكل غير رسمي.\n\n: Bloody\n يجي بمعنى مره أو جداً، يستخدمونه للتأكيد. \n\n: Loo \nالمقصود الحمام.\n\n: Queue \nالطابور أو الانتظار"
        case "أماكن":
            return "الحانات (البوبس): \n البريطانيين يعشقون الجلوس بالحانات، هذي أماكن يتجمعون فيها مع أصحابهم، يشربون، ياكلون، ويتابعون المباريات. وغالباً يكون فيه مسابقات معلومات عامة.​\n\n المنتزهات:\n البريطانيين مره يحبون الطبيعة ويطلعون للحدائق مثل هايد بارك بلندن، خصوصاً إذا الجو كان حلو ومشمس​\n"
        case "انتبه تسويها":
            return" تتخطى الطابور :\n يتخطى الطابور، بيعتبرونها قلة احترام.\n\n الكلام العالي في الأماكن العامة:\n البريطانيين معروفين بالهدوء، فلو رفعت صوتك في مكان عام ممكن ينزعجون.\n\n الحديث عن الفلوس: \nالحديث المباشر عن الدخل أو  الفلوس يعتبر  غير مناسب في أغلب الأحيان "
        case "عاداتهم":
            return "البريطانيين يحبون الاصطفاف بالطابور لأي شيء، ويعتبرونه جزء من الاحترام.\n\n.يعتذرون كثير، حتى لو على شيء بسيط \n\n يشربون الشاهي بكثرة و الشاهي عندهم يعتبر جزء من حياتهم اليومية وأكثر وقت لشربه العصر \n\nيعطون بعضهم -تشيرز-: لما يسلمون على بعض أو حتى لما يشكرون بعضهم، يستخدمون كلمة -تشيرز- بدال شكراً أو سلام"
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
    ContryContent_UK()
}
