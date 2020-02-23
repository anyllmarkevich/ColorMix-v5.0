//
//  ListOfColorsSave.swift
//  ColorMix v4.0
//
//  Created by anyll on 12/22/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import Foundation
import UIKit

class SavedColors: NSCoder{
    static var SavedColorsList = [colorFileElement]()  //save colors in list view here.
    static var currentColor: Int? = nil
}

struct colorFileElement {
    var Name: String
    var Color: UIColor
}
