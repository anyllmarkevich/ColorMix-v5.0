//
//  TableOfColorsViewController.swift
//  ColorMix v4.0
//
//  Created by anyll on 12/21/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

class TableOfColorsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        parseFileOfColors(text: openFileNamed("SavedColors", type: "r", write: "")!)
    }
    
    //MARK: - Setup
    var indexPathForSelectedRow: IndexPath?  // the currently selected row, but returns nil if none is selected.
    
    func isARowSelected() -> Bool{  // find out if a row is selected.
        if indexPathForSelectedRow != nil {
            return true
        }else{
            return false
        }
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
    
    
    func parseFileOfColors(text: String){
        let contents = text
        var listOfCharacters = [String]()
        var subList = [String]()
        var exportList = [["", ""]]
        exportList = []
        var finalExportList = [colorFileElement]()
        var hold = ""
        for i in contents{
            listOfCharacters.append(String(i))
        }
        for i in listOfCharacters{
            if i != "/" && i != "|"{
                hold += i
            }else{
                if i == "|"{
                    subList.append(hold)
                    hold = ""
                }else if i == "/"{
                    subList.append(hold)
                    hold = ""
                    exportList.append(subList)
                    subList = []
                }
            }
        }
        var h1 = ""
        var h2 = ""
        var r = ""
        var g = ""
        var b = ""
        var comas = 0
        for i in exportList{
            h1 = i[0]
            h2 = i[1]
            r = ""
            g = ""
            b = ""
            comas = 0
            for j in h2{
                if j != "," && comas == 0{
                    r += String(j)
                }else if j != "," && comas == 1{
                    g += String(j)
                }else if j != "," && comas == 2{
                    b += String(j)
                }
                if j == ","{
                    comas += 1
                }
            }
            finalExportList.append(colorFileElement(Name: h1, Color: UIColor(red: CGFloat(Float(r)!), green: CGFloat(Float(g)!), blue: CGFloat(Float(b)!), alpha: 1)))
        }
        SavedColors.SavedColorsList = finalExportList
    }
    // MARK: - Button Connections
   
    @IBAction func AddActivated(_ sender: Any) {
    }
    @IBAction func OpenActivated(_ sender: Any) {
    }
    @IBAction func EditActivated(_ sender: Any) {
    }
    @IBAction func RenameActivated(_ sender: Any) {
    }
    
    
    
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
        if editingStyle == .delete {
            SavedColors.SavedColorsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
