import Common
import HerosList

typealias HerosListVcFactory = () -> HerosListViewController
typealias SearchHerosVcFactory = () -> SearchHerosViewController

/**
 Handles coordination between the main app states (Heros list, and hero detail)
 It handles child coordinators for each subsystem if needed.
 */
public class MHAppCoordinator: Coordinator {
    
    // MARK: - Properties
    /// The view controller where all the other views are built upon
    public let rootVc: NiblessViewController
    
    /// The main navigation controller for HerosList
    private let herosListNavigationController: HerosListNavigationController
    
    // MARK: - Factories
    private let herosListVcFactory: HerosListVcFactory
    private let searchHerosVcFactory: SearchHerosVcFactory
    
    // MARK: - Methods
    /// Initializes a new app coordinators with the provided root view controller
    init(rootVc: NiblessViewController,
         herosListNavigationController: HerosListNavigationController,
         herosListVcFactory: @escaping HerosListVcFactory,
         searchHerosVcFactory: @escaping SearchHerosVcFactory) {
        self.rootVc = rootVc
        self.herosListNavigationController = herosListNavigationController
        self.herosListVcFactory = herosListVcFactory
        self.searchHerosVcFactory = searchHerosVcFactory
    }
    
    /// Starts the app coordinator flow, with attaching the heros list vc to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        herosListNavigationController.modalPresentationStyle = .fullScreen
        rootVc.present(herosListNavigationController, animated: false, completion: completionHandler)
        goToHerosListView()
    }
    
    /// Finishes the app coordinator flow
    public func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {}
    
    /// Navigates to the initial heros list view
    private func goToHerosListView() {
        herosListNavigationController.pushViewController(herosListVcFactory(), animated: true)
    }
    
    /// Navigates to the search heros view
    private func goToSearchHerosView() {
        let searchHerosVc = searchHerosVcFactory()
        searchHerosVc.modalPresentationStyle = .overFullScreen
        herosListNavigationController.present(searchHerosVc, animated: false)
    }
}

// MARK: - HerosListNavigator
extension MHAppCoordinator: HerosListNavigator {
    public func navigate(to view: HerosListViewState) {
        switch view {
        case .herosList:
            goToHerosListView()
        case .searchHeros:
            goToSearchHerosView()
        default:
            fatalError("Unsupported view navigation attempted")
        }
    }
}
