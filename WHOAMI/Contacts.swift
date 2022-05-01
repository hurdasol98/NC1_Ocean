//
//  Contacts.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//

import SwiftUI

struct Contacts: View {
    
    @StateObject var person: Person
    var body: some View {
        NavigationView{
            
            //List people을 받고 반복, 선택한걸 네비게이션 링크로 보냄
            List(people, id:\.nickName){person in
                NavigationLink(destination: ContactsDetail(person: person)){
                    LazyHStack(alignment: .center){
                        Image(person.imageURL)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width:125, height: 125)
                            .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 20){
                            Text("\(person.name + " | " + person.nickName)").font(Font.title2).bold()
                            Text("\(person.department)")
                            Text("\(person.feature + " | " + String(person.age) + " | " + person.job)")
                            
                            
                        }
                    }.navigationTitle(Text("사람들"))
                        
                    
                }
                
            }
        }
    }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts(person: ocean)
    }
}
