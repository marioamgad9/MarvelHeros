import UIKit
import Common
import RxSwift

/// Handles showing the details of a single marvel character
public class HeroDetailsViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: HeroDetailsRootView!
    
    // MARK: - Properties
    private let viewModel: HeroDetailsViewModel
    
    // MARK: - Methods
    public init(viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        rootView = HeroDetailsRootView()
        view = rootView
    }
}
