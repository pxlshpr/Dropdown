//
//  ViewController.swift
//  DropdownView
//
//  Created by Pham Ba Tho on 6/8/15.
//  Copyright (c) 2015 PHAM BA THO. All rights reserved.
//

import UIKit
import Dropdown

class ViewController: UIViewController {
  
  lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var menuView: DropdownView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
    
    view.backgroundColor = .lightGray
    view.addSubview(label)
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
      ])
    
    self.label.text = items.first
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    // "Old" version
    // menuView = DropdownView(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)
    
    menuView = DropdownView(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(2), items: items)
    
    // Another way to initialize:
    // menuView = DropdownView(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)
    
    menuView.cellHeight = 50
    menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
    menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
    menuView.shouldKeepSelectedCellColor = true
    menuView.cellTextLabelColor = UIColor.white
    menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
    menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
    menuView.arrowPadding = 15
    menuView.animationDuration = 0.5
    menuView.maskBackgroundColor = UIColor.black
    menuView.maskBackgroundOpacity = 0.3
    menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
      print("Did select item at index: \(indexPath)")
      self.label.text = items[indexPath]
    }
    
    self.navigationItem.titleView = menuView
  }
}
