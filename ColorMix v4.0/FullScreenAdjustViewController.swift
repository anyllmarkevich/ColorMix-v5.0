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
        colorView.backgroundColor = saveState.color  //set background color to saved color
        //set each slider to its correct value
        RedSlider.value = saveState.sliders.rsl
        GreenSlider.value = saveState.sliders.gsl
        BlueSlider.value = saveState.sliders.bsl
        goodColors()  //Change the color of the sliders so that they stand out agains background
    }
    
    //Variables and Constants
    var averageColor: Float = 0  //keeps the 'average color' to adjust slider color to background
    
    //Functions
    
    func changeColors(){  //changes color to what sliders indicate
        // set the 3 access variables to the value of that sliders considering the switches.
        let redval = redFinal()
        let greenval = greenFinal()
        let Blueval = blueFinal()
        //set final color to the 3 reference variables
        let thisColor = UIColor(red: CGFloat(redval), green: CGFloat(greenval), blue: CGFloat(Blueval), alpha: 1)
        saveState.color = thisColor  // save the color to saveState file
        // save slider values
        saveState.sliders.rsl = RedSlider.value
        saveState.sliders.gsl = GreenSlider.value
        saveState.sliders.bsl = BlueSlider.value
        colorView.backgroundColor = thisColor //change background color and set it to thisColor variable
        goodColors()  //adjust the color of the sliders to background to make sure they are visible
    }
    
    func goodColors(){  //changes slider colors to make sure sliders are visible
        findAverageColor()  //find a number that will inform the app about darkeness of background
        if averageColor > 0.5{  //if this number is larger than 0.5, make sliders black
            changeSliderColor(color: .black)  //change the slider colors to black
            backButton.setTitleColor(.black, for: .normal)  //change the back button color to black
        }else{  //if background is light:
            changeSliderColor(color: .white)  //change slider colors to white
            backButton.setTitleColor(.white, for: .normal)  //change back button to white
        }
    }
    
    func findAverageColor(){  //find a number that will inform app of background darkness
        let valueList = [redFinal(), greenFinal(), blueFinal()]  //create a list with the efective value of sliders
        var biggestSliderValue: Float = 0  //keep track of the biggest slider with this variable
        for i in valueList{  //repeat for the length of the list (3)
            if i > biggestSliderValue{  // if this is the largest value yet:
                biggestSliderValue = i  //set the biggest value  var to it
            }
        }
        if biggestSliderValue > 0.3{  //if the biggest value is larger than 0.3:
            averageColor = 1  // set the informing variable to 1, effectively turning the sliders white
        }else{  //else
            averageColor = 0  // turn the sliders black
        }
    }
    
    func changeSliderColor(color: UIColor) {  //change the color of the sliders
        //assign a reference variable to each slider
        let redS = RedSlider
        let greenS = GreenSlider
        let blueS = BlueSlider
        //change the color of each slider using a funciton and adjusting for the 'switch tint' that indicates the state of the coresponding switch
        sliderColorer(slider: redS ?? RedSlider, color: onOffTint(on: saveState.sliders.rsw, originalColor: color))
        sliderColorer(slider: greenS ?? GreenSlider, color: onOffTint(on: saveState.sliders.gsw, originalColor: color))
        sliderColorer(slider: blueS ?? BlueSlider, color: onOffTint(on: saveState.sliders.bsw, originalColor: color))
    }
    
    func sliderColorer(slider: UISlider, color: UIColor) {  //change the color of a slider
        //change the color of each part
        slider.maximumTrackTintColor = color
        slider.minimumTrackTintColor = color
        slider.thumbTintColor = color
    }
    
    func onOffTint(on: Bool, originalColor: UIColor) -> UIColor{  //adjusts slider tint based on switch states in ViewController.swift
        var returnThis: UIColor = .green  //will return value stored in here
        if on == true{  //if switch is on
            returnThis = originalColor  //return black or white, depending
        }else{  // if switch is off
            if originalColor == .black{  // if darker color is required
                returnThis = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)  //return a dark gray
            }else if originalColor == .white{  // if lighter color is required
                returnThis = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)  // return a light gray
            }
        }
        return returnThis  //return variable
    }
    
    //Corect Value Functions (value of sliders considering switches
    func redFinal() -> Float{  //take a slider
        if saveState.sliders.rsw == true{  // if it's switch is on
            return RedSlider.value  // return the slider value
        }else{  // if the switch is off
            return 0  // return 0, as there is no color showing
        }
    }
    //repeat pattern
    func greenFinal() -> Float{
        if saveState.sliders.gsw == true{
            return GreenSlider.value
        }else{
            return 0
        }
    }
    //repeat pattern
    func blueFinal() -> Float{
        if saveState.sliders.bsw == true{
            return BlueSlider.value
        }else{
            return 0
        }
    }
    
    //outlets
    @IBOutlet weak var RedSlider: UISlider!  //slider that deals with red
    @IBOutlet weak var GreenSlider: UISlider!  // -- green
    @IBOutlet weak var BlueSlider: UISlider!  //  -- blue
    @IBOutlet weak var colorView: UIView!  // displays color
    @IBOutlet weak var backButton: UIButton!  // returns you to main view
    
    //actions
    @IBAction func redSliderChanged(_ sender: Any) { //if red slider is changed
        saveState.sliders.rsw = true  // set switch state to true
        changeColors()  //update all the colors
    }
    @IBAction func greenSliderChanged(_ sender: Any) {  // same
        saveState.sliders.gsw = true
        changeColors()
    }
    @IBAction func blueSliderChanged(_ sender: Any) {  //same
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
