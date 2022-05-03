//
//  CheerUpDetail.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01.
//
// 세 번째 탭 뷰의 서브뷰, 확대된 이미지를 볼 수 있다.d

import SwiftUI

struct CheerUpDetail: View {
    
    @State var id: Int
    var body: some View {
        //탭뷰 페이지모드 구현
        TabView(selection: $id){
            ForEach(imageSet){img in
                VStack{
                    HStack{
                        Spacer()
                        Text("\(String(img.id+1) + " / " + String(imageSet.count))")
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 5))
                            .foregroundColor(.gray)
                          
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
