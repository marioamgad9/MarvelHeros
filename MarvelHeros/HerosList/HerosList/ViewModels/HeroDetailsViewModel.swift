import MarvelHerosKit
import RxSwift
import RxCocoa

/// The viewmodel for HeroDetailsViewController
public class HeroDetailsViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: HeroDetailsViewModel.Input
    public let output: HeroDetailsViewModel.Output
    
    public struct Input {
        let fetch = PublishSubject<()>()
    }
    
    public struct Output {
        let character: Driver<MarvelCharacter>
        let isLoading: Driver<Bool>
        let errorMessage: Observable<ErrorMessage>
    }
    
    // MARK: - Properties
    private let characterId: Int
    private let contentRepository: ContentRepository
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let characterSubject = PublishSubject<MarvelCharacter>()
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Methods
    public init(characterId: Int, contentRepository: ContentRepository) {
        self.characterId = characterId
        self.contentRepository = contentRepository
        
        input = Input()
        output = Output(character: characterSubject.asDriver(onErrorJustReturn: MarvelCharacter.empty),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asObservable())
    }
}
