//
//  DataProvider.swift
//  RolodexApp
//
//  Created by Divya Basappa on 2/6/18.
//  Copyright © 2018 Divya Basappa. All rights reserved.
//

import Foundation
import UIKit


public protocol DataProvidingProtocol {
    func fetchData(urlString: String, listOfCards: @escaping ([JSONDictionary]) -> Void)
    func downloadImage(urlString: String, downloadedImage: @escaping (UIImage) -> Void)
}

class DataProvider: DataProvidingProtocol {
    func fetchData(urlString: String, listOfCards: @escaping ([JSONDictionary]) -> Void) {
        
        let urlFromString = URL(string: urlString)
        guard let url = urlFromString else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            guard let urlResponse = response as? HTTPURLResponse else { return }
            guard urlResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            let jsonData = self.deserializeData(data: data)
            guard let dictionary = jsonData else { return }
            listOfCards(dictionary)
        }
        task.resume()
    }
    
    func downloadImage(urlString: String, downloadedImage: @escaping (UIImage) -> Void) {
        
        let urlFromString = URL(string: urlString)
        guard let url = urlFromString else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil else { return }
            guard let urlResponse = response as? HTTPURLResponse else { return }
            guard urlResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            downloadedImage(image)
        })
        task.resume()
    }
    
    func dataSession(_ filename: String) -> Data? {
        let urlPath = Bundle.main.url(forResource: filename, withExtension: "json")
        guard let url = urlPath else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func deserializeData(data: Data) -> [JSONDictionary]? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonData as? [JSONDictionary]
        }
        catch {
            print("Error \(error.localizedDescription)")
        }
        return nil
    }
    
    
}
