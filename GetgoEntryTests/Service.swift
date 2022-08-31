//
//  Service.swift
//  GetgoEntryTests
//
//  Created by Michael Louis on 31/08/22.
//

import Foundation

class Service {
    func getCharacters(completion: @escaping ([Characters]) -> Void) {
        var request = URLRequest(url: URL(string: Constants.url)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let data = data {
                let APIDatas = try? JSONDecoder().decode(APIData.self, from: data)
                completion(APIDatas?.results ?? [])
            }
        })
        task.resume()
    }
}
