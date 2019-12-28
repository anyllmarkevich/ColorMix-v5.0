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
        
        //DO PRIMARY SETUP OF VIEW
        
        // Set up the color area
        colorView.layer.borderWidth = 5  //border
        colorView.layer.cornerRadius = 20  //reounded border
        colorView.layer.borderColor = UIColor.black.cgColor  //black border
        // Set up output text
        outputText.isEditable = false  //make sure that the user can't edit text
        outputText.layer.cornerRadius = 10  // add rounded corners
        outputText.textContainer.maximumNumberOfLines = 1  //!!Try to keep user from using more than one line, but this is finicky, and needs to be impoved.
        outputText.textContainer.lineBreakMode = .byWordWrapping  //When the user tries to use more than one word, the text will "wordwrap"
        outputTextBackgroundColor = outputText.backgroundColor!  //save the background color of the text for later use.
        
        // DARK MODE
        
        if #available(iOS 13.0, *) { // check if dark mode is suported...
            BackgroundView.backgroundColor = .systemBackground //Change background of backgroundView based on dark mode.
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                colorView.layer.borderColor = UIColor.darkGray.cgColor
                outputText.backgroundColor = .darkGray
            }else{
                // User interface is Light
                colorView.layer.borderColor = UIColor.black.cgColor
                outputText.backgroundColor = .lightGray
            }
        } else {
            // Fallback on earlier versions
        }
        outputTextBackgroundColor = outputText.backgroundColor!  //save the new background color of the text
        
        //COTROLS
        
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
        saveState.sliders = stateStorage(rsw: true, rsl: 0, gsw: true, gsl: 0, bsw: true, bsl: 0) //reset this static var
        updateColor()  //in update color, the stored state is updated, meaning that this is all we have to do to reset to a correct state
    }
    //setup
    // MARK: - Functions, Types
    
    var outputTextEditable = false
    var outputTextBackgroundColor: UIColor = .black
    
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
        updateReturnString()
        outputText.backgroundColor = outputTextBackgroundColor
    }
    
    func resetColor(){  //this is called when the reset button is pressed
        // reset switches
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        // reset sliders
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        // finish by updating color
        updateColor()
    }
    // FUntion to update the text in the text box
    func updateReturnString(){
        if settingsManager.format == "0"{  // if is in HEX format
            let hexString = saveState.color.toHexString()  //convert to hex format
            outputText.text = hexString  // output (note the outputText.text saveing area)
        }
        if settingsManager.format == "1"{  // if is 255 format
            let colorToUse = saveState.color  // create and easy to access variable
            // Extract the color components of the color to use.
            let red = colorToUse.components?.red
            let green = colorToUse.components?.green
            let blue = colorToUse.components?.blue
            
            // Crete the string to be desplaued by adding the value of each component times 255, with parentheses between each component...
            var string = String(Int(Float(red!)*255))
            string += ", "
            string += String(Int(Float(green!)*255))
            string += ", "
            string += String(Int(Float(blue!)*255))
            
            outputText.text = string  // Output
        }
        if settingsManager.format == "2"{  //if format is Decimal
            //Repeat the same steps as for 255, above
            let colorToUse = saveState.color
            let red = colorToUse.components?.red
            let green = colorToUse.components?.green
            let blue = colorToUse.components?.blue
            var string = String(round(Float(red!)*1000)/1000)
            string += ", "
            string += String(round(Float(green!)*1000)/1000)
            string += ", "
            string += String(round(Float(blue!)*1000)/1000)
            outputText.text = string
        }
        if settingsManager.format == "3"{  // if format is HSB
            let colorToUse = saveState.color  // Put the color in an easy to access variable
            let hsbReturn = colorToUse.hsbColor  // tun it into a decimal HSB format
            // generate string
            var string = String(Int(Float(hsbReturn.hue)*360))
            string += ", "
            string += String(Int(Float(hsbReturn.saturation)*100))
            string += ", "
            string += String(Int(Float(hsbReturn.brightness)*100))
            
            outputText.text = string //output
        }
    }
    
    // When a user inputs a color, make sure it is valid. Else turn the color of the text box red (this is done in another place).
    class isRightFormat{
        static var outputedColors = [Float]() //this will contain comuter accessibel colors that the user inputed. Note that these will be floats representing the UIColor components r,g,b in that order.
        
        static func is255Format(_ inputtedString: String) -> Bool{  //is in 255 format?
            var input = ""  // variable for the input
            input = inputtedString.removingWhitespaces()  // remouve " " characters for unifomaization.
            var good = true  // assume string is acceptable
            var characters = [String]()  // a list to hold all the characters of the input.
            var comas = [Int]()  // count the number and lovation of comas in the input. Note that the location will be the n'th character in the input, starting from 0.
            var count = 0  // used to count stuff, duh!  xD  :)
            for i in input{  //cycle through the input
                characters.append(String(i))  //add each character to the characters list.
                if i == ","{  // look for comas.
                    comas.append(count)  // add the location of the coma to the coma list.
                }
                count+=1  // increase count
            }
            if comas.count == 2{}else{ good = false }  // if the number of comas is not 2, say the input is invalid.
            if good == true{ if comas[0] < 4 && comas[1] < comas[0] + 5{}else{ good = false } }  // make sure the comas are in a reasonable position (eg. the first coma isn't the 6th cahacter)
            if good == true{ if comas[0] > 0 && comas[1] > comas[0] + 1{}else{ good = false } }  // make sure the comas are in a not too close to eachother, such as ",,,255255255"
            //define variables for each color component
            var r = ""
            var g = ""
            var b = ""
            count = 0  //reset count
            
            if good == true{ //if all is still well:
                for i in characters{
                    // add the characters between the comas to the appropriate color component.
                    if count < comas[0]{
                        r += String(i)
                    }else if count > comas[0] && count < comas[1]{
                        g += String(i)
                    }else if count > comas[1]{
                        b += String(i)
                    }
                    count+=1
                }
            }
            
            // if all is still well, make sure that all the color components are numbers...
            if good == true{ if r.isNumeric{}else{ good = false } }
            if good == true{ if g.isNumeric{}else{ good = false } }
            if good == true{ if b.isNumeric{}else{ good = false } }
            if good == true{  // if all is still well:
                // covert each color component to a float.
                let rn = Float(r)
                let gn = Float(g)
                let bn = Float(b)
                // make sure each color component is within the range of 255
                if rn! < 256{}else{ good = false }
                if gn! < 256{}else{ good = false }
                if bn! < 256{}else{ good = false }
                //add each color component to the output list!
                outputedColors = [rn!/255, gn!/255, bn!/255]
            }
            return good  // confirm or not that the input was valid.
        }
        //////
        
        //////
        
        
        static func isHSBFormat(_ inputtedString: String) -> Bool{ //check to make sure inpur is in HSB forat (see 255 abouve too).
            var input = ""
            input = inputtedString.removingWhitespaces()
            var good = true
            var characters = [String]()
            var comas = [Int]()
            var count = 0
            for i in input{
                characters.append(String(i))
                if i == ","{
                    comas.append(count)
                }
                count+=1
            }
            if comas.count == 2{}else{ good = false }
            if good == true{ if comas[0] < 4 && comas[1] < comas[0] + 5{}else{ good = false } }
            if good == true{ if comas[0] > 0 && comas[1] > comas[0] + 1{}else{ good = false } }
            var h = ""
            var s = ""
            var l = ""
            count = 0
            if good == true{
                for i in characters{
                    if count < comas[0]{
                        h += String(i)
                    }else if count > comas[0] && count < comas[1]{
                        s += String(i)
                    }else if count > comas[1]{
                        l += String(i)
                    }
                    count+=1
                }
            }
            if good == true{ if h.isNumeric{}else{ good = false } }
            if good == true{ if s.isNumeric{}else{ good = false } }
            if good == true{ if l.isNumeric{}else{ good = false } }
            if good == true{
                let hn = Float(h)
                let sn = Float(s)
                let ln = Float(l)
                if hn! < 361{}else{ good = false }
                if sn! < 101{}else{ good = false }
                if ln! < 101{}else{ good = false }
                outputedColors = []
                let uicolorInput = UIColor(hue: CGFloat(hn!/360), saturation: CGFloat(sn!/100), brightness: CGFloat(ln!/100), alpha: 1)//note that we are using the HSB input for UIColor
                outputedColors = [Float(uicolorInput.rgba.red), Float(uicolorInput.rgba.green), Float(uicolorInput.rgba.blue)]
            }
            return good
        }
        /////
        
        
        /////
        static func is0To1Format(_ inputtedString: String) -> Bool{  // check to see if input is in decimal format (see 255 two functions above).
            var input = ""
            input = inputtedString.removingWhitespaces()
            var good = true
            var characters = [String]()
            var comas = [Int]()
            var dots = [Int]()
            var count = 0
            for i in input{
                characters.append(String(i))
                if i == ","{
                    comas.append(count)
                }
                if i == "."{
                    dots.append(count)
                }
                count+=1
            }
            if comas.count == 2{}else{ good = false }
            if dots.count == 3{}else{ good = false }
            if good == true{ if comas[0] > 0 && comas[1] > comas[0] + 1{}else{ good = false } }
            if good == true{ if comas[0] > dots[0] && dots[1] > comas[0] && comas[1] > dots[1] && comas[1] < dots[2]{}else{ good = false } }
            var r = ""
            var g = ""
            var b = ""
            count = 0
            if good == true{
                for i in characters{
                    if count < comas[0]{
                        r += String(i)
                    }else if count > comas[0] && count < comas[1]{
                        g += String(i)
                    }else if count > comas[1]{
                        b += String(i)
                    }
                    count+=1
                }
            }
            if good == true{ if r.isDecimal{}else{ good = false } }
            if good == true{ if g.isDecimal{}else{ good = false } }
            if good == true{ if b.isDecimal{}else{ good = false } }
            if good == true{
                let rn = Float(r)
                let gn = Float(g)
                let bn = Float(b)
                if rn! <= 1{}else{ good = false }
                if gn! <= 1{}else{ good = false }
                if bn! <= 1{}else{ good = false }
                outputedColors = [rn!, gn!, bn!]  // note that no conversion is necessary
            }
            return good
        }
        static func isHexFormat(_ inputtedString: String) -> Bool{  // chack to see if input is in hex format (see 255 three functions above)
            var input = ""
            input = inputtedString.removingWhitespaces()
            // make sure to remove the "#" symbol if present.
            if input[0] == "#"{
                input.remove(at: input.startIndex)
            }
            
            var good = true
            if input.isColorHex{}else{good = false}
            if good == true{
                // each color component is the joining of two letters, so do that.
                let r = input[0]+input[1]
                let g = input[2]+input[3]
                let b = input[4]+input[5]
                
                // turn from hexadecimal to decimal
                let rn = Float(r.hexToNum!)/255
                let gn = Float(g.hexToNum!)/255
                let bn = Float(b.hexToNum!)/255
                outputedColors = [rn, gn, bn]
            }
            return good
        }
    }
    
    //MARK: - UI Elements
    
    //views
    @IBOutlet weak var colorView: UIView!  // this is the display
    // background view:
    @IBOutlet var BackgroundView: UIView!
    
    
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
    
    //Buttons
    
    // reset
    @IBOutlet weak var resetButton: UIButton!  //reset button
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetColor()
    }
    //input / cancel
    @IBOutlet weak var inputButton: UIButton!
    @IBAction func inputButtonPressed(_ sender: Any) {
        if outputTextEditable == false{  // if the text was not editable, make it editable.
            outputText.isEditable = true
            outputTextEditable = true
            inputButton.setTitle("Done",for: .normal)  ///change button title to "done"
        }else{  //if button is editable, make it not so
            outputTextEditable = false
            outputText.isEditable = false
            inputButton.setTitle("Edit",for: .normal)  /// change button text back to "edit"
            
            //WHEN DONE IS PRESSED, MAKE SURE THE INPUT IS VALID, AND CHANGE ACCORDINGLY, USING "ISRIGHTFORMAT.OUTPUTEDCOLORS TO CHANGE COLOR VIEWS COLOR.
            if isRightFormat.is255Format(outputText.text) && settingsManager.format == "1"{
                outputText.backgroundColor = outputTextBackgroundColor
                redSlider.value = isRightFormat.outputedColors[0]
                greenSlider.value = isRightFormat.outputedColors[1]
                blueSlider.value = isRightFormat.outputedColors[2]
                updateColor()
            }else if isRightFormat.isHSBFormat(outputText.text) && settingsManager.format == "3"{
                outputText.backgroundColor = outputTextBackgroundColor
                redSlider.value = isRightFormat.outputedColors[0]
                greenSlider.value = isRightFormat.outputedColors[1]
                blueSlider.value = isRightFormat.outputedColors[2]
                updateColor()
            }else if isRightFormat.is0To1Format(outputText.text) && settingsManager.format == "2"{
                outputText.backgroundColor = outputTextBackgroundColor
                redSlider.value = isRightFormat.outputedColors[0]
                greenSlider.value = isRightFormat.outputedColors[1]
                blueSlider.value = isRightFormat.outputedColors[2]
                updateColor()
            }else if isRightFormat.isHexFormat(outputText.text) && settingsManager.format == "0"{
                outputText.backgroundColor = outputTextBackgroundColor
                redSlider.value = isRightFormat.outputedColors[0]
                greenSlider.value = isRightFormat.outputedColors[1]
                blueSlider.value = isRightFormat.outputedColors[2]
                updateColor()
            }else{
                outputText.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1)
            }
        }
    }
    //Text views
    @IBOutlet weak var outputText: UITextView!
    
    // IF DARK/LIGHT MODE CHANGES WHILE APP IS RUNNING.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        colorView.layer.borderColor = UIColor.black.cgColor
        outputTextBackgroundColor = outputText.backgroundColor!
        if #available(iOS 13.0, *) { // check if dark mode is suported...
            BackgroundView.backgroundColor = .systemBackground //Change background of backgroundView based on dark mode.
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                colorView.layer.borderColor = UIColor.darkGray.cgColor
                if outputText.backgroundColor != UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1){
                    outputText.backgroundColor = .darkGray
                }
            }else{
                colorView.layer.borderColor = UIColor.black.cgColor
                if outputText.backgroundColor != UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1){
                    outputText.backgroundColor = .lightGray
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
