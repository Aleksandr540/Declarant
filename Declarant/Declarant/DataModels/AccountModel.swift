//
//  AccountModel.swift
//  Declarant
//
//  Created by Александр Крюков on 12/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import Foundation

struct AccountModel: Decodable { //"items"
    
    let id: String
    let firstname: String
    let lastname: String
    let placeOfWork: String?
    let position: String?
    let linkPDF: String?
    
}
