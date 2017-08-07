import UIKit
import TinyConstraints

//TODO: support orientation changes (works on either orientation but breaks when changed)

// MARK: DropdownView
open class DropdownView: UIView {
  
  // The color of menu title. Default is darkGrayColor()
  open var menuTitleColor: UIColor! {
    get { return self.configuration.menuTitleColor }
    set(value) { self.configuration.menuTitleColor = value }
  }
  
  // The height of the cell. Default is 50
  open var cellHeight: NSNumber! {
    get { return self.configuration.cellHeight as NSNumber! }
    set(value) { self.configuration.cellHeight = CGFloat(value) }
  }
  
  // The color of the cell background. Default is whiteColor()
  open var cellBackgroundColor: UIColor! {
    get { return self.configuration.cellBackgroundColor }
    set(color) { self.configuration.cellBackgroundColor = color }
  }
  
  // The tint color of the arrow. Default is whiteColor()
  open var arrowTintColor: UIColor! {
    get { return self.arrowImageView.tintColor }
    set(color) { self.arrowImageView.tintColor = color }
  }
  
  open var cellSeparatorColor: UIColor! {
    get { return self.configuration.cellSeparatorColor }
    set(value) { self.configuration.cellSeparatorColor = value }
  }
  
  // The color of the text inside cell. Default is darkGrayColor()
  open var cellTextLabelColor: UIColor! {
    get { return self.configuration.cellTextLabelColor }
    set(value) { self.configuration.cellTextLabelColor = value }
  }
  
  // The color of the text inside a selected cell. Default is darkGrayColor()
  open var selectedCellTextLabelColor: UIColor! {
    get { return self.configuration.selectedCellTextLabelColor }
    set(value) { self.configuration.selectedCellTextLabelColor = value }
  }
  
  // The font of the text inside cell. Default is HelveticaNeue-Bold, size 17
  open var cellTextLabelFont: UIFont! {
    get { return self.configuration.cellTextLabelFont }
    set(value) { self.configuration.cellTextLabelFont = value }
  }
  
  // The font of the navigation bar title. Default is HelveticaNeue-Bold, size 17
  open var navigationBarTitleFont: UIFont! {
    get { return self.configuration.navigationBarTitleFont }
    set(value) {
      self.configuration.navigationBarTitleFont = value
      self.label.font = self.configuration.navigationBarTitleFont
    }
  }
  
  // The alignment of the text inside cell. Default is .Left
  open var cellTextLabelAlignment: NSTextAlignment! {
    get { return self.configuration.cellTextLabelAlignment }
    set(value) { self.configuration.cellTextLabelAlignment = value }
  }
  
  // The color of the cell when the cell is selected. Default is lightGrayColor()
  open var cellSelectionColor: UIColor! {
    get { return self.configuration.cellSelectionColor }
    set(value) { self.configuration.cellSelectionColor = value }
  }
  
  // The checkmark icon of the cell
  open var checkMarkImage: UIImage! {
    get { return self.configuration.checkMarkImage }
    set(value) { self.configuration.checkMarkImage = value }
  }
  
  // The boolean value that decides if selected color of cell is visible when the menu is shown. Default is false
  open var shouldKeepSelectedCellColor: Bool! {
    get { return self.configuration.shouldKeepSelectedCellColor }
    set(value) { self.configuration.shouldKeepSelectedCellColor = value }
  }
  
  // The animation duration of showing/hiding menu. Default is 0.3
  open var animationDuration: TimeInterval! {
    get { return self.configuration.animationDuration }
    set(value) { self.configuration.animationDuration = value }
  }
  
  // The arrow next to navigation title
  open var arrowImage: UIImage! {
    get { return self.configuration.arrowImage }
    set(value) {
      self.configuration.arrowImage = value.withRenderingMode(.alwaysTemplate)
      self.arrowImageView.image = self.configuration.arrowImage
    }
  }
  
  // The padding between navigation title and arrow
  open var arrowPadding: CGFloat! {
    get { return self.configuration.arrowPadding }
    set(value) { self.configuration.arrowPadding = value }
  }
  
  // The color of the mask layer. Default is blackColor()
  open var maskBackgroundColor: UIColor! {
    get { return self.configuration.maskBackgroundColor }
    set(value) { self.configuration.maskBackgroundColor = value }
  }
  
  // The opacity of the mask layer. Default is 0.3
  open var maskBackgroundOpacity: CGFloat! {
    get { return self.configuration.maskBackgroundOpacity }
    set(value) { self.configuration.maskBackgroundOpacity = value }
  }
  
  // The boolean value that decides if you want to change the title text when a cell is selected. Default is true
  open var shouldChangeTitleText: Bool! {
    get { return self.configuration.shouldChangeTitleText }
    set(value) { self.configuration.shouldChangeTitleText = value }
  }
  
  open var didSelectItemAtIndexHandler: ((_ indexPath: Int) -> ())?
  open var isShown: Bool!
  
  internal weak var navigationController: UINavigationController?
  internal var configuration = DropdownUIConfiguration()
  internal var items: [String]!
  
