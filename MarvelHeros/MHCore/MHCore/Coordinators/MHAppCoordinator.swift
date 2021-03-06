import Common
import HerosList

typealias HerosListVcFactory = () -> HerosListViewController
typealias SearchHerosVcFactory = () -> SearchHerosViewController
typealias HeroDetailsVcFactory = (Int) -> HeroDetailsViewController

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
    private let heroDetailsVcFactory: HeroDetailsVcFactory
    
    // MARK: - Methods
    /// Initializes a new app coordinators with the provided root view controller
    init(rootVc: NiblessViewController,
         herosListNavigationController: HerosListNavigationController,
         herosListVcFactory: @escaping HerosListVcFactory,
         searchHerosVcFactory: @escaping SearchHerosVcFactory,
         heroDetailsVcFactory: @escaping HeroDetailsVcFactory) {
        self.rootVc = rootVc
        self.herosListNavigationController = herosListNavigationController
        self.herosListVcFactory = herosListVcFactory
        self.searchHerosVcFactory = searchHerosVcFactory
        self.heroDetailsVcFactory = heroDetailsVcFactory
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
    
    /// Navigates to the hero details view
    private func goToHeroDetailsView(characterId: Int) {
        herosListNavigationController.pushViewController(heroDetailsVcFactory(characterId), animated: true)
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
        case .heroDetails(let characterId):
            goToHeroDetailsView(characterId: characterId)
        }
    }
}
