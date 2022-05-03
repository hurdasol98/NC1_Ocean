//
//  CheerUp.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01
//
// 세 번째 탭 뷰로 동기부여가 되는 명언과 사진들이 그리드 형식으로 나열되어 있다.
import SwiftUI
//ImageSet 구조체 - 사진과 설명
class ImageSet: Identifiable{
    var id : Int
    var imageName: String
    var imageText: String
    
    init(_ imageName: String, _ imageText:String, _ id: Int){
        self.imageText = imageText
        self.imageName = imageName
        self.id = id
    }
}
//이미지 모음
var imageSet : [ImageSet] = [
    ImageSet("perpect", "꺠구리가 아니라 개구리 신사!",0),
    ImageSet("nuguri","너구릴구리구리",1),
    ImageSet("iphone","아이폰 최고",2)]

struct CheerUp: View {
    //그리드뷰를 설정하기 위한 열 정의
    var columns : [GridItem] = [GridItem(.adaptive(minimum: 100))]
    
    
    
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
                            NavigationLink(destination: CheerUpDetail(id:img.id)){
                                VStack{
                                    Image(String(img.imageName))
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

//struct CheerUp_Previews: PreviewProvider {
//    static var previews: some View {
//        CheerUp(selectedPage: 0)
//    }
//}
