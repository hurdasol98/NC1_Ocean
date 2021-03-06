//
//  Contacts.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//
//두 번째 탭 뷰로 연락처의 정보를 받아서 List형식으로 보여준다.
//contacts를 불러오는 방법을 익히고 구현하기
import SwiftUI

struct Contacts: View {
    @State private var updatedPeople: [Person] = []
    @State var searchText = ""
    @ObservedObject var person: Person
    
    var body: some View {
        NavigationView{
            VStack{
                
                //List people을 받고 반복, 선택한걸 네비게이션 링크로 보냄
                List(searchText == "" ? people : updatedPeople,id:\.nickName){person in
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
                        }
                        
                        
                        
                    }
//                    .listRowBackground(Color.appMainColor.opacity(0.2))
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color.appMainColor, Color.textSubColor]), startPoint: .leading, endPoint: .trailing)
                    )
                    .navigationTitle(Text("사람들"))
                    
                }
                .onChange(of: searchText) { searchValue in
                    updatedPeople = people.filter { $0.name.lowercased().contains(searchValue.lowercased())
                    }
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .leading, endPoint: .trailing)
            )
                
                
            
        }.searchable(text: $searchText)
    }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts(person: ocean)
    }
}
