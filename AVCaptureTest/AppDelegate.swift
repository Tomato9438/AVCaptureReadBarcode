//
//  AppDelegate.swift
//  AVCaptureTest
//
//  Created by JimmyHarrington on 2019/06/12.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Variables
    var window: UIWindow?
    var prefFile = String() // prefFile
    var appFile = String() // appFile

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /* Preferences */
        prefFile = folderPath(s: 0, name: "Preferences")
        if !pathExists(path: prefFile) {
            Preferences.createData(path: prefFile)
        }
        /* Application */
        appFile = folderPath(s: 0, name: "Application")
        if !pathExists(path: appFile) {
            Application.createData(path: appFile)
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

    // MARK: - Functions 1:Files
    func documentPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDirectory = paths.first! as NSString
        return documentsDirectory as String
    }
    
    func libraryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryDirectory = paths.first! as NSString
        return libraryDirectory as String
    }
    
    func folderPath(s: Int, name: String) -> String {
        if s == 0 {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsFolder = paths.first! as NSString
            let path = documentsFolder.appendingPathComponent(name)
            return path
        } else {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let libraryFolder = paths.first! as NSString
            let path = libraryFolder.appendingPathComponent(name)
            return path
        }
    }
    
    func createFolder(path: String) -> () {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories:false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    func pathExists(path: String) -> Bool {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            return true
        } else {
            return false
        }
    }
}

