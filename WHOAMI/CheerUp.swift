//
//  CheerUp.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01
//
// 세 번째 탭 뷰로 동기부여가 되는 명언과 사진들이 그리드 형식으로 나열되어 있다.
import SwiftUI

struct CheerUp: View {
    //그리드뷰를 설정하기 위한 열 정의
    var columns : [GridItem] = [GridItem(.adaptive(minimum: 100))]
    //ImageSet 구조체 - 사진과 설명
    struct ImageSet:Identifiable{
        var id :String = ""
        var imageName: String
        var imageText: String
        init(imageName: String, imageText: String){
            self.imageName = imageName
            self.imageText = imageText
            self.id = imageName //id에 imageName부여함
        }
    }
    //이미지 모음
    var imageSet : [ImageSet] = [
        ImageSet(imageName: "perpect", imageText: "꺠구리가 아니라 개구리 신사!"),
        ImageSet(imageName: "nuguri", imageText: "너구릴구리구리"),
        ImageSet(imageName: "iphone", imageText:"아이폰 최고")]
    
    
    var body: some View {
        NavigationView{
            VStack{
                //명언들은 따로 모아놓고 랜덤으로 뺴서 보이기
                Text("개미는 뚠뚠 오늘도 뚠뚠 \n열~심히 일하네 뚠뚠").font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(imageSet){ img in
                            NavigationLink(destination:CheerUpDetail(imageName: img.imageName, imageText: img.imageText)){
                                VStack{
                                    Image(img.imageName)
                                        .resizable()
                                        .cornerRadius(20)
                                        .frame(width:125, height: 125)
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
            }.navigationTitle(Text("CheerUp!"))
                
        }
        
    }
}

struct CheerUp_Previews: PreviewProvider {
    static var previews: some View {
        CheerUp()
    }
}
