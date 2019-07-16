//
//  SettingsView.swift
//  ColorMix v4.0
//
//  Created by anyll on 7/16/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let saveFormat = Int(settingsManager.format)
        formatSelector.selectedSegmentIndex = saveFormat!
    }
    @IBOutlet weak var formatSelector: UISegmentedControl!
    @IBAction func changeInSelection(_ sender: Any) {
        settingsManager.format = String(formatSelector.selectedSegmentIndex)
        let fileToWrite = "settings save" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileToWrite)
            
            //writing
            do {
                try String(formatSelector.selectedSegmentIndex).write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}

        }
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