  lazy internal var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = self.menuTitleColor
    label.font = self.configuration.navigationBarTitleFont
    label.textAlignment = self.configuration.cellTextLabelAlignment
    label.textColor = self.configuration.menuTitleColor //TODO: remove this as its a duplicate
    return label
  }()
  
  lazy internal var button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(DropdownView.menuButtonTapped(_:)), for: UIControlEvents.touchUpInside)
    return button
  }()
  
  lazy internal var arrowImageView: UIImageView = {
    let imageView = UIImageView(image: self.configuration.arrowImage.withRenderingMode(.alwaysTemplate))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  //MARK: - Lifecycle
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /**
   
   Default init. This will allow the user to define a string or a index where the user can
   pre-define as a default selected. This is specially handy for when it's necessary to
   restore from a saved state
   
   - parameters:
   - navigationController: The present and visible navigation controller.
   - containerView: The container view. Default is keyWindow.
   - title: An enum to define title to be displayed, can be a string or index of items.
   - items: The array of items to select
   */
  public init(navigationController: UINavigationController? = nil, containerView: UIView = UIApplication.shared.keyWindow!, title: DropdownTitle, items: [String]) {
    // Key window
    guard let window = UIApplication.shared.keyWindow else {
      super.init(frame: CGRect.zero)
      return
    }
    
    // Navigation controller
    if let navigationController = navigationController {
      self.navigationController = navigationController
    } else {
      self.navigationController = window.rootViewController?.topMostViewController?.navigationController
    }
    
    // Get titleSize
    let titleSize: CGSize
    let titleToDisplay: String
    switch title {
    case .index(let index): titleToDisplay = index < items.count ? items[index] : ""
    case .title(let title): titleToDisplay = title
    }
    
    titleSize = (titleToDisplay as NSString).size(attributes: [NSFontAttributeName:self.configuration.navigationBarTitleFont])
    
    // Set frame
    let width = titleSize.width + (self.configuration.arrowPadding + self.configuration.arrowImage.size.width)*2
    let height = self.navigationController!.navigationBar.frame.height
    
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false

    removePreviousMenuViews(fromView: containerView)
    setupDefaultConfiguration()
    
    self.isShown = false
    self.items = items
    
    label.text = titleToDisplay
    
    self.addSubview(button)
    button.addSubview(self.label)
    button.addSubview(arrowImageView)
    menuView.addSubview(backgroundView)
    menuView.addSubview(tableView)
    menuView.addSubview(topSeparator)
    containerView.addSubview(self.menuView)

    //MARK: - Constraints

    self.width(width)
    self.height(height)
    
    button.edges(to: self)

    menuView.edges(to: containerView)
    label.center(in: self)
    arrowImageView.centerY(to: self)
    arrowImageView.leftToRight(of: label, offset: configuration.arrowPadding - (self.configuration.arrowImage.size.width / 2.0))

    topSeparator.origin(to: menuView)
    topSeparator.width(to: menuView)
    topSeparator.height(0.5)

    backgroundView.edges(to: menuView)

    tableView.left(to: menuView)
    tableView.top(to: menuView, offset: 0.5)
    tableView.width(to: menuView)
    tableView.height(200) //TODO: change this
    
//    let tableViewFrame = CGRect(x: menuViewBounds.origin.x, y: menuViewBounds.origin.y + 0.5, width: menuViewBounds.width, height: menuViewBounds.height + 300 - navBarHeight - statusBarHeight)
    
    setupOtherStuff() //TODO: rename this
  }

  func setupOtherStuff() {
    menuView.isHidden = true
    
    let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DropdownView.hideMenu));
    backgroundView.addGestureRecognizer(backgroundTapRecognizer)
  }
  
  func removePreviousMenuViews(fromView view: UIView) {
    //TODO: try to not use this
    // Remove MenuWrapper from container view to avoid leaks
    view.subviews
      .filter({$0.viewIdentifier == "BTNavigationDropDownMenu-MenuWrapper"})
      .forEach({$0.removeFromSuperview()})
  }
  
  lazy internal var backgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = self.configuration.maskBackgroundColor
//    view.backgroundColor = .red
    return view
  }()

  lazy internal var topSeparator: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.autoresizingMask = UIViewAutoresizing.flexibleWidth
    return view
  }()
  
  lazy internal var tableView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .yellow
    return view
  }()
  
//  lazy internal var tableView: DropdownTableView = {
//    let navBarHeight = self.navigationController?.navigationBar.bounds.size.height ?? 0
//    let statusBarHeight = UIApplication.shared.statusBarFrame.height
//    let tableViewFrame = CGRect(x: menuViewBounds.origin.x, y: menuViewBounds.origin.y + 0.5, width: menuViewBounds.width, height: menuViewBounds.height + 300 - navBarHeight - statusBarHeight)
//    
//    let tableView = DropdownTableView(frame: tableViewFrame, items: items, title: titleToDisplay, configuration: self.configuration)
//    tableView.selectRowAtIndexPathHandler = { [unowned self] (indexPath: Int) -> () in
//      self.didSelectItemAtIndexHandler!(indexPath)
//      if self.shouldChangeTitleText! {
//        self.label.text = "\(self.tableView.items[indexPath])"
//      }
//      self.hideMenu()
//      self.layoutSubviews()
//    }
//    return tableView
//  }()

  lazy internal var menuView: UIView = {
    //    let bounds = UIApplication.shared.keyWindow!.bounds
    //    let view = UIView(frame: CGRect(x: bounds.origin.x, y: 0, width: bounds.width, height: bounds.height))
    //    view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.viewIdentifier = "BTNavigationDropDownMenu-MenuWrapper"
    view.clipsToBounds = true
    return view
  }()

  override open func layoutSubviews() {
//    label.sizeToFit()
//    label.center(in: self)
//    
//    arrowImageView.sizeToFit()
//    arrowImageView.centerY(to: self)
//    arrowImageView.leftToRight(of: label, offset: configuration.arrowPadding - (self.configuration.arrowImage.size.width / 2.0))
    
//    self.menuView.frame.origin.y = self.navigationController!.navigationBar.frame.maxY
    
//    self.tableView.reloadData()
    
    print("TableView: \(tableView.frame)")
    print("MenuView: \(menuView.frame)")
  }
}
