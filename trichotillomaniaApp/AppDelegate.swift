//
//  AppDelegate.swift
//  trichotillomaniaApp
//
//  Created by Cody Condon on 2020-11-27.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore {
            
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let computer = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let homework = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let driving = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let grooming = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let bathroom = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inBed = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let watchingTv = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inFrontOfMirror = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            let inPublic = NSEntityDescription.insertNewObject(forEntityName: "Situation", into: context)
            
            let threeDays = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let fiveDays = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let oneWeek = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let tenDays = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let twoWeeks = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let threeWeeks = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let oneMonth = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let fiveWeeks = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let sixWeeks = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let twoMonths = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let threeMonths = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            let fourMonths = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
            
            
            
            threeDays.setValue("3 Days", forKey: "title")
            threeDays.setValue(false, forKey: "isUnlocked")
            threeDays.setValue("image1", forKey: "image")
            threeDays.setValue(1, forKey: "id")
            
            fiveDays.setValue("5 Days", forKey: "title")
            fiveDays.setValue(false, forKey: "isUnlocked")
            fiveDays.setValue("image2", forKey: "image")
            fiveDays.setValue(2, forKey: "id")
            
            oneWeek.setValue("1 Week", forKey: "title")
            oneWeek.setValue(false, forKey: "isUnlocked")
            oneWeek.setValue("image3", forKey: "image")
            oneWeek.setValue(3, forKey: "id")
            
            tenDays.setValue("10 Days", forKey: "title")
            tenDays.setValue(false, forKey: "isUnlocked")
            tenDays.setValue("image4", forKey: "image")
            tenDays.setValue(4, forKey: "id")
            
            twoWeeks.setValue("2 Weeks", forKey: "title")
            twoWeeks.setValue(false, forKey: "isUnlocked")
            twoWeeks.setValue("image5", forKey: "image")
            twoWeeks.setValue(5, forKey: "id")
            
            threeWeeks.setValue("3 Weeks", forKey: "title")
            threeWeeks.setValue(false, forKey: "isUnlocked")
            threeWeeks.setValue("image6", forKey: "image")
            threeWeeks.setValue(6, forKey: "id")
            
            oneMonth.setValue("1 Month", forKey: "title")
            oneMonth.setValue(false, forKey: "isUnlocked")
            oneMonth.setValue("image7", forKey: "image")
            oneMonth.setValue(7, forKey: "id")
            
            fiveWeeks.setValue("5 Weeks", forKey: "title")
            fiveWeeks.setValue(false, forKey: "isUnlocked")
            fiveWeeks.setValue("image8", forKey: "image")
            fiveWeeks.setValue(8, forKey: "id")
            
            sixWeeks.setValue("6 Weeks", forKey: "title")
            sixWeeks.setValue(false, forKey: "isUnlocked")
            sixWeeks.setValue("image9", forKey: "image")
            sixWeeks.setValue(9, forKey: "id")
            
            twoMonths.setValue("2 Months", forKey: "title")
            twoMonths.setValue(false, forKey: "isUnlocked")
            twoMonths.setValue("image10", forKey: "image")
            twoMonths.setValue(10, forKey: "id")
            
            threeMonths.setValue("3 Months", forKey: "title")
            threeMonths.setValue(false, forKey: "isUnlocked")
            threeMonths.setValue("image11", forKey: "image")
            threeMonths.setValue(11, forKey: "id")
            
            fourMonths.setValue("4 Months", forKey: "title")
            fourMonths.setValue(false, forKey: "isUnlocked")
            fourMonths.setValue("image12", forKey: "image")
            fourMonths.setValue(12, forKey: "id")
            
       
            computer.setValue("Computer", forKey: "place")
            homework.setValue("Homework", forKey: "place")
            driving.setValue("Driving", forKey: "place")
            grooming.setValue("Grooming", forKey: "place")
            bathroom.setValue("Bathroom", forKey: "place")
            inBed.setValue("In Bed", forKey: "place")
            watchingTv.setValue("Watching TV", forKey: "place")
            inFrontOfMirror.setValue("In Front Of Mirror", forKey: "place")
            inPublic.setValue("In Public", forKey: "place")
            
            do {
                try context.save()
            } catch {
                
            }
        }
        
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "trichotillomaniaApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

