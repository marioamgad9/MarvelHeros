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
    
    // MARK: - Methods
    public init(viewModel: HerosListViewModel) {
        self.viewModel = viewModel
        super.init()
        
        viewModel.input.fetch.onNext(())
    }
    
    public override func loadView() {
        rootView = HerosListRootView(charactersTableViewConfigurator: configureCharactersTableView(_:))
        view = rootView
    }
    
    private func configureCharactersTableView(_ tableView: UITableView) {
        
        viewModel.output.characters
            .drive(tableView.rx.items(cellIdentifier: CharacterTableViewCell.reuseIdentifier,
                                      cellType: CharacterTableViewCell.self)) { (_, character, cell) in
                                        cell.configure(withViewModel: self.viewModel.characterCellViewModel(for: character))
            }.disposed(by: disposeBag)
    }
}
