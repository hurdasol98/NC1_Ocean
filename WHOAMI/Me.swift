//
//  Me.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//
//첫 번째 탭 뷰로 메인화면, 자신의 상태와 코멘트들을 볼 수 있다.
import SwiftUI

//관측가능한 객체 Person클래스 //cvaoments를 제외하곤 변경이 안됨 --> coments를 분리하여 이것만 바인딩하기
class Person: ObservableObject, Identifiable{
    @Published var id :String = ""
    @Published var name: String = "이름"
    @Published var nickName: String = "닉네임"
    @Published var age: Int = 25
    @Published var imageURL : String = "perfect"
    @Published var feature : String = "특성"
    @Published var job: String = "직업"
    @Published var department : String = "애플아카데미"
    @Published var coments: [String] = []
    //초기화
    init(_ name: String,_ nickName: String,_ age: Int,_ imageURL : String,_ feature : String,_ job: String,_ coments: [String]){
        self.name = name
        self.nickName = nickName
        self.age = age
        self.imageURL = imageURL
        self.feature = feature
        self.job = job
        self.coments = coments
        self.id = nickName
    }
}

//Person 객체들 생성
var ocean: Person = Person("Ocean","개구리신사", 25, "gentlefrog", "도메인", "대학생",["사람들을 좋아하는게 보여",
 "보면 볼수록 매력적이야",
 "표현이 직설적이라서 상처야..",
 "열심히 하는 모습이 멋져"])

var juny: Person = Person("주니","곰돌이",23,"nuguri", "디자인", "제빵사", ["디자인을 잘 뽑으세요!",
                             "감각적인 사람",
                             "느려서 답답해"])
var yung: Person = Person("융식","나무늘보",23,"iphone", "개발자", "직장인", ["데이터를 관리하는 모습이 멋져",
                             "깃허브는 어떻게 쓰는건가요?",
                             "블로그 이웃해요?"])
//Person들의 모음 people
var people =  [ocean, juny, yung]

struct Me: View {
    @StateObject var person: Person
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
            HStack{
                Spacer()
                //Edit 버튼
            EditButton()
                    .padding(.trailing, 20.0)
            }
            
            List{
                
                ForEach(person.coments, id: \.self){coment in
                    Text(coment)
                        
                        .font(Font.system(size: 20))
                }
                .onDelete(perform: delete)
                .onMove(perform: moveRow)
                .listStyle(.inset)
                    
            }
            .padding(.top)
            .navigationTitle(Text("나!"))
            .listStyle(.inset)
            
            
        }
        
        }
    //삭제 기능
    func delete(at indexes:IndexSet){
        if let first = indexes.first{
            person.coments.remove(at:first)
        }
    }
    //줄 바꾸기 기능 //처음이거나 마지막으로 목록을 옮기면 오류가 생김 --> move로 해결
    func moveRow(from indexes:IndexSet, to destination: Int){
            person.coments.move(fromOffsets: indexes, toOffset: destination)
}
}

struct Me_Previews: PreviewProvider {
    static var previews: some View {
        Me(person: ocean)
    }
}
