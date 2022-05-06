//
//  Me.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//
//첫 번째 탭 뷰로 메인화면, 자신의 상태와 코멘트들을 볼 수 있다.
import SwiftUI
import UIKit
//관측가능한 객체 Person클래스 //cvaoments를 제외하곤 변경이 안됨 --> comments를 분리하여 이것만 바인딩하기
class Person: ObservableObject, Identifiable{
    var id :String = ""
    var name: String = "이름"
    var nickName: String = "닉네임"
    var age: Int = 25
    var imageURL : String = "perfect"
    var feature : String = "특성"
    var job: String = "직업"
    var department : String = "애플아카데미"
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
    //    @State var showingAlert = false
    @StateObject var person: Person
        @State var itemToDelete = false
    @Environment(\.dismiss) var dismiss
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
                    .foregroundColor(Color.appMainColor)
            }
            
            List{
                
                ForEach(person.comments, id: \.self){comment in
                    Text(comment)
                    
                        .foregroundColor(.textMainColor)
                        .font(Font.system(size: 20))
            
                }
                .onDelete(perform: delete)
                .onMove(perform: moveRow)
                .listStyle(.inset)
                .confirmationDialog(Text("이 내용을 삭제하겠습니까? 이 내용이 사용자의 모든 기기에서 삭제됩니다."), isPresented: $showingConfirmation,titleVisibility: .visible){
                    Button("Delete",role: .destructive){
                        itemToDelete = true
                        dismiss()
                    }
                    Button("Cancle", role: .cancel){
                        itemToDelete = false
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
//    func delete(at: IndexSet) {
//        for index in at {
//            person.comments.remove(at: index)
//        }
//    }
    func delete(at indexes:IndexSet){
        showingConfirmation = true
        if let first = indexes.first{
            //            showingAlert = true
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
//Color를 확장해서 내가 지정한 컬러를 추가 할 수 있게함
extension Color{
    static let appMainColor = Color("appMainColor")
    
    static let textMainColor = Color("textMainColor")
    static let textSubColor = Color("textSubColor")
}


//Tab View의 스타일을 지정하기 위해서 Color와 View를 확장했다.
extension Color {
  var uiColor: UIColor? {
    if #available(iOS 14.0, *) {
      return UIColor(self)
    } else {
      let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
      var hexNumber: UInt64 = 0
      var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
      let result = scanner.scanHexInt64(&hexNumber)
      if result {
        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        a = CGFloat(hexNumber & 0x000000ff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: a)
      } else {
        return nil
      }
    }
  }
}

extension View {
  func tabViewStyle(backgroundColor: Color? = nil,
                    itemColor: Color? = nil,
                    selectedItemColor: Color? = nil,
                    badgeColor: Color? = nil) -> some View {
    onAppear {
      let itemAppearance = UITabBarItemAppearance()
      if let uiItemColor = itemColor?.uiColor {
        itemAppearance.normal.iconColor = uiItemColor
        itemAppearance.normal.titleTextAttributes = [
          .foregroundColor: uiItemColor
        ]
      }
      if let uiSelectedItemColor = selectedItemColor?.uiColor {
        itemAppearance.selected.iconColor = uiSelectedItemColor
        itemAppearance.selected.titleTextAttributes = [
          .foregroundColor: uiSelectedItemColor
        ]
      }
      if let uiBadgeColor = badgeColor?.uiColor {
        itemAppearance.normal.badgeBackgroundColor = uiBadgeColor
        itemAppearance.selected.badgeBackgroundColor = uiBadgeColor
      }

      let appearance = UITabBarAppearance()
      if let uiBackgroundColor = backgroundColor?.uiColor {
        appearance.backgroundColor = uiBackgroundColor
      }

      appearance.stackedLayoutAppearance = itemAppearance
      appearance.inlineLayoutAppearance = itemAppearance
      appearance.compactInlineLayoutAppearance = itemAppearance

      UITabBar.appearance().standardAppearance = appearance
      if #available(iOS 15.0, *) {
        UITabBar.appearance().scrollEdgeAppearance = appearance
      }
    }
  }
}
