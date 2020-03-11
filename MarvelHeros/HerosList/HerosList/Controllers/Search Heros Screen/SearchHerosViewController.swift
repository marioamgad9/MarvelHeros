import UIKit
import Common
import RxSwift

/// Handles searching for heros starting with the provided string
public class SearchHerosViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: SearchHerosRootView!
    
    // MARK: - Properties
    private let viewModel: SearchHerosViewModel
    private let disposeBag = DisposeBag()
    
    // Status bar style
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    public init(viewModel: SearchHerosViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        rootView = SearchHerosRootView()
        view = rootView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animate root view entrance
        rootView.animateEntrance()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subscribe for UI events
        subscribeForCancelButtonTap()
    }
    
    private func subscribeForCancelButtonTap() {
        rootView.searchNavigationBar.cancelButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {
                self.rootView.animateOutro { _ in
                    self.dismiss(animated: false)
                }
            }).disposed(by: disposeBag)
    }
}
