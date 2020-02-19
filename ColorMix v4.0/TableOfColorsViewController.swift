//
//  TableOfColorsViewController.swift
//  ColorMix v4.0
//
//  Created by anyll on 12/21/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

extension UITableView {  // Allows you to deselect the selected row.

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow
        {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}

class TableOfColorsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        parseFileOfColors(text: openFileNamed("SavedColors", type: "r", write: "")!)
        //print(indexPathForSelectedRow)
        RenameButton.isEnabled = false // disable reanme button
    }
    
    //MARK: - Setup
    class isARowSelected{
        static var selectedRowIndex: Int? = nil
        static var wholeIndex: IndexPath? = nil
    }
    
    func unIndex(){
        print("About to nil info about IndexPath.")
        isARowSelected.selectedRowIndex = nil
        isARowSelected.wholeIndex = nil
    }
    func index(_ path: IndexPath){
        print("About to save index path.")
        isARowSelected.selectedRowIndex = path.row
        isARowSelected.wholeIndex = path
    }
    
    func openFileNamed(_ fileName: String, type: String, write: String) -> String?{
    // Write "w" to write, adn "r" read in type
    var returnText: String? = nil  /// assume output is nil
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let filePlacement = dir.appendingPathComponent(fileName)
            //writing
            if type == "w"{
                do {
                    try write.write(to: filePlacement, atomically: false, encoding: .utf8)
                    returnText = "[text not used]"
                    print("File named \(fileName) written to.")
                }
                catch {/* error handling here */}
            }
            //reading
            if type == "r"{
                do {
                    returnText = try String(contentsOf: filePlacement, encoding: .utf8)
                    print("File named \(fileName) read.")
                }
                catch {/* error handling here */}
            }
        }
    return returnText
    }
    
    
    func parseFileOfColors(text: String){  //decode contents of file saving colors
        let contents = text  /// Make a more editable version...
        var listOfCharacters = [String]()  /// make a list to conatin all the characters of the input.
        var subList = [String]()  /// use this list to help decode
        var exportList = [["", ""]]  /// make a list that is capable of handling  a list of string lists
        exportList = []  /// empty the list
        var finalExportList = [colorFileElement]()  // this is what will be exported! Note that colorFileElement is defined in the file ListOfColorsSave.swift
        var hold = ""  ///  Use this to hold string values
        for i in contents{  // make a list conataining all the characters of the input.
            listOfCharacters.append(String(i))  /// execute this
        }
        for i in listOfCharacters{  // for every character in the input
            if i != "/" && i != "|"{  ///check to make sure it is not one of the "breakpoint" characters.
                hold += i  /// add the current character to hold.
            }else{  /// if it is a breakpoint character:
                if i == "|"{  /// if it is a "|" symbol
                    subList.append(hold)  /// add the newly constructed string to a temporary list.
                    hold = ""  /// empty the hold string
                }else if i == "/"{  /// if it is a "/" symbol
                    subList.append(hold)  /// add the newly constructed string to a temporary list.
                    hold = ""  /// empty the hold string
                    exportList.append(subList)  /// add the temporary string to the preliinary export list. NOte that this is a list of lists of strings.
                    subList = []  // empty the sublist.
                }
            }
        }
        var h1 = ""  // this will hold the name of the color
        var h2 = ""  // this will hold the color of the color
        // define a variable for each color component.
        var r = ""
        var g = ""
        var b = ""
        
        var comas = 0  // keep track of how many comas we have "passed"
        for i in exportList{  /// for every sub-item
            h1 = i[0]  // add the name to h1
            h2 = i[1]  // ad the color to h2
            /// clear color component variables
            r = ""
            g = ""
            b = ""
            comas = 0 /// clear comas we have passed
            for j in h2{  /// for every number in the color
                if j != "," && comas == 0{  // check to make sure it is not a coma, and add the number to the right color based on the number of comas passed
                    r += String(j)
                }else if j != "," && comas == 1{
                    g += String(j)
                }else if j != "," && comas == 2{
                    b += String(j)
                }
                if j == ","{  // if is a coma
                    comas += 1  // increase the coma count by one
                }
            }
            finalExportList.append(colorFileElement(Name: h1, Color: UIColor(red: CGFloat(Float(r)!), green: CGFloat(Float(g)!), blue: CGFloat(Float(b)!), alpha: 1)))  // create a colorFileElement structure based on the name and the newly constructed color
        }
        SavedColors.SavedColorsList = finalExportList  // export all of it.
    }
    
    func codeListOfColors() -> String{  //Generate code to store colors.
        var textString = ""  /// Use this to store stuff
        for i in SavedColors.SavedColorsList{  ///For every color
            print("About to code \(i.Name).")
            textString += i.Name + "|" + String(Float(i.Color.components!.red)) + "," + String(Float(i.Color.components!.green)) + "," + String(Float(i.Color.components!.blue)) + "/"  /// Add the code
            print("Coded " + i.Name + "|" + String(Float(i.Color.components!.red)) + "," + String(Float(i.Color.components!.green)) + "," + String(Float(i.Color.components!.blue)) + "/ from saved colors")   ///print the code
        }
        return textString  /// return the code
    }
    // MARK: - Button Connections
   
    @IBAction func AddActivated(_ sender: Any) {
        let alert = UIAlertController(title: "What do you want to name the new saved color?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input new name here..."
        })
        alert.addAction(UIAlertAction(title: "Add Current Color", style: .default, handler: { action in
            if var name = alert.textFields?.first?.text{
                name = name.removeProblemCharacters
                SavedColors.SavedColorsList.append(colorFileElement(Name: name, Color: saveState.color))
                self.openFileNamed("SavedColors", type: "w", write: self.codeListOfColors())
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath.init(row: SavedColors.SavedColorsList.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
                
                if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SavedColors.SavedColorsList.count-1, section: 0)){
                    cell.textLabel?.text = name
                    cell.textLabel?.textColor = self.findATextColor(color: SavedColors.SavedColorsList[SavedColors.SavedColorsList.count-1].Color)
                }
            }
        }))
        self.present(alert, animated: true)
    }
    @IBAction func OpenActivated(_ sender: Any) {
    }
    @IBAction func RenameActivated(_ sender: Any) {
        if isARowSelected.selectedRowIndex != nil{
            let alert = UIAlertController(title: "What do you want to name the color?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input new name here..."
            })

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if var name = alert.textFields?.first?.text{
                    name = name.removeProblemCharacters
                    SavedColors.SavedColorsList[isARowSelected.selectedRowIndex!].Name = name
                    self.openFileNamed("SavedColors", type: "w", write: self.codeListOfColors())
                    if let cell = self.tableView.cellForRow(at: isARowSelected.wholeIndex!){
                        cell.textLabel?.text = name
                        cell.textLabel?.textColor = self.findATextColor(color: SavedColors.SavedColorsList[isARowSelected.selectedRowIndex!].Color)
                    }
                }
            }))
            self.present(alert, animated: true)
            print("Presented alert")
            self.tableView.deselectSelectedRow(animated: true)
        }
    }
    @IBOutlet weak var RenameButton: UIButton!
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SavedColors.SavedColorsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell", for: indexPath)  // define a cell
        cell.textLabel?.text = (SavedColors.SavedColorsList[indexPath.row].Name)  // make text of cell
        cell.backgroundColor = (SavedColors.SavedColorsList[indexPath.row].Color)  // set background color of cell.
        cell.textLabel?.textColor = findATextColor(color: SavedColors.SavedColorsList[indexPath.row].Color)  // set text color of cell.
        print("The current cell is " + String(indexPath.row) + " and its name is " + SavedColors.SavedColorsList[indexPath.row].Name + ".")
        return cell
    }
    
    func findATextColor(color: UIColor) -> UIColor{  //find a number that will inform app of background darkness
        let valueList = [Float(color.rgbColor.red), Float(color.rgbColor.green), Float(color.rgbColor.blue)]  //create a list with the efective value of sliders
           var biggestValue: Float = 0  //keep track of the biggest slider with this variable
           for i in valueList{  //repeat for the length of the list (3)
               if i > biggestValue{  // if this is the largest value yet:
                   biggestValue = i  //set the biggest value  var to it
               }
           }
           if biggestValue > 0.3{
            return .black
           }else{  //else
            return .white  // turn the sliders black
           }
       }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {  // when an item is deleted
            SavedColors.SavedColorsList.remove(at: indexPath.row)  // remouve the item from teh static list
            openFileNamed("SavedColors", type: "w", write: codeListOfColors())  // write to file the new list
            tableView.deleteRows(at: [indexPath], with: .fade)  // delete the row
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPathForSelection: IndexPath) {
        //isARowSelected.selectedRowIndex = nil
        //isARowSelected.wholeIndex = nil
        RenameButton.isEnabled = false
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPathForSelection: IndexPath) {
        print("User pressed '" + SavedColors.SavedColorsList[indexPathForSelection.row].Name + "' (row #\(indexPathForSelection.row)).")
        index(indexPathForSelection)
        RenameButton.isEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
            indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            unIndex()
            return nil
        }else{
        }
        index(indexPath)
        return indexPath
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
