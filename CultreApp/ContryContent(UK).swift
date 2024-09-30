//
//  ContryContent(UK).swift
//  CultreApp
//
//  Created by Fai Alharthi on 27/03/1446 AH.
//

import SwiftUI

struct ContryContent_UK_: View {
    @State var categories:[String]=["نبذة","الأكل","كلمات","اماكن","انتبه تسويها","عاداتهم"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing){
                Image(.london).resizable()
                    .cornerRadius(10)
                    .frame( height: UIScreen.main.bounds.height * 0.22)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
                
                Text("بريطانيا")
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.02,alignment: .trailing)
                    .padding()
                    .padding(.top, 100)
                    .bold()
                    .font(.largeTitle)
                    .italic()
                    .shadow(color:.black ,radius:10)
               
            }.padding()//end of zstack

            
                
                    ZStack{
                        RoundedRectangle(cornerRadius:16)
                            .fill(Color.myGray)
                            .frame(width:UIScreen.main.bounds.width * 1.3, height: UIScreen.main.bounds.height * 0.04)
                        
                        HStack(){
                            
                            ForEach(categories,id:\.self){
                                cate in
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.myBrown)
                                        .frame(width:UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.03)
                                    Text(cate)
                                        .foregroundStyle(.white)
                                }
                                
                            }
                        }
                    }.frame(width:.infinity, height: UIScreen.main.bounds.height * 0.05)
                    .padding(0)
                        
                    
                
            
            Spacer()
            
        }
    }
}


#Preview {
    ContryContent_UK_()
}
