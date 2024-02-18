//
//  Category.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 09.02.2024.
//

import Foundation
import SwiftyJSON

/*
 
 "name" : "Ситкомдар",
 "fileId" : null,
 "movieCount" : 2,
 "id" : 31,
 "link" : null
 
 */

class Category {
    var name: String
    var id: Int
    
    init(json: JSON) {
        name = json["name"].stringValue
        id = json["id"].intValue
    }
}
