//
//  FullScreenAdjustViewController.swift
//  ColorMix v4.0
//
//  Created by anyll on 6/10/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class FullScreenAdjustViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Variables and Constants
    
    
    //Functions
    
    
    //outlets
    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    
    //actions
    @IBAction func redSliderChanged(_ sender: Any) {
    }
    @IBAction func greenSliderChanged(_ sender: Any) {
    }
    @IBAction func blueSliderChanged(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}