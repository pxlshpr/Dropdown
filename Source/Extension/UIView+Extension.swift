import UIKit

internal extension UIView {
  
  //TODO: maybe replace these with UITableViewCell stuff
  struct Static {
    static var key = "key"
  }
  
  var viewIdentifier: String? {
    get {
      return objc_getAssociatedObject( self, &Static.key ) as? String
    }
    set {
      objc_setAssociatedObject(self, &Static.key, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
}
