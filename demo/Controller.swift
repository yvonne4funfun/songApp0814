//
//  Controller.swift
//  demo
//
//  Created by fun on 2020/8/15.
//

import UIKit

class Controller {
    
    static let shared = Controller()
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    var Array = [song]()
    
    func fetchSongs(completion: @escaping ([song]?) -> Void) {
        if let urlStr = "https://itunes.apple.com/search?term=告五人 &media=music&country=TW".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                if let data = data, let resultArray = (try? JSONSerialization.jsonObject(with: data,options: [])) as? [[String: Any]] {
                    print(resultArray)
                    for nasaDic in resultArray {
                        if let song = song(from: nasaDic as! [String : String] as! Decoder) {
                            self.Array.append(song)
                        }
                    }
                    completion(self.Array)
                }
            }
            task.resume()
        }
    }
}
