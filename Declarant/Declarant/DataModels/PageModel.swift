//
//  PageModel.swift
//  Declarant
//
//  Created by Александр Крюков on 12/08/2019.
//  Copyright © 2019 Александр Крюков. All rights reserved.
//

import Foundation

struct PageModel: Decodable {// "page"
    let currentPage: Int
    let batchSize: Int
    let totalItems: String
}
