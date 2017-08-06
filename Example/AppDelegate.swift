import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var app: Application?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Set white status bar
//    UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)

    let window = UIWindow(frame: UIScreen.main.bounds)
    self.app = Application(window: window)
    
    self.window = window
    self.app?.navigation.start()
    return true
  }
}

//MARK: - Application
class Application {
  private let window: UIWindow
  lazy var navigation: Navigation = Navigation(
    window: self.window,
    application: self
  )
  
  init(window: UIWindow) {
    self.window = window
  }
}

//MARK: - Navigation
class Navigation {
  internal let application: Application
  internal let navigationController: UINavigationController
  
  init(window: UIWindow, application: Application) {
    self.application = application
    self.navigationController = UINavigationController()
    window.rootViewController = self.navigationController
    window.makeKeyAndVisible()
  }
  
  func start() {
    showViewController()
  }
  
  func showViewController() {
    let controller = ViewController()
    self.navigationController.pushViewController(controller, animated: false)
  }
}
