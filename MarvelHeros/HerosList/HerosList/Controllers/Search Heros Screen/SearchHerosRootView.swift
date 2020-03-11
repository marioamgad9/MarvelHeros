import UIKit
import Common

/// The root view for SearchHerosViewController
class SearchHerosRootView: NiblessView {
    
    // MARK: - Views
    let searchNavigationBar = SearchNavigationBar()
    
    // MARK: - Methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setInitialStateForAnimation()
    }
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
    
    private func setInitialStateForAnimation() {
        searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: -500)
        backgroundColor = .clear
    }
    
    func animateEntrance() {
        UIView.animate(withDuration: 1) {
            self.searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.backgroundColor = Colors.Backgrounds.main
        }
    }
    
    func animateOutro(completionHandler: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 1, animations: {
            self.searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: -500)
            self.backgroundColor = .clear
        }, completion: completionHandler)
    }
}
