import UIKit

extension DropdownView {
  
  open func show() {
    if self.isShown == false {
      self.showMenu()
    }
  }
  
  open func hide() {
    if self.isShown == true {
      self.hideMenu()
    }
  }
  
  open func toggle() {
    if(self.isShown == true) {
      self.hideMenu();
    } else {
      self.showMenu();
    }
  }
  
  open func updateItems(_ items: [String]) {
    if !items.isEmpty {
      self.tableView.items = items
      self.tableView.reloadData()
    }
  }
  
  open func setSelected(index: Int) {
    self.tableView.selectedIndexPath = index
    self.tableView.reloadData()
    
    if self.shouldChangeTitleText! {
      label.text = "\(self.tableView.items[index])"
    }
  }
  
  func setupDefaultConfiguration() {
    self.menuTitleColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
    self.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
    self.cellSeparatorColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
    self.cellTextLabelColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
    
    self.arrowTintColor = self.configuration.arrowTintColor
  }
  
  func showMenu() {
    self.menuWrapper.frame.origin.y = self.navigationController!.navigationBar.frame.maxY
    
    self.isShown = true
    
    // Table view header
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 300))
    headerView.backgroundColor = self.configuration.cellBackgroundColor
    self.tableView.tableHeaderView = headerView
    
    self.topSeparator.backgroundColor = self.configuration.cellSeparatorColor
    
    // Rotate arrow
    self.rotateArrow()
    
    // Visible menu view
    self.menuWrapper.isHidden = false
    
    // Change background alpha
    self.backgroundView.alpha = 0
    
    // Animation
    self.tableView.frame.origin.y = -CGFloat(self.items.count) * self.configuration.cellHeight - 300
    
    // Reload data to dismiss highlight color of selected cell
    self.tableView.reloadData()
    
    self.menuWrapper.superview?.bringSubview(toFront: self.menuWrapper)
    
    UIView.animate(
      withDuration: self.configuration.animationDuration * 1.5,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.5,
      options: [],
      animations: {
        self.tableView.frame.origin.y = CGFloat(-300)
        self.backgroundView.alpha = self.configuration.maskBackgroundOpacity },
      completion: nil
    )
  }
  
  func hideMenu() {
    // Rotate arrow
    self.rotateArrow()
    
    self.isShown = false
    
    // Change background alpha
    self.backgroundView.alpha = self.configuration.maskBackgroundOpacity
    
    UIView.animate(
      withDuration: self.configuration.animationDuration * 1.5,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.5,
      options: [],
      animations: {
        self.tableView.frame.origin.y = CGFloat(-200)
    }, completion: nil
    )
    
    // Animation
    UIView.animate(
      withDuration: self.configuration.animationDuration,
      delay: 0,
      options: UIViewAnimationOptions(),
      animations: {
        self.tableView.frame.origin.y = -CGFloat(self.items.count) * self.configuration.cellHeight - 300
        self.backgroundView.alpha = 0 },
      completion: { _ in
        if self.isShown == false && self.tableView.frame.origin.y == -CGFloat(self.items.count) * self.configuration.cellHeight - 300 {
          self.menuWrapper.isHidden = true
        }
    })
  }
  
  func rotateArrow() {
    UIView.animate(withDuration: self.configuration.animationDuration, animations: {[unowned self] () -> () in
      self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: 180 * CGFloat(Double.pi/180))
    })
  }
  
  func menuButtonTapped(_ sender: UIButton) {
    self.isShown == true ? hideMenu() : showMenu()
  }
}
