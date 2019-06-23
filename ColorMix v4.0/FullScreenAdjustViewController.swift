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
    
    func goodColors(){
        if averageColor > 1{
            changeSliderColor(color: .black)
        }else{
            changeSliderColor(color: .white)
        }
    }
    
    func findAverageColor(){
        averageColor = Float(RedSlider.value + GreenSlider.value + BlueSlider.value)
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
