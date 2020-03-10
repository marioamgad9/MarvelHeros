import Common
import MarvelHerosKit

/**
 The root dependency container that contains the whole dependency graph for the app.
 It also handles creating child dependency containers if needed.
 */
public class MHAppDependencyContainer {
    
    // MARK: - Long-lived dependencies
    /// The shared root app coordinator
    public let sharedAppCoordinator: MHAppCoordinator
    
    /// The shared repository that feeds content from API
    public let sharedContentRepository: ContentRepository
    
    // MARK: - Initializer
    public init() {
        func makeAppCoordinator() -> MHAppCoordinator {
            return MHAppCoordinator(rootVc: NiblessViewController())
        }
        
        func makeContentRepository() -> MHContentRepository {
            return MHContentRepository()
        }
        
        sharedAppCoordinator = makeAppCoordinator()
        sharedContentRepository = makeContentRepository()
    }
}
