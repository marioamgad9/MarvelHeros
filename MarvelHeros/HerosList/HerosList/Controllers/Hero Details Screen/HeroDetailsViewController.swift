import UIKit
import Common
import RxSwift

/// Handles showing the details of a single marvel character
public class HeroDetailsViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: HeroDetailsRootView!
    
    // MARK: - Properties
    private let viewModel: HeroDetailsViewModel
    private let disposeBag = DisposeBag()
    
    // Status bar style
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    public init(viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func loadView() {
        rootView = HeroDetailsRootView(responder: self)
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subscribe for viewmodel events
        subscribeForCharacter()
        
        // Bind isLoading to activity indicator
        viewModel.output.isLoading
            .drive(rootView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Trigger fetch
        viewModel.input.fetch.onNext(())
    }
    
    private func subscribeForCharacter() {
        viewModel.output.character.drive(onNext: {
            // Configure background
            self.rootView.background.sd_setImage(with: $0.thumbnail.getUrl(quality: .fullSize))
            
            // Configure header
            let viewModel = HeroDetailsHeaderViewModel(character: $0)
            self.rootView.header.configure(withViewModel: viewModel)
        }).disposed(by: disposeBag)
    }
}

// MARK: - HeroDetailsRootViewResponder
extension HeroDetailsViewController: HeroDetailsRootViewResponder {
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
