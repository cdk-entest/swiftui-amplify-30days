//  Day3NetworkRequestAsync.swift
//  SwiftUI30Days
//  Created by MINH HAI, TRAN on 09/11/2022.
//  call opensearch api using async await
//  parse json by codeable
//  navigationview task to init the api call

import SwiftUI


struct CdkNote : Identifiable {
    let id = UUID()
    let title: String
}

struct MyNote: Codable {
    let DocumentTitle: String
    let DocumentURI: String
}

struct MySource: Codable {
    let _id: String
    let _source: MyNote
}

extension MySource: Identifiable {
    var id: String {return _id}
}

enum ApiError : Error {
    case badRequest
    case badJson
}

class ViewModelDay3 : ObservableObject {
    @Published var notes = [CdkNote]()
    @Published var sources = [MySource]()
    
    init(){
        self.notes = [CdkNote(title: "Hello Lambda"), CdkNote(title: "What is Lambda?")]
    }
    
    func fetchNotes () async throws {
        // url
        guard let url = URL(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs") else {return}
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        // handle response error
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw ApiError.badRequest}
        
        // handle parse error
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw ApiError.badJson
        }
        
        guard let hits = json["hits"] as? [String: Any] else {
            throw ApiError.badJson
        }
        
        guard let ahits = hits["hits"] as? [Any] else {
            throw ApiError.badJson
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ahits, options: [])
            let result = try JSONDecoder().decode([MySource].self, from: jsonData)
            Task {@MainActor in
                self.notes = [CdkNote(title: "What is Lambda?")]
                self.sources = result
            }
        } catch {
            throw ApiError.badJson
        }
    }
}

struct Day3NetworkRequestAsync: View {
    
    @StateObject var viewModel = ViewModelDay3()
    
    var body: some View {
        NavigationView{
            List(viewModel.notes) {note in
                Text(note.title)
            }
            .navigationTitle("CDK Notes")
        }
        .task {
//            try? await viewModel.fetchNotes()
        }
    }
}

