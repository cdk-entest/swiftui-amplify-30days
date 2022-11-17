//
//  Day3IeltsView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 09/11/2022.
//

import SwiftUI

struct Day3IeltsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

let content = "1 As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. 1 As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. 1 As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. 1 As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text. As you can see, I'm really struggling to create a simple multi-line Text. The closest I got so far is putting it in a List instead of a ScrollView, but then I get a line under the text."

struct Question {
    var question: String
    var optionA: String
    var optionB: String
    var optionC: String
    var optionD: String
    var selected: Int = -1
}

class QuestionModel: ObservableObject {
    @Published var questions: [Question] = [
        Question(question: "What is the highest paid programming language in the world in 2021? What is the highest paid programming language in 2021?", optionA: "C", optionB: "C++", optionC: "Python", optionD: "Swift"),
        Question(question: "What is the highest paid programming language in the world in 2022", optionA: "C", optionB: "C++", optionC: "Python", optionD: "Swift"),
        Question(question: "What is the highest paid programming language in the world in 2023", optionA: "C", optionB: "C++", optionC: "Python", optionD: "Swift"),
        Question(question: "What is the highest paid programming language in the world in 2024", optionA: "C", optionB: "C++", optionC: "Python", optionD: "Swift"),
        Question(question: "What is the highest paid programming language in the world in 2025", optionA: "C", optionB: "C++", optionC: "Python", optionD: "Swift")
    ]
}

struct QuestionScrollView :View {
    @Binding var questionViewHeight: CGFloat
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(0..<5){index in
                    HStack {
                        Button(action: {
                            self.questionViewHeight = UIScreen.main.bounds.height / 20
                        }){
                            Text("Hide")
                        }
                        Button(action: {
                            self.questionViewHeight = UIScreen.main.bounds.height / 3
                        }){
                            Text("Show")
                        }
                        Text("QuestionView")
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: self.questionViewHeight)
                    .background(Color.green.opacity(1.0))
                }
            }
        }
        
    }
}

struct OptionRowView : View {
    @Binding var selected: Int
    var index: Int
    
    var body: some View {
        HStack{
            Text("Option \(index)")
            Spacer()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(self.selected == self.index ? Color.green : Color.white)
        .cornerRadius(8)
        .onTapGesture {
            self.selected = self.index
        }
    }
}

struct QuestionView :View {
    @State var isCollapse: Bool = false
    @State var selectedOption: Int = -1
    @State var currentIndex: Int = 0
    @ObservedObject var sot = QuestionModel()
    
    var body: some View {
        VStack{
            HStack(){
                Button(action:{
                    self.prevQuestion()
                }){
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .foregroundColor(Color.white)
                }
                Spacer()
                Button(action:{
                    self.isCollapse.toggle()
                }){
                    Image(systemName: self.isCollapse ? "chevron.up" : "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(Color.white)
                }
                Spacer()
                Button(action:{
                    self.nextQuestion()
                }){
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
                //            .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color("collapse"))
            
            Spacer(minLength: 0)
            
            Group(){
                if self.isCollapse {
                    EmptyView()
                } else {
                    List{
                        Section(header: Text(self.sot.questions[self.currentIndex].question)) {
                            ForEach(0..<4){index in
                                OptionRowView(selected: self.$sot.questions[self.currentIndex].selected, index: index)
                            }
                            .listRowBackground(Color.white)
                        }
                    }
                    .padding(.top,0)
                }
            }
            
            Spacer()
        }
            //        .frame(maxWidth: .infinity)
            .frame(height: self.isCollapse ? 0 : UIScreen.main.bounds.height / 2.5)
            .background(Color.white)
    }
    
    func nextQuestion(){
        self.currentIndex = (self.currentIndex + 1) < self.sot.questions.count ? self.currentIndex + 1 : 0
    }
    
    func prevQuestion(){
        self.currentIndex = (self.currentIndex - 1) > -1 ? self.currentIndex - 1 : self.sot.questions.count - 1
    }
}


struct ReadingView: View {
    var body: some View {
        GeometryReader {width in
            ZStack{
                ScrollView{
                    Text(content)
                }
                .padding()
                VStack{
                    Spacer()
                    QuestionView()
                }
                //                .padding()
            }
            .padding([.top, .bottom])
        }
    }
}


struct TestOptionView : View {
    var index: Int
    @Binding var selected: Int
    
    var body: some View {
        Text("Option \(self.index)")
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
            .background(self.selected == self.index ? Color("option") : Color.white)
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            .onTapGesture {
                self.selected = self.index
        }
    }
}

struct TestQuestionView : View {
    @State var hideQuestion: Bool = false
    @ObservedObject var sot = QuestionModel()
    @State var currentIndex: Int = 0
    @State var selected: Int = -1
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    self.hideQuestion.toggle()
                }){
                    Image(systemName: self.hideQuestion ? "chevron.up" : "chevron.down")
                }
                Spacer()
                Text("Question 1/\(11)")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color("collapse"))
            .foregroundColor(Color.white)
            
            Group(){
                if self.hideQuestion {
                    EmptyView()
                } else {
                    ScrollView{
                        VStack(spacing: 4){
                            Text(self.sot.questions[self.currentIndex].question)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
                                .cornerRadius(5)
                            VStack(spacing: 4){
                                ForEach(0..<4){index in
                                    TestOptionView(index: index,
                                                   selected: self.$sot.questions[self.currentIndex].selected)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 5)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 3)
                }
            }
        }
        .background(Color("question"))
    }
}

struct TestReadingView : View {
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Spacer()
                TestQuestionView()
            }
        }
    }
}


struct TestBorderView : View  {
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                
                Text("Click")
                .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color.green)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.red, lineWidth: 2))
                
                
                Button(action: {
                    print("Tap")
                }){
                    Text("Click")
                        .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .background(Color.green)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.red, lineWidth: 2))
            }
            .padding([.leading, .trailing], 5)
        }
        
    
    }
}

