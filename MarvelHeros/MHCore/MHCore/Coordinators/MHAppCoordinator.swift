import Common
import HerosList

/**
 Handles coordination between the main app states (Heros list, and hero detail)
 It handles child coordinators for each subsystem if needed.
 */
public class MHAppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    /// The view controller where all the other views are built upon
    public let rootVc: NiblessViewController
    
    // MARK: - Methods
    
    /// Initializes a new app coordinators with the provided root view controller
    init(rootVc: NiblessViewController) {
        self.rootVc = rootVc
    }
    
    /// Starts the app coordinator flow, with attaching the heros list vc to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        
    }
    
    /// Finishes the app coordinator flow
    public func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {}
}

// MARK: - HerosListNavigator
extension MHAppCoordinator: HerosListNavigator {
    public func navigate(to view: HerosListViewState) {
        
    }
}
