//
//  OpenSearchView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 08/11/2022.
//

import SwiftUI

struct Note: Codable {
    let DocumentTitle: String
    let DocumentURI: String
    let DocumentExcerpt: String
}

struct Source: Codable {
    let _id: String
    let _source: Note
}

extension Source: Identifiable {
    var id: String {return _id}
}

struct OpenSearchView: View {
    @StateObject var viewModel = OpenSearchViewModel()
    @State private var searchText = ""
    
    //    init(viewModel: ViewModel = .init()){
    //        _viewModel = StateObject(wrappedValue: viewModel)
    //    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.notes) {note in
                    NavigationLink(destination: Text(note._source.DocumentExcerpt)) {
                        VStack {
                            Text(note._source.DocumentTitle)
                            Text(note._source.DocumentExcerpt)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Look for keywords")
            .onSubmit(of: .search) {
                viewModel.getNotes(query: searchText)
//                searchText = ""
            }
            .navigationTitle("Searchable")
        }
    }
}


class OpenSearchViewModel: ObservableObject {
    @Published var notes = [Source]()
    
    func getNotes(query: String){
        
        let uc = NSURLComponents(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest")!
        uc.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "index", value: "cdk-entest")
        ]
        
        print(uc.url!.absoluteURL)
        
        let task = URLSession.shared.dataTask(with: uc.url!.absoluteURL){
            (data, response, error) in
            guard let data = data else {
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return
            }
            
            guard let hits = json["hits"] as? [String: Any] else {
                return
            }
            
            guard let ahits = hits["hits"] as? [Any] else {
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: ahits, options: [])
                print(jsonData)
                let result = try JSONDecoder().decode([Source].self, from: jsonData)
                DispatchQueue.main.async {
                    self.notes = result
                }
            } catch {
                print("ERROR")
                return
            }
        }
        task.resume()
    }
}

struct OpenSearchView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSearchView()
    }
}
