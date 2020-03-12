import Common
import MarvelHerosKit
import HerosList

/**
 The root dependency container that contains the whole dependency graph for the app.
 It also handles creating child dependency containers if needed.
 */
public class MHAppDependencyContainer {
    
    // MARK: - Long-lived dependencies
    /// The shared root app coordinator
    public private(set) lazy var sharedAppCoordinator: MHAppCoordinator = {
        return MHAppCoordinator(rootVc: NiblessViewController(),
        herosListNavigationController: makeHerosListNavigationController(),
        herosListVcFactory: makeHerosListViewController,
        searchHerosVcFactory: makeSearchHerosViewController,
        heroDetailsVcFactory: makeHeroDetailsViewController(characterId:))
    }()
    
    /// The shared repository that feeds content from API
    public let sharedContentRepository: ContentRepository
    
    // MARK: - Initializer
    public init() {
        func makeContentRepository() -> MHContentRepository {
            return MHContentRepository()
        }
        
        sharedContentRepository = makeContentRepository()
    }
    
    // MARK: - Heros List
    public func makeHerosListNavigationController() -> HerosListNavigationController {
        return HerosListNavigationController()
    }
    
    public func makeHerosListViewController() -> HerosListViewController {
        return HerosListViewController(viewModel: makeHerosListViewModel())
    }
    
    public func makeHerosListViewModel() -> HerosListViewModel {
        return HerosListViewModel(contentRepository: sharedContentRepository,
                                  herosListNavigator: sharedAppCoordinator)
    }
    
    // MARK: - Search Heros
    public func makeSearchHerosViewController() -> SearchHerosViewController {
        return SearchHerosViewController(viewModel: makeSearchHerosViewModel())
    }
    
    public func makeSearchHerosViewModel() -> SearchHerosViewModel {
        return SearchHerosViewModel(contentRepository: sharedContentRepository,
                                    herosListNavigator: sharedAppCoordinator)
    }
    
    // MARK: - Hero Details
    public func makeHeroDetailsViewController(characterId: Int) -> HeroDetailsViewController {
        return HeroDetailsViewController(viewModel: makeHeroDetailsViewModel(characterId: characterId))
    }
    
    public func makeHeroDetailsViewModel(characterId: Int) -> HeroDetailsViewModel {
        return HeroDetailsViewModel(characterId: characterId,
                                    contentRepository: sharedContentRepository)
    }
}
