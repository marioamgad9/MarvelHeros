import UIKit
import Common

/// The root view for HerosListViewController
class HerosListRootView: NiblessView {
    
    // MARK: - Views
    private let marvelNavigationBar = MarvelNavigationBar()
    
    
    // MARK: - Methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    override func configureViewHierarchy() {
        add(marvelNavigationBar, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        })
    }
    
    override func viewHierarchyDidConfigure() {
        backgroundColor = .blue
    }
}
