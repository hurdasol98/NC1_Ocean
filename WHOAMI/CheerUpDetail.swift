//
//  CheerUpDetail.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01.
//
// 세 번째 탭 뷰의 서브뷰, 확대된 이미지를 볼 수 있다.d;
import SwiftUI
struct CheerUpDetail: View {
    
    @State var id: Int
    //몇 번재 사진인지 표시하는 text opacity 조절
    @State private var textSwitch = true
    var body: some View {
        
        //탭뷰 페이지모드 구현
        TabView(selection: $id){
            ForEach(imageSet){img in
                VStack{
                    HStack{
                        Spacer()
                        Text("\(String(img.id+1) + " / " + String(imageSet.count))")
                            .padding(.horizontal,5)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.gray)
                            .opacity(textSwitch ? 1 : 0.1)
                            .animation(.easeInOut(duration: 0.2))
                            .onAppear(perform: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    if self.textSwitch == false{
                                        self.textSwitch.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.textSwitch.toggle()
                                    }
                                    
                                }
                            })
                            
                    }.offset(y:40)
                        .zIndex(1)
                    Image(img.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(alignment: .center)
                        .navigationTitle(img.imageText)
                }
            }
            
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        
        
        
        
        
        
        
        
    }
}

struct CheerUpDetail_Previews: PreviewProvider {
    static var previews: some View {
        CheerUpDetail(id: 0)
    }
}
