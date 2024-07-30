//
//  WebService.swift
//  MVVM API Data Fetch
//
//  Created by Masrafi Anam on 28/7/24.
//

import Foundation

final class WebService {  // When you declare a class as being final, no other class can inherit from it.
    
    static func getUsersData() async throws -> [UserModel] {  // static: We can directly access the static propertiesand methods of a class with help of class itself instead of creating the instance of the class.
        // async:- Stands for asynchronous, which means to execute the methods/program asynchronously.
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString) else {
            throw UserError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)  //URLSession:- _The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
            throw UserError.invalidResponse   // throws :- Sometimes functions fail because they have bad input, or because something went wrong internally.
             // Swift lets us throw errors from functions by marking them as throws before their return type, then using the throw keyword when something goes wrong.
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([UserModel].self, from: data)
        } catch {
            throw UserError.invalidData
        }  //do- catch statement- A method can be defined as throwing which basically means that if anything goes wrong, it can throw an error. To catch this error, we need to implement do-catch statement.
    }
}
