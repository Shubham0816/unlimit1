//
//  Service.swift
//  testqwer
//
//  Created by apple on 25/08/23.
//

import Foundation
import UIKit

class Service {
     
    func getDataFromApi( callBack: @escaping (String?,Bool?) -> ()) {
        DispatchQueue.global(qos: .background).sync {
            let url = URL(string: "https://geek-jokes.sameerkumar.website/api")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let string = String(data: data, encoding: .utf8) {
                        callBack(string,true)
                    }
                }else  if let _ = error {
                    callBack("Some thing want wrong",false)
                }
            }
            task.resume()
        }
    }
}
