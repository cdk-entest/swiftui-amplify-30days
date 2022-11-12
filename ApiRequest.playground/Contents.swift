// haimtran 08/11/2022
// api request and trailing closure
// parse json basic


import UIKit
import Foundation

let url = URL(string: "https://cdk.entest.io/")!

let task = URLSession.shared.dataTask(with: url){
    (data, response, error) in
    if let data = data {
        print(String(data: data, encoding: .utf8)!)
    }
    else if let error = error {
        print("request error \(error)")
    }
}

//task.resume()


// trailing closure
func getItems(completion: () -> Void ){
    print("Hello Hai Tran")
    completion()
}

getItems(completion: {
   () -> Void in
    print("Hello")
})

getItems {
    print("Hello Hai Tran Clousre Trailing")
}


// escaping closure called later on
func fetchItems(completion: @escaping(String) -> Void) {
    let url = URL(string: "https://cdk.entest.io/")!
    let task = URLSession.shared.dataTask(with: url){
        (data, response, error) in
        if let data = data {
            print(String(data: data, encoding: .utf8)!)
            completion("successfully get items")
        } else if let error = error {
            print(error)
        }
    }
    task.resume()
}

//fetchItems() {
//   (name) -> Void in
//    print(name)
//}

// [String: Any] datatype
let items : [String: Any] = ["name": "haitran", "age": 30]
print(items)

struct Source: Decodable {
    let DocumentTitle: String
    let DocumentURI: String
    let DocumentExcerpt: String
}

struct MyNote: Decodable {
    let _source : Source
}

struct Hit : Decodable {
    let hits: [MyNote]
}

struct Book: Decodable {
    let hits: Hit
}

//
struct Note {
    let title: String
    let url: String
    let excerpt: String
    let id: String
}


struct MyItem: Decodable {
    let _id: String
    let _source: Source
}


struct ListItems: Decodable {
    let items: [MyItem]
}


extension ListItems {
    init?(json: [String: Any]) {
        guard let hits = json["hits"] as? [String: Any]
        else {
            print("ERROR")
            return nil
        }
        guard let ahits = hits["hits"] as? [Any] else {
            return nil
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ahits, options: [])
            let items = try JSONDecoder().decode([MyItem].self, from: jsonData)
            self.items = items
//            print(items[0])
        } catch {
            print("ERROR")
            return nil
        }
    }
}

extension Note {
    init?(json: [String: Any]) {

        guard let hits = json["hits"] as? [String: Any]
        else {
            print("ERROR")
            return nil
        }
        
        guard let ahits = hits["hits"] as? [Any] else {
            return nil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ahits, options: [])
//            print(String(data: jsonData, encoding: .utf8)!)
            let items = try JSONDecoder().decode([MyItem].self, from: jsonData)
            print(items[0])
        } catch {
            print("ERROR")
        }
        
        guard let aNote = ahits[0] as? [String: Any] else {
            return nil
        }
        
        guard let id = aNote["_id"] as? String else {
            return nil
        }
        
        guard let source = aNote["_source"] as? [String: Any] else {
            return nil
        }
        
        guard let title = source["DocumentTitle"] as? String,
              let excerpt = source["DocumentExcerpt"] as? String,
              let url = source["DocumentURI"] as? String
        else {
            
            return nil
        }
        self.title = title
        self.id = id
        self.url = url
        self.excerpt = excerpt
    }
}



// call api gateway endpoint opensearch and JSONSerialization
func callApi(){
    let url = URL(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs")!
    let task = URLSession.shared.dataTask(with: url){
        (data, response, error) in
        guard let data = data else {
            return
        }
        // parse response
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = json as? [String: Any]{
            if let items = ListItems(json: dictionary){
                print("==================================\n \(items)")
            }
        }
    }
    task.resume()
}

callApi()
