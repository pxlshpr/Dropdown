import UIKit

final class DropdownUIConfiguration {
  var menuTitleColor: UIColor?
  var cellHeight: CGFloat!
  var cellBackgroundColor: UIColor?
  var cellSeparatorColor: UIColor?
  var cellTextLabelColor: UIColor?
  var selectedCellTextLabelColor: UIColor?
  var cellTextLabelFont: UIFont!
  var navigationBarTitleFont: UIFont!
  var cellTextLabelAlignment: NSTextAlignment!
  var cellSelectionColor: UIColor?
  var checkMarkImage: UIImage!
  var shouldKeepSelectedCellColor: Bool!
  var arrowTintColor: UIColor?
  var arrowImage: UIImage!
  var arrowPadding: CGFloat!
  var animationDuration: TimeInterval!
  var maskBackgroundColor: UIColor!
  var maskBackgroundOpacity: CGFloat!
  var shouldChangeTitleText: Bool!
  
  init() {
    self.defaultValue()
  }
  
  func defaultValue() {
    // Path for image
    let bundle = Bundle(for: DropdownUIConfiguration.self)
    let url = bundle.url(forResource: "Images", withExtension: "bundle")
    let imageBundle = Bundle(url: url!)
    let checkMarkImagePath = imageBundle?.path(forResource: "checkmark_icon", ofType: "png")
    let arrowImagePath = imageBundle?.path(forResource: "arrow_down_icon", ofType: "png")
    
    // Default values
    self.menuTitleColor = UIColor.darkGray
    self.cellHeight = 50
    self.cellBackgroundColor = UIColor.white
    self.arrowTintColor = UIColor.white
    self.cellSeparatorColor = UIColor.darkGray
    self.cellTextLabelColor = UIColor.darkGray
    self.selectedCellTextLabelColor = UIColor.darkGray
    self.cellTextLabelFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
    self.navigationBarTitleFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
    self.cellTextLabelAlignment = NSTextAlignment.left
    self.cellSelectionColor = UIColor.lightGray
    self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath!)
    self.shouldKeepSelectedCellColor = false
    self.animationDuration = 0.5
    self.arrowImage = UIImage(contentsOfFile: arrowImagePath!)
    self.arrowPadding = 15
    self.maskBackgroundColor = UIColor.black
    self.maskBackgroundOpacity = 0.3
    self.shouldChangeTitleText = true
  }
}
