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
        colorView.layer.borderWidth = 5
        colorView.layer.cornerRadius = 20
        colorView.layer.borderColor = UIColor.black.cgColor
        updateControls()
        if appRunning.appJustStartedRunning == true {
            appRunning.appJustStartedRunning = false
            colorView.backgroundColor = .black
        }else{
            colorView.backgroundColor = FullScreenColorViewController.rememberColor.rememberedColor
            let revertToState = FullScreenColorViewController.rememberColor.rememberedState
            redSwitch.isOn = revertToState.rsw
            greenSwitch.isOn = revertToState.gsw
            blueSwitch.isOn = revertToState.bsw
            redSlider.value = revertToState.rsl
            greenSlider.value = revertToState.gsl
            blueSlider.value = revertToState.bsl
            updateControls()
        }
        colorTransfer.storeThisState = stateStorage(rsw: true, rsl: 1, gsw: true, gsl: 1, bsw: true, bsl: 1)
        updateColor()
    }
    //setup
    struct stateStorage{
        var rsw: Bool = true
        var rsl: Float = 1
        var gsw: Bool = true
        var gsl: Float = 1
        var bsw: Bool = true
        var bsl: Float = 1
    }
    class colorTransfer{
        static var transferedColor: UIColor = .black
        static var storeThisState: stateStorage = stateStorage(rsw: true, rsl: 1, gsw: true, gsl: 1, bsw: true, bsl: 1)
    }
    //
    func updateControls(){
        redSlider.isEnabled = redSwitch.isOn
        greenSlider.isEnabled = greenSwitch.isOn
        blueSlider.isEnabled = blueSwitch.isOn
    }
    func updateColor(){
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
        }
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
        }
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
        }
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        colorView.backgroundColor = color
        updateControls()
        colorTransfer.transferedColor = color
        colorTransfer.storeThisState = stateStorage(rsw: redSwitch.isOn, rsl: redSlider.value, gsw: greenSwitch.isOn, gsl: greenSlider.value, bsw: blueSwitch.isOn, bsl: blueSlider.value)
    }
    
    func resetColor(){
        // switches
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
        // sliders
        redSlider.value = 1
        greenSlider.value = 1
        blueSlider.value = 1
        // finish by updating color
        updateColor()
    }
    //functions and structures
    
    //views
    @IBOutlet weak var colorView: UIView!
    //sliders
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
    
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetColor()
    }
}
