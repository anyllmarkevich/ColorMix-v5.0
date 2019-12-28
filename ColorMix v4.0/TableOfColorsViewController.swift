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
    }
    var indexPathForSelectedRow: IndexPath?
    
    func isARowSelected() -> Bool{
        if indexPathForSelectedRow != nil {
            return true
        }else{
            return false
        }
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
        cell.textLabel?.text = (SavedColors.SavedColorsList[indexPath.row][0] as! String)  // make text of cell
        cell.backgroundColor = (SavedColors.SavedColorsList[indexPath.row][1] as! UIColor)  // set background color of cell.
        cell.textLabel?.textColor = findATextColor(color: SavedColors.SavedColorsList[indexPath.row][1] as! UIColor)  // set text color of cell.

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
