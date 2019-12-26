//
//  CordataFile.swift
//  CoreDataAndStaticsUse
//
//  Created by IMCS2 on 12/24/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import Foundation

struct CoreDataModel {
    var name : String = " "
    var number : String = " "
    
    init() {
    }

    init(_ name: String, _ number: String) {
        self.name = name
        self.number = number
    }
}
