//
//  NetworkManager.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 02.05.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetch (completion: @escaping(Sneakers) -> Void) {
        let headers = [
            "X-RapidAPI-Host": "the-sneaker-database.p.rapidapi.com",
            "X-RapidAPI-Key": "56417c1416msh67856b66d4fc70ep10e1f9jsn8970bf079307"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://the-sneaker-database.p.rapidapi.com/sneakers?limit=100")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                DispatchQueue.main.async {
                    guard let sneakers = try? JSONDecoder().decode(Sneakers.self, from: data!) else { return }
                    completion(sneakers)
                }
            }
        })

        dataTask.resume()
    }
}
