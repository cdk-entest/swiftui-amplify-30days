---
author: haimtran
title: day 3 async await and json decodable
description: perform network request with async await and decodable
publsihedDate: 11/11/2022
date: 11/11/2022
---

## Introduction

- Network request with async await
- Json decodable
- AsyncImage

## Json Decodable

Define the data models

```swift
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
```

request error handler

```swift
enum ApiError : Error {
    case badRequest
    case badJson
}
```

## Network Request

the ViewModel which perform the api call

```swift
class OpenSearchViewModel : ObservableObject {
    @Published var sources = [MySource]()

    init(){
        self.sources = []
    }

    func fetchNotes () async throws {
        // url
        guard let url = URL(string: $OPENSEARCH_URI) else {return}
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
                self.sources = result
            }
        } catch {
            throw ApiError.badJson
        }
    }
}
```

## Update UI

search text as input textfield and present the list of opensearch results

```swift
struct OpenSearchView: View {
    @StateObject var viewModel = OpenSearchViewModel()
    @State private var searchText = ""

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
```
