//
//  ColorTableViewCell.swift
//  ColorMix v4.0
//
//  Created by anyll on 12/22/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        /*ColorBackground.backgroundColor = .green
        self.textLabel?.textColor = .black
        var myItemNumber = 0
        var iterations = 0
        for _ in SavedColors.SavedColorsList{
            if textLabel?.text == SavedColors.SavedColorsList[iterations]{
                myItemNumber = iterations
            }
            iterations += 1
        }
        ColorBackground.backgroundColor = SavedColors.SavedColorsColor[myItemNumber]
         */
    }

    @IBOutlet weak var ColorBackground: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
