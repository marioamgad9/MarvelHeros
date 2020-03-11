import UIKit
import Common

/// Handles searching for heros starting with the provided string
public class SearchHerosViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: SearchHerosRootView!
    
    // MARK: - Properties
    private let viewModel: SearchHerosViewModel
    
    // MARK: - Methods
    public init(viewModel: SearchHerosViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        rootView = SearchHerosRootView()
        view = rootView
    }
}
