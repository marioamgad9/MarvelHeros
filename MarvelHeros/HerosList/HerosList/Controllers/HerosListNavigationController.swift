import UIKit
import Common

/// The main navigation controller for HerosList
public class HerosListNavigationController: NiblessNavigationController, UIGestureRecognizerDelegate {
    
    // MARK: - Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar
        self.isNavigationBarHidden = true
        
        // A fix to retrieve the back gesture after hiding navigation bar
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
