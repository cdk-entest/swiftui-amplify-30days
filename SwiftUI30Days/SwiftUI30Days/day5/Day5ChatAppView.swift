//
//  Day5ChatAppView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 11/11/2022.
//

import SwiftUI
import Amplify

struct Day5Message: Identifiable, Codable {
    var id = UUID()
    var text: String
    var received: Bool
    var timestamp: Date
    
}

class Day5SourceOfTruth : ObservableObject {
    @Published var messages = [Message]()
    
    init(){
        self.messages = []
    }
    
    func sendMessage(message: Message){
        self.messages.append(message)
    }
    
    func listMessagesByMyQuery() async {
        let document = """
          query ListMessages {
            listMessages {
                items {
                  id
                  text
                  received
                  createdAt
                  updatedAt
                }
              }
           }
        """
                let request = GraphQLRequest<[Message]>(document: document, responseType: [Message].self, decodePath: "listMessages.items")
//        let request = GraphQLRequest<JSONValue>(document: document, responseType: JSONValue.self)
        
        do {
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(let items):
                Task {
                    @MainActor in
                    self.messages = items
                }
//                print(items)
                
//                if let messageJSON = items.value(at: "listMessages"),
//                   let messagesJSON = messageJSON.value(at: "items"),
//                   let messagesData = try? JSONEncoder().encode(messagesJSON),
//                   let messages = try? JSONDecoder().decode([Message].self, from: messagesData) {
//                    Task { @MainActor in
//                        self.messages = messages
//                    }
//                }
                
            case .failure(let error):
                print("error \(error)")
            }
        }
        catch {
            print("amplify error ")
        }
    }
    
    func listMessages() async {
        do {
            let request = GraphQLRequest<Message>.list(Message.self)
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(let items):
                Task {@MainActor in
                    self.messages = items
                }
            case .failure(let error):
                print("error \(error)")
            }
            
        } catch let error as DataStoreError {
            print("error datastore amplify \(error)")
        }
        catch {
            print("amplify error ")
        }
    }
    
    func createMessage(message: Message) async {
        do {
            let result = try await Amplify.API.mutate(request: .create(message))
            print(result)
        } catch {
            print("amplify error")
        }
    }
    
    func subscribeMessage() async {
        let sub = Amplify.API.subscribe(request: .subscription(of: Message.self, type: .onCreate))
        
        Task {
            do {
                for try await subEvent in sub {
                    switch subEvent {
                    case .connection(let subConnectionState):
                        print("sub connection state \(subConnectionState)")
                    case .data(let result):
                        switch result {
                        case .success(let createMessage):
                            print("create message \(createMessage)")
                            Task {@MainActor in
                                self.messages.append(createMessage)
                            }
                        case .failure(let error):
                            print("got failed result \(error)")
                        }
                    }
                }
            } catch {
                print("subscription error \(error)")
            }
        }
    }
}

struct Day5MessageBubble : View {
    var message: Message
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.received! ? .leading : .trailing) {
            HStack {
                Text(message.text!)
                    .padding()
                    .background(message.received! ? Color.green.opacity(0.3) : Color.pink.opacity(0.3))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received! ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(Date().formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(Color.black)
                    .padding(message.received! ? .leading : .trailing, 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received! ? .leading : .trailing)
        .padding(message.received! ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct Day5RoundedCorner : Shape {
    
    var radius : CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Day5CustomTextField : View {
    
    @ObservedObject var sot : Day5SourceOfTruth
    @State private var message = ""
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if message.isEmpty {
                    Text("enter a your message here")
                        .opacity(0.5)
                }
                TextField("", text: $message, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
            }
            Button {
                Task {
                    await sot.createMessage(message: Message(text: message, received: true, createdAt: Temporal.DateTime(Date())))
                    message=""
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(Color.purple)
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(30)
        .padding()
        
    }
}


struct Day5ChatAppView: View {
    
    @ObservedObject var sot : Day5SourceOfTruth
    
    var body: some View {
        VStack {
            VStack {
                Day5TileRow()
                ScrollView {
                    ForEach(self.sot.messages){ message in
                        Day5MessageBubble(message: message)
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .clipShape(Day5RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
            }
            .background(Color.orange.opacity(0.3))
            
            Day5CustomTextField(sot: sot)
        }
        .task {
            await sot.listMessagesByMyQuery()
            //            await sot.listMessages()
            //            await sot.subscribeMessage()
        }
    }
}

struct Day5TileRow: View {
    var imageUrl = URL(string: "https://haitran-swincoffee-demo.s3.ap-southeast-1.amazonaws.com/image_9.jpeg")
    var name = "Hai Tran"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                Text("Online")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill")
                .foregroundColor(Color.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
        }
        .padding()
    }
}

struct Day5ChatAppView_Previews: PreviewProvider {
    
    @StateObject static var sot = Day5SourceOfTruth()
    
    static var previews: some View {
        //        Day5MessageBubble(message: Day5Message(text: "Hello Hai? How are you doing today? I would like to ask you a question regarding to you DA shadow next week?", received: false, timestamp: Date()))
        
        Day5ChatAppView(sot: sot)
        //        Day5CustomTextField()
    }
}


