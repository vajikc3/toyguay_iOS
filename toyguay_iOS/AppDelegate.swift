//
//  AppDelegate.swift
//  toyguay_iOS
//
//  Created by Verónica Cordobés on 21/1/17.
//  Copyright © 2017 TheBardals. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        FBSDKApplicationDelegate.sharedInstance().application(application,
            didFinishLaunchingWithOptions:launchOptions)
        
        let sameOne = CoreDataStack.defaultStack(modelName: "toyguay_iOS")!
    //    try! sameOne.dropAllData()
        //Creación de juguetes de prueba
//        _ = Toy(name: "Train", descriptionText: "tren bonito", imageURL: "", price: 10, userId: 1, inContext: (sameOne.context))
//        _ = Toy(name: "Punto", descriptionText: "punto azul", imageURL: "", price: 45, userId: 1, inContext: (sameOne.context))
//        
//        sameOne.save()
        
        let toyService:ToyService = ToyService()
        toyService.getToys { (status, toys) in
            if let toysUnwrapped: [ToyData] = toys as [ToyData]? {
                for toy in toysUnwrapped {
                    print(toy.creationDate)
                    let t = Toy(id: toy.id!, name: toy.name!, descriptionText: toy.description!, imageURL: toy.image![0], price: Float(toy.price!), userId: toy.userId!, createdDate: toy.creationDate!, latitude: (toy.location?[0])!, longitude: (toy.location?[1])!, state: toy.state!, username: toy.nickname!, inContext: (sameOne.context))

//                    } else {
//                        let date = "\(Date())"
//                        let t = Toy(id: toy.id!, name: toy.name!, descriptionText: toy.description!, imageURL: toy.image![0], price: Float(toy.price!), userId: toy.userId!, createdDate: dateFormatter.date(from: date)!, latitude: (toy.location?[0])!, longitude: (toy.location?[1])!, state: toy.state!, username: toy.nickname!, inContext: (sameOne.context))
//
//                    }
                    sameOne.save()
                }
            }
            
        }
    //    sameOne.save()

        let tabBarController = UITabBarController()
        let productsVC = ProductsViewController()
        productsVC.tabBarItem = UITabBarItem(title: "Productos", image: nil, tag: 0)
        let mapaVC = MapaViewController()
        mapaVC.tabBarItem = UITabBarItem(title: "Mapa", image: nil, tag: 1)
        let nuevoVC = NuevoViewController()
        nuevoVC.tabBarItem = UITabBarItem(title: "Nuevo", image: nil, tag: 2)
        let notifsVC = NotifsViewController()
        notifsVC.tabBarItem = UITabBarItem(title: "Notificaciones", image: nil, tag: 3)
        let perfilVC = PerfilViewController()
        perfilVC.tabBarItem = UITabBarItem(title: "Perfil", image: nil, tag: 4)
        
        let vControllers = [productsVC, mapaVC, nuevoVC, notifsVC, perfilVC]
        tabBarController.viewControllers = vControllers
        window?.rootViewController = tabBarController
        
//        let loginVC: LogInViewController = LogInViewController(nibName: nil, bundle: nil)
//      //   Create the rootVC
//        let rootVC = loginVC
//        window?.rootViewController = rootVC
        
        // Display
        window?.makeKeyAndVisible()
        

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options [UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "toyguay_iOS")
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

