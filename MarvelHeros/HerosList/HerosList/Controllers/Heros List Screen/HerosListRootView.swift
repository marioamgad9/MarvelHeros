import UIKit
import Common

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
    
    // MARK: - Methods
    init(charactersTableViewConfigurator: CharactersTableViewConfigurator) {
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
}

extension HerosListRootView: MarvelNavigationBarDelegate {
    func searchTapped() {
        print("TEST - Search tapped")
    }
}
