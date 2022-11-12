// haimtran 08/11/2022
// call opensearch api and response
// json parse using init and codable


import UIKit
import Foundation

struct Note: Codable {
    let DocumentTitle: String
    let DocumentURI: String
}

struct Source: Codable {
    let _id: String
    let _source: Note
}

func getNotes(){
    let url = URL(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs")!
    let task = URLSession.shared.dataTask(with: url){
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
            print(result)
        } catch {
            print("ERROR")
            return
        }
     
    }
    task.resume()
}


getNotes()
