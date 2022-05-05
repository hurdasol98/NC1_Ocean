//
//  Me.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//
//첫 번째 탭 뷰로 메인화면, 자신의 상태와 코멘트들을 볼 수 있다.
import SwiftUI

//관측가능한 객체 Person클래스 //cvaoments를 제외하곤 변경이 안됨 --> comments를 분리하여 이것만 바인딩하기
class Person: ObservableObject, Identifiable{
    @Published var id :String = ""
    @Published var name: String = "이름"
    @Published var nickName: String = "닉네임"
    @Published var age: Int = 25
    @Published var imageURL : String = "perfect"
    @Published var feature : String = "특성"
    @Published var job: String = "직업"
    @Published var department : String = "애플아카데미"
    @Published var comments: [String] = []
    //초기화
    init(_ name: String,_ nickName: String,_ age: Int,_ imageURL : String,_ feature : String,_ job: String,_ comments: [String]){
        self.name = name
        self.nickName = nickName
        self.age = age
        self.imageURL = imageURL
        self.feature = feature
        self.job = job
        self.comments = comments
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
var yung: Person = Person("융식","나무늘보",33,"iphone", "개발자", "직장인", ["데이터를 관리하는 모습이 멋져",
                                                                  "깃허브는 어떻게 쓰는건가요?",
                                                                  "블로그 이웃해요?"])
var cho: Person = Person("Cho", "케이크", 28, "cho", "개발자", "CEO", ["나쁜 사람!","도비 이즈 배드!","도비 is free"])
var hoaxer: Person = Person("Hoaxer", "기만자", 25, "great", "개발자", "아이언맨", ["그는 대단해","그는 신이야","시속 220km"])
//Person들의 모음 people
var people =  [ocean, juny, yung, cho, hoaxer]

struct Me: View {
    @State var showingConfirmation = false
    
    @StateObject var person: Person
    var body: some View {
        VStack{
            
            Image("\(person.imageURL)")
                .resizable()
                .frame(width:125, height: 125)//이미지
            Text("\(person.name + " | " + person.nickName)")
                .font(.title).bold()
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
                
                ForEach(person.comments, id: \.self){comment in
                    Text(comment)
                    
                        .font(Font.system(size: 20))
                }
                .onDelete(perform: delete)
                .onMove(perform: moveRow)
                .listStyle(.inset)
                .confirmationDialog(Text("이 내용을 삭제하겠습니까? 이 내용이 사용자의 모든 기기에서 삭제됩니다."), isPresented: $showingConfirmation,titleVisibility: .visible){
                    Button("Delete",role: .destructive){
                        
                    }
                    Button("Cancle", role: .cancel){
                        
                    
                    }
                }
//                .alert(isPresented: $showingAlert){
//                    Alert(title: Text("삭제각?"), message: Text("되돌리기 없음"), primaryButton: .destructive(Text("취소")){
//
//                    },secondaryButton: .cancel(Text("좋아")))
//                }
            }
        }
        .padding(.top)
        .navigationTitle(Text("나!"))
        .listStyle(.inset)
        
        
    }
    
    //삭제 기능
    func delete(at indexes:IndexSet){
        if let first = indexes.first{
            showingConfirmation = true
            person.comments.remove(at:first)
        }
    }
    //줄 바꾸기 기능 //처음이거나 마지막으로 목록을 옮기면 오류가 생김 --> move로 해결
    func moveRow(from indexes:IndexSet, to destination: Int){
        person.comments.move(fromOffsets: indexes, toOffset: destination)
    }
}

struct Me_Previews: PreviewProvider {
    static var previews: some View {
        Me(person: ocean)
    }
}
