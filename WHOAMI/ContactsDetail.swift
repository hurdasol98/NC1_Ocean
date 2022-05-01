//
//  ContactsDetail.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//

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
                ForEach(person.coments, id: \.self){coment in
                    Text(coment)
                        .font(Font.system(size: 20))
                }.listStyle(.inset)
            }.padding(.top)
            .navigationTitle(Text("사람들!"))
            .listStyle(.inset)
            
            HStack{
                TextField("'\(person.nickName)'에게 코멘트를 남겨주세요!",text: $newComent, onCommit: {
                    person.coments.append(newComent)
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
        ContactsDetail(person: juny)
    }
}