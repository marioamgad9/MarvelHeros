import MarvelHerosKit
import RxSwift
import RxCocoa

/// The view model for SearchHerosViewController
public class SearchHerosViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: SearchHerosViewModel.Input
    public let output: SearchHerosViewModel.Output
    
    public struct Input {
        
    }
    
    public struct Output {
        
    }
    
    // MARK: - Properties
    private let contentRepository: ContentRepository
    private let herosListNavigator: HerosListNavigator
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    public init(contentRepository: ContentRepository,
                herosListNavigator: HerosListNavigator) {
        self.contentRepository = contentRepository
        self.herosListNavigator = herosListNavigator
        
        input = Input()
        output = Output()
    }
}
