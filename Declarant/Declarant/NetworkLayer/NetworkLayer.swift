//
//  NetworkLayer.swift
//  DeclarantTests
//
//  Created by Александр Крюков on 12/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String : Any]

class NetworkLayer {
    
    static let apiString =  "https://public-api.nazk.gov.ua/v1/declaration/"
    
    static func searchDeclarations(name: String, page: Int = 1, completion: @escaping ([AccountModel]?, PageModel? ) -> Void){
        
        let parameters: [String : Any] = ["page" : page, "q" : name]
        
        Alamofire.request(NetworkLayer.apiString, method: .get, parameters: parameters).responseJSON { (jsonResponse) in
            
            if let jsonValue = jsonResponse.result.value as? JSON,
                let jsonItems = jsonValue["items"],
                let jsonPage = jsonValue["page"]  {
                
                let decoder = JSONDecoder()
                
if let itemsData = try? JSONSerialization.data(withJSONObject: jsonItems, options: []),
    let pageData = try? JSONSerialization.data(withJSONObject: jsonPage, options: []){
                    
            let itemsArray = try? decoder.decode([AccountModel].self, from: itemsData)
            let page = try? decoder.decode(PageModel.self, from: pageData )
                    
    completion(itemsArray, page)
    
                    
                }
                
                
            }else{
                completion(nil, nil)
        }
    }
  }
}
