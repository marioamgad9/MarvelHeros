import UIKit
import Common
import RxSwift

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
    }
    
    public override func loadView() {
        rootView = HerosListRootView()
        view = rootView
    }
}
