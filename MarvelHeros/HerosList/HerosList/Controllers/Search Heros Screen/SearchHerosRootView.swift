import UIKit
import Common

/// The root view for SearchHerosViewController
class SearchHerosRootView: NiblessView {
    
    // MARK: - Views
    private let searchNavigationBar = SearchNavigationBar()
    
    // MARK: - Methods
    override func configureViewHierarchy() {
        add(searchNavigationBar, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        })
    }
}
