//
//  Picture.swift
//  Project1
//
//  Created by Mikhail Strizhenov on 16.04.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.image = image
        self.name = name
    }
}
