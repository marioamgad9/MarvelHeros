import UIKit
import Common

/// The root view for HerosListViewController
class HerosListRootView: NiblessView {
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    override func configureViewHierarchy() {
        
    }
    
    override func viewHierarchyDidConfigure() {
        backgroundColor = .blue
    }
}
