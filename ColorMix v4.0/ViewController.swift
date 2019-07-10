//
//  ViewController.swift
//  ColorMix v4.0
//
//  Created by anyll on 3/10/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Set up the color area
        colorView.layer.borderWidth = 5
        colorView.layer.cornerRadius = 20
        colorView.layer.borderColor = UIColor.black.cgColor
        // enable and disable controls by using update controls
        updateControls()
        // Check to see if app was just opened (links to AppDelegate file through static var)
        if appRunning.appJustStartedRunning == true {  //App just started running
            appRunning.appJustStartedRunning = false  //Set that variable to false so that it doesn't retrigger
            colorView.backgroundColor = .black  //reset display color
        }else{  //If we were just on another view
            colorView.backgroundColor = saveState.color  //set color back to saved color
            let revertToState = saveState.sliders  //putting the state in a variable
            //Set everything to its correct value
            redSwitch.isOn = revertToState.rsw
            greenSwitch.isOn = revertToState.gsw
            blueSwitch.isOn = revertToState.bsw
            redSlider.value = revertToState.rsl
            greenSlider.value = revertToState.gsl
            blueSlider.value = revertToState.bsl
            updateControls()  //enable/disable apropriate things
        }
        saveState.sliders = stateStorage(rsw: true, rsl: 1, gsw: true, gsl: 1, bsw: true, bsl: 1) //reset this static var
        updateColor()  //in update color, the stored state is updated, meaning that this is all we have to do to reset to a correct state
    }
    //setup
    struct stateStorage{  //this is what we use to store the state of the app.
        var rsw: Bool = true
        var rsl: Float = 1
        var gsw: Bool = true
        var gsl: Float = 1
        var bsw: Bool = true
        var bsl: Float = 1
    }
    
    func updateControls(){  //this enables and disables sliders
        redSlider.isEnabled = redSwitch.isOn
        greenSlider.isEnabled = greenSwitch.isOn
        blueSlider.isEnabled = blueSwitch.isOn
    }
    func updateColor(){  //this is where we update the colors
        //reset variables
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        //Check whether a switch is on or not to know if a color should be dispalyed or not
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
        }
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
        }
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1) //put the final color into a variable
        colorView.backgroundColor = color  //set display area color to that color
        updateControls()  // enable and disable stuff
        // Save color and state
        saveState.color = color
        saveState.sliders = stateStorage(rsw: redSwitch.isOn, rsl: redSlider.value, gsw: greenSwitch.isOn, gsl: greenSlider.value, bsw: blueSwitch.isOn, bsl: blueSlider.value)
    }
    
    func resetColor(){  //this is called when the reset button is pressed
        // reset switches
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
        // reset sliders
        redSlider.value = 1
        greenSlider.value = 1
        blueSlider.value = 1
        // finish by updating color
        updateColor()
    }
    
    //views
    @IBOutlet weak var colorView: UIView!  // this is the display
    
    //sliders
    
    /*
     Note that these will come in the form of:
     -Outlet
     -Activation function
     and that when eack is activated it will run a function (all are updateColor exept the reset button that has updateColor in resetColor)
 */
    
    @IBOutlet var redSlider: UISlider!
    @IBAction func redSliderActivated(_ sender: UISlider) {
        updateColor()
    }
    @IBOutlet var greenSlider: UISlider!
    @IBAction func greenSliderActivated(_ sender: UISlider) {
        updateColor()
    }
    @IBOutlet var blueSlider: UISlider!
    @IBAction func blueSliderActivated(_ sender: UISlider) {
        updateColor()
    }
    //switches
    @IBOutlet var redSwitch: UISwitch!
    @IBAction func redSwitchActivated(_ sender: UISwitch) {
        updateColor()
    }
    @IBOutlet var greenSwitch: UISwitch!
    @IBAction func greenSwitchActivated(_ sender: UISwitch) {
        updateColor()
    }
    @IBOutlet var blueSwitch: UISwitch!
    @IBAction func blueSwitchActivated(_ sender: UISwitch) {
        updateColor()
    }
    
    //buttons
    
    @IBOutlet weak var resetButton: UIButton!  //reset button
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetColor()
    }
}
