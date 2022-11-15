// haimtran basic swift programming
// 15 NOV 2022

import UIKit

// array
let a : [Int] = [1,2,3]
let b = Array(repeating: 0.0, count: 10)

for k in (1 ... 10) {
    print(Int(k))
}

for (index, value) in a.enumerated() {
    print("index \(index) value: \(value)")
}


// error handler
enum AloError: Error {
    case BadInput
}

func getScore(age: Int) throws {
    if (age > 150) {
        throw AloError.BadInput
    }
    print("correct input \(age)")
}

do {
    try getScore(age: 160)
} catch AloError.BadInput {
    print("bad input error")
} catch {
    print("another error")
}

// closure function
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// standard closure
var reservedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2 })

// trailing closure
var reservedNamesTrailing = names.sorted { s1, s2 in
    return s1 > s2
}

print(reservedNames)
print(reservedNamesTrailing)

// my closure function
func someFunctionTakeClosure(closure: @escaping(String) -> Void) {
    // do network request
    let name = "Hai Tran"
    
    // parse the response
    closure(name)
}

// standard clousre
someFunctionTakeClosure(closure: {(name: String) -> Void in
    print("Hello \(name)")
})


// trailing closure
someFunctionTakeClosure { name in
    print("Hello \(name)")
}

// network request pur clousure
func callApi() {
    let url = URL(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs")!
    let task = URLSession.shared.dataTask(with: url){
        (data, response, error) in
        
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let hits = json["hits"] as? [String: Any],
           let ahits = hits["hits"] as? [Any] {
            print(ahits)
        }
            else
        {
            print("ERROR")
        }
    }
    task.resume()
}


//callApi()

// send concurrent requests to a endpoint
func sendRequest(id: Int, completion: @escaping(String) -> Void){
    print("send request to opensearch: \(id)")
    let url = URL(string: "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs")
    let task = URLSession.shared.dataTask(with: url!){
        (data, response, error) in
        guard let data = data else {
            return
        }
        let json = try? JSONSerialization.jsonObject(with: data)
        guard let jsonData = json else {
            return
        }
        print("request \(id) and reponse \(data)")
        print(jsonData)
    }
    task.resume()
}

//for k in (1...10) {
//    sendRequest(id: Int(k)) { name in
//        print("parse response \(name)")
//    }
//}

// network request async await
enum FetchError: Error {
    case badRequest
    case badJson
}


func fetchDataAsync() async throws -> String {
    
    let urlString = "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs"
    let url = URLRequest(url: URL(string: urlString)!)
    let (data, response) = try await URLSession.shared.data(for: url)
    
    // response 200 throw error bad request
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        print("ERROR")
        throw FetchError.badRequest
    }
    
    // fetch error throw error badjson
       guard let result = String(data: data, encoding: .utf8) else {
           throw FetchError.badJson
       }
    
    print(result)
    // return
    return result
}

//Task {
//    do {
//        let result = try await fetchDataAsync()
//    } catch FetchError.badRequest {
//        print("bad request error")
//    } catch {
//        print("another error")
//    }
//}

func fetchDataAsyncCatchError() async -> Result<String, Error> {
    enum FetchError: Error {
        case badRequest
        case badJson
    }
    
    let urlString =  "https://dl7f3fr40h.execute-api.us-east-1.amazonaws.com/prod/cdk-entest?query=ebs"
    let url = URLRequest(url: URL(string: urlString)!)
   
    do {
        let (data, response) = try await URLSession.shared.data(for: url)
        print(data)
        print(response)
        let dataString = String(data: data, encoding: .utf8)
        print(dataString!)
        return  .success("")
     } catch {
         return  .failure(FetchError.badJson)
    }
}

//Task {
//    let result = await fetchDataAsyncCatchError()
//    switch result {
//    case .failure(let error):
//        print(error)
//    case .success(let item):
//        print(item)
//    }
//}


// json decodable






