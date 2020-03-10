import UIKit
import MHCore
import PromiseKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    private let dependencyContainer = MHAppDependencyContainer()
    private var coordinator: MHAppCoordinator?
    var window: UIWindow?
    
    // MARK: - Methods
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup coordinator
        coordinator = dependencyContainer.sharedAppCoordinator
        
        // Setup window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator?.rootVc
        
        // Start coordinator
        coordinator?.start()
        
        return true
    }
}

