//
//  Service.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 10/27/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() //Singleton
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm.lowercased())&entity=software"
                 guard let url = URL(string: urlString) else { return }

                 // fetch data from internet
                 URLSession.shared.dataTask(with: url) { (data, resp, err) in

                     if let err = err {
                         print("Failed to fetch apps:", err)
                        completion([], nil)
                         return
                     }


                     guard let data = data else { return }

                     do {
                         let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                        completion(searchResult.results, nil)

                     } catch let jsonErr {
                         print("Failed to decode json:", jsonErr)
                        completion([], jsonErr)
                     }



                 }.resume() // fires off the request
        
    }
    
}

