//
//  AppDelegate.swift
//  ColorMix v4.0
//
//  Created by anyll on 3/10/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appRunning.appJustStartedRunning = true  //warn app that the app has just started running by setting this static var to true (see below)
        let fileToRead = "settings save" //this is the file. we will write to and read from it
        settingsManager.format = openFileNamed(fileToRead, type: "r", write: "") ?? "0"  //put setting from file into appropriate class.
        if isAppAlreadyLaunchedOnce() == false{ // if this is the first time app is launched
            openFileNamed("SavedColors", type: "w", write: "red|1,0,0/green|0,1,0/blue|0,0,1/white|1,1,1/black|0,0,0/what|0.56,0.93485,0.22/black2|0,0,0/")  // put in default set of colors
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

class appRunning{  //will tell ViewController.swift if the app has just started running. It will be equal to true if that is true, and false if it is not
    static var appJustStartedRunning: Bool = false  //start out false
}

func isAppAlreadyLaunchedOnce()->Bool{
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
        print("App already launched")
        return true
    }else{
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}

// MARK: - Read/Write Function vvv

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
func codeListOfColors() -> String{
    var textString = ""
    for i in SavedColors.SavedColorsList{
        textString += i.Name + "|" + String(Float(i.Color.components!.red)) + "," + String(Float(i.Color.components!.green)) + "," + String(Float(i.Color.components!.blue)) + "/"
        print("Coded " + i.Name + "|" + String(Float(i.Color.components!.red)) + "," + String(Float(i.Color.components!.green)) + "," + String(Float(i.Color.components!.blue)) + "/ from saved colors")
    }
    return textString
}


