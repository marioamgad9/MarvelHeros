import UIKit
import Common

protocol HerosListRootViewResponder {
    func searchTapped()
    func tableViewDidReachEnd()
}

typealias CharactersTableViewConfigurator = (UITableView) -> ()

/// The root view for HerosListViewController
class HerosListRootView: NiblessView {
    
    // MARK: - Views
    private let marvelNavigationBar = MarvelNavigationBar()
    private let charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Properties
    private let responder: HerosListRootViewResponder
    
    // MARK: - Methods
    init(charactersTableViewConfigurator: CharactersTableViewConfigurator,
         responder: HerosListRootViewResponder) {
        self.responder = responder
        super.init(frame: .zero)
        
        charactersTableViewConfigurator(charactersTableView)
        configureCharactersTableView()
        marvelNavigationBar.delegate = self
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
        
        add(charactersTableView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: marvelNavigationBar.bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        })
        
        add(activityIndicator, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: charactersTableView.centerYAnchor),
                $0.centerXAnchor.constraint(equalTo: charactersTableView.centerXAnchor)
            ])
        })
    }
    
    /// Configures characters tableview
    private func configureCharactersTableView() {
        charactersTableView.registerCellFromClass(CharacterTableViewCell.self)
        charactersTableView.delegate = self
    }
}

extension HerosListRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            responder.tableViewDidReachEnd()
        }
    }
}

extension HerosListRootView: MarvelNavigationBarDelegate {
    func searchTapped() {
        responder.searchTapped()
    }
}
