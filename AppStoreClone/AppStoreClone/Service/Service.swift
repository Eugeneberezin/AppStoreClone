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
    
     func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
           let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
           fetchAppGroup(urlString: urlString, completion: completion)
       }
       
       func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
           fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
       }
       
       //helper
       func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
           fetchGenericJSONData(urlString: urlString, completion: completion)
       }
    
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        //guard let url = URL(string: urlString) else { return }
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    
    
    // declare my generic json function here
        func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
            
            print("T is type:", T.self)
            
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    completion(nil, err)
                    return
                }
                do {
                    let objects = try JSONDecoder().decode(T.self, from: data!)
                    // success
                    completion(objects, nil)
                } catch {
                    completion(nil, error)
                }
                }.resume()
        }
        
    }

    
    
    


