//
//  Request.swift
//  listWithLinks
//
//  Created by Алдияр Айтпаев on 27.01.2022.
//

import Foundation
import SwiftUI


func testingRequest(comletion: @escaping([LinkModel]) -> Void) {
    var linkModels: [LinkModel] = []
    let Url = String(format: "https://api.nobelprize.org/2.1/laureates")
    guard let serviceUrl = URL(string: Url) else { return}
    let request = URLRequest(url: serviceUrl)
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error)
        }
        if let response = response {
            print(response)
        }
        
        if let data = data {
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let laureates = json?["laureates"] as? [[String : Any]] {
                    for laureate in laureates {
                        let array = laureate["links"] as! [[String : Any]]
                        let title = array[1]["title"] as! String
                        let wikiData = laureate["wikidata"] as! [String : Any]
                        let url = wikiData["url"] as! String
                        let linkModel = LinkModel(link: url, name: title)
                        linkModels.append(linkModel)
                        
                    }
                    comletion(linkModels)
                }
            } catch {
                print(error)
            }
        }
    }.resume()
}

struct LinkModel: Decodable {
var link: String
var name: String
}
