//
//  AppDelegate.swift
//  Example
//
//  Created by pxlshpr on 6/8/17.
//  Copyright © 2017 pxlshpr. All rights reserved.
//

import UIKit
import Dropdown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Hello.hello()
    return true
  }
}
