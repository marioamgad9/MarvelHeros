import UIKit
import Common

/// The root view for SearchHerosViewController
class SearchHerosRootView: NiblessView {
    
    // MARK: - Views
    let searchNavigationBar = SearchNavigationBar()
    private let charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Methods
    init(charactersTableViewConfigurator: CharactersTableViewConfigurator) {
        super.init(frame: .zero)
        
        charactersTableViewConfigurator(charactersTableView)
        configureCharactersTableView()
        setInitialStateForAnimation()
    }
    
    override func configureViewHierarchy() {
        // Configure navigation bar
        add(searchNavigationBar, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        })
        
        // Configure characters tableview
        add(charactersTableView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: searchNavigationBar.bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        })
    }
    
    /// Configures characters tableview
    private func configureCharactersTableView() {
        charactersTableView.registerCellFromClass(SearchCharacterTableViewCell.self)
        charactersTableView.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension SearchHerosRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Animations
extension SearchHerosRootView {
    private func setInitialStateForAnimation() {
        searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: -500)
        backgroundColor = .clear
        charactersTableView.alpha = 0
    }
    
    func animateEntrance() {
        UIView.animate(withDuration: 0.5) {
            self.searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.backgroundColor = Colors.Backgrounds.main
            self.charactersTableView.alpha = 1
        }
    }
    
    func animateOutro(completionHandler: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchNavigationBar.transform = CGAffineTransform(translationX: 0, y: -500)
            self.backgroundColor = .clear
            self.charactersTableView.alpha = 0
        }, completion: completionHandler)
    }
}
