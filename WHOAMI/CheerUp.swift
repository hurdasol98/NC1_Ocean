//
//  CheerUp.swift
//  OhAmI
//
//  Created by hurdasol on 2022/05/01
//
// 세 번째 탭 뷰로 동기부여가 되는 명언과 사진들이 그리드 형식으로 나열되어 있다.
import SwiftUI

struct CheerUp: View {
    var columns : [GridItem] = [GridItem(.adaptive(minimum: 100))]
    let data = Array(1...100).map{  //추후 이미지들 모아서 넣기
        "목록\($0)"
    }
    var body: some View {
        NavigationView{
            VStack{
                Text("동기부여 명언").font(.largeTitle) //추후 명언들 모아서 넣기
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20){
                        ForEach(data, id: \.self){ i in
                            NavigationLink(destination:CheerUpDetail()){
                                VStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.green)
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
