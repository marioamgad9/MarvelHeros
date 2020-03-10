import UIKit
import Common

/// The main navigation controller for HerosList
public class HerosListNavigationController: NiblessNavigationController {
    
    // MARK: - Methods
    public override init() {
        super.init()
        
        // Hide navigation bar
        self.isNavigationBarHidden = true
    }
}
