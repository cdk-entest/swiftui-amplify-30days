//  ContentView.swift
//  swiftui-network-call
//  Created by MINH HAI, TRAN on 14/10/2022.

import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    func fetch() {
        print("fetch api")
        let url =  URL(string: "https://iosacademy.io/api/v1/courses/index.php")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            } catch {
               print(error)
            }
        }.resume()
        
    }
}

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 130, height: 70)
                .background(Color.gray)
        } else {
            Image("")
                .resizable()
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear(perform: fetchData)
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.data = data
        }.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.courses, id: \.self) {course in
                        URLImage(urlString: course.image)
                                .frame(width: 130, height: 70)
                                .background(Color.gray)
                            Text(course.name)
                                .bold()
                        }
                        .padding(3)
                    }
                .navigationTitle("Courses")
//                .onAppear(perform: viewModel.fetch)
                }
            
            VStack {
                Spacer()
                Button (action: viewModel.fetch){
                    Text("Fetch")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .frame(width: 200)
                        .clipped()
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
        }
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
