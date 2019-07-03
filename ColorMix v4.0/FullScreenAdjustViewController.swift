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
        let redval = redFinal()
        let greenval = greenFinal()
        let Blueval = blueFinal()
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
        if averageColor > 0.5{
            changeSliderColor(color: .black)
            backButton.setTitleColor(.black, for: .normal)
        }else{
            changeSliderColor(color: .white)
            backButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func findAverageColor(){
        let valueList = [redFinal(), greenFinal(), blueFinal()]
        var biggestSliderValue: Float = 0
        for i in valueList{
            if i > biggestSliderValue{
                biggestSliderValue = i
            }
        }
        if biggestSliderValue > 0.3{
            averageColor = 1
        }else{
            averageColor = 0
        }
    }
    
    func changeSliderColor(color: UIColor) {
        let redS = RedSlider
        let greenS = GreenSlider
        let blueS = BlueSlider
        sliderColorer(slider: redS ?? RedSlider, color: onOffTint(on: saveState.sliders.rsw, originalColor: color))
        sliderColorer(slider: greenS ?? GreenSlider, color: onOffTint(on: saveState.sliders.gsw, originalColor: color))
        sliderColorer(slider: blueS ?? BlueSlider, color: onOffTint(on: saveState.sliders.bsw, originalColor: color))
    }
    
    func sliderColorer(slider: UISlider, color: UIColor) {
        slider.maximumTrackTintColor = color
        slider.minimumTrackTintColor = color
        slider.thumbTintColor = color
    }
    
    func onOffTint(on: Bool, originalColor: UIColor) -> UIColor{
        var returnThis: UIColor = .green
        if on == true{
            returnThis = originalColor
        }else{
            if originalColor == .black{
                returnThis = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
            }else if originalColor == .white{
                returnThis = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
            }
        }
        return returnThis
    }
    
    //Corect Value Functions
    func redFinal() -> Float{
        if saveState.sliders.rsw == true{
            return RedSlider.value
        }else{
            return 0
        }
    }
    
    func greenFinal() -> Float{
        if saveState.sliders.gsw == true{
            return GreenSlider.value
        }else{
            return 0
        }
    }
    
    func blueFinal() -> Float{
        if saveState.sliders.bsw == true{
            return BlueSlider.value
        }else{
            return 0
        }
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
