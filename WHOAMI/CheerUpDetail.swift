//
//  CheerUpDetail.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01.
//
// 세 번째 탭 뷰의 서브뷰, 확대된 이미지를 볼 수 있다.

import SwiftUI

struct CheerUpDetail: View {
    var imageName:String
    var imageText:String
    var body: some View {
        
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .center)
                Spacer()
                //버튼 구현 - 이미지를 (TabView형식)으로 구현하고 하나씩 넘어가는 걸로 만들기 기능만 구현해보고 버튼은 없애버리기
                HStack{
                    Button(action: {
                        
                    }){
                        Text("< 이전 사진")
                            .padding(.leading)
                    }
                    Spacer()
                    Button(action: {
                        
                    }){
                        Text("다음 사진 >")
                            .padding(.trailing)
                    }

                }
                    
            }
            .navigationTitle(imageText)
                
                
                
                
                
        
        
    }
}

struct CheerUpDetail_Previews: PreviewProvider {
    static var previews: some View {
        CheerUpDetail(imageName: "perpect", imageText: "설명란")
    }
}
