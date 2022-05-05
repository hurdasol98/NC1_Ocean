//
//  ContactsDetail.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//
//두 번재 탭 뷰의 서브뷰,각 사람에게 코멘트를 남길 수 있다.
import SwiftUI

struct ContactsDetail: View {
    
    
    @State private var newComent = ""
    @ObservedObject var person: Person
    var body: some View {
        
        VStack{
           
            
            Image("\(person.imageURL)")
                .resizable()
                .frame(width:125, height: 125)//이미지
            Text("\(person.name + " | " + person.nickName)")
                .font(.title)
            Spacer(minLength: 10)
            Text("\(person.department)")
            Text("\(person.feature + " | " + String(person.age) + " | " + person.job)")
            
            List{
                ForEach(person.comments, id: \.self){comment in
                    Text(comment)
                        .font(Font.system(size: 20))
                        
                }.listStyle(.inset)
            }.padding(.top)
            .navigationTitle(Text("사람들!"))
            .listStyle(.inset)
            //코멘트 남기기 - (text를 치지 않으면 엔터 불가로 만들기)
            HStack{
                TextField("'\(person.nickName)'에게 코멘트를 남겨주세요!",text: $newComent, onCommit: {
                    person.comments.append(newComent)
                    newComent = ""
                }).disableAutocorrection(true)  //추천단어 끄기
                Button(action:{
                    self.newComent = ""
                })
                {
                    Image(systemName: "x.circle").font(.title).foregroundColor(.gray)
                }
            }.padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.green,lineWidth: 1))
        }
    }
}


struct ContactsDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactsDetail(person: ocean)
    }
}
