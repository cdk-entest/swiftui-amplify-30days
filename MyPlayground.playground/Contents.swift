// haimtran 07/11/2022
// resume swift

import UIKit

var greeting = "Hello, playground"

struct Book {
    let title: String
    let price: Int
}

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

func printBook(book: Book){
    print(book.title)
}

print(greet(person: "Hai Tran"))
print(Book(title: "Algebra", price: 10))

// clousure
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reservedNames = names.sorted(by: {(s1: String, s2: String) ->Bool in return s1 > s2 })

print(reservedNames)

// trailing closure
func someFunctionTakeClosure(closure: (String) -> Void) {
        let name = "Hai Tran"
        closure(name)
}

someFunctionTakeClosure(closure: {
    (name) -> Void in
    print("Hello Training Closure, " + name)
})

someFunctionTakeClosure() {name in
    print("Hello Trailing Closure, " + name)
}

func callApi(completion: (String) -> String){
    print("response from api call")
    let response = "Book"
    let result = completion(response)
    print("parsed response " + result)
}

callApi(completion: {
    (response) -> String in
    print("parse response from api " + response)
    return "Heheheeh"
})

// 




