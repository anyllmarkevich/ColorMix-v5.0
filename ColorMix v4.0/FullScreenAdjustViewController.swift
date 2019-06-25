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
        colorView.backgroundColor = saveState.color
        RedSlider.value = saveState.sliders.rsl
        GreenSlider.value = saveState.sliders.gsl
        BlueSlider.value = saveState.sliders.bsl
        goodColors()
    }
    
    //Variables and Constants
    var averageColor: Float = 0
    
    //Functions
    
    func changeColors(){
        let redval = RedSlider.value
        let greenval = GreenSlider.value
        let Blueval = BlueSlider.value
        let thisColor = UIColor(red: CGFloat(redval), green: CGFloat(greenval), blue: CGFloat(Blueval), alpha: 1)
        saveState.color = thisColor
        saveState.sliders.rsl = RedSlider.value
        saveState.sliders.gsl = GreenSlider.value
        saveState.sliders.bsl = BlueSlider.value
        colorView.backgroundColor = thisColor
        goodColors()
    }
    
    func goodColors(){
        findAverageColor()
        if averageColor > 0.4{
            changeSliderColor(color: .black)
            backButton.setTitleColor(.black, for: .normal)
        }else{
            changeSliderColor(color: .white)
            backButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func findAverageColor(){
        let r = RedSlider.value
        let g = GreenSlider.value
        let b = BlueSlider.value
        if r > g && r > b {
            averageColor = r
        }else if g > r && g > b {
            averageColor = g
        }else if b > r && b > g {
            averageColor = b
        }else{
            if r+g+b > 0.5{
                averageColor = 1
            }else{
                averageColor = 0
            }
        }
    }
    
    func changeSliderColor(color: UIColor) {
        let redS = RedSlider
        let greenS = GreenSlider
        let blueS = BlueSlider
        sliderColorer(slider: redS ?? RedSlider, color: color)
        sliderColorer(slider: greenS ?? GreenSlider, color: color)
        sliderColorer(slider: blueS ?? BlueSlider, color: color)
    }
    func sliderColorer(slider: UISlider, color: UIColor) {
        slider.maximumTrackTintColor = color
        slider.minimumTrackTintColor = color
        slider.thumbTintColor = color
    }
    
    //outlets
    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    //actions
    @IBAction func redSliderChanged(_ sender: Any) {
        saveState.sliders.rsw = true
        changeColors()
    }
    @IBAction func greenSliderChanged(_ sender: Any) {
        saveState.sliders.gsw = true
        changeColors()
    }
    @IBAction func blueSliderChanged(_ sender: Any) {
        saveState.sliders.bsw = true
        changeColors()
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
