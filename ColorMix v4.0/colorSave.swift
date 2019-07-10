//
//  File.swift
//  ColorMix v4.0
//
//  Created by anyll on 6/10/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import Foundation  //basics
import UIKit  //UI capabilities
class saveState: NSCoder{  //save stuff for other views
    //save sliders
    static var sliders: ViewController.stateStorage = ViewController.stateStorage(rsw: false, rsl: 1, gsw: false, gsl: 1, bsw: false, bsl: 1)
    //save color, for quick access
    static var color: UIColor = .black
}
