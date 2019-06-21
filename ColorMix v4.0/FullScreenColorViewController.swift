//
//  FullScreenColorViewController.swift
//  ColorMix v4.0
//
//  Created by anyll on 5/8/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class FullScreenColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FullScreenColorView.backgroundColor = saveState.color  //set dipaly color to color in ViewController
    }
    @IBOutlet weak var FullScreenColorView: UIView!  //color part of view
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
