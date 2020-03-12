import UIKit
import Common
import RxSwift
import RxCocoa

/// Handles showing the list of characters and filtering them
public class HerosListViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: HerosListRootView!
    
    // MARK: - Properties
    private let viewModel: HerosListViewModel
    private let disposeBag = DisposeBag()
    
    // Status bar style
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    public init(viewModel: HerosListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        rootView = HerosListRootView(charactersTableViewConfigurator: configureCharactersTableView(_:),
                                     responder: self)
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind isLoading to activity indicator
        viewModel.output.isLoading
            .drive(rootView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Trigger fetch
        viewModel.input.fetch.onNext(())
    }
    
    private func configureCharactersTableView(_ tableView: UITableView) {
        viewModel.output.characters
            .drive(tableView.rx.items(cellIdentifier: CharacterTableViewCell.reuseIdentifier,
                                      cellType: CharacterTableViewCell.self)) { (_, character, cell) in
                                        cell.configure(withViewModel: self.viewModel.characterCellViewModel(for: character))
            }.disposed(by: disposeBag)
    }
}

// MARK: - HerosListRootViewResponder
extension HerosListViewController: HerosListRootViewResponder {
    func searchTapped() {
        viewModel.input.searchButtonTapped.onNext(())
    }
    
    func tabeViewItemSelected(indexPath: IndexPath) {
        viewModel.input.itemSelected.onNext(indexPath)
    }
    
    func tableViewDidReachEnd() {
        viewModel.input.fetch.onNext(())
    }
}